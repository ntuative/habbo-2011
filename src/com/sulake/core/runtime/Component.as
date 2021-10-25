package com.sulake.core.runtime
{

    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.core.assets.AssetLibrary;
    import com.sulake.core.runtime.exceptions.InvalidComponentException;

    import flash.events.IEventDispatcher;

    import com.sulake.core.runtime.exceptions.ComponentDisposedException;

    import flash.utils.getQualifiedClassName;
    import flash.events.Event;

    import com.sulake.core.runtime.events.LockEvent;

    public class Component implements IUnknown
    {

        public static const COMPONENT_EVENT_RUNNING: String = "COMPONENT_EVENT_RUNNING";
        public static const COMPONENT_EVENT_DISPOSING: String = "COMPONENT_EVENT_DISPOSING";
        public static const COMPONENT_EVENT_WARNING: String = "COMPONENT_EVENT_WARNING";
        public static const COMPONENT_EVENT_ERROR: String = "COMPONENT_EVENT_ERROR";
        public static const COMPONENT_EVENT_DEBUG: String = "COMPONENT_EVENT_DEBUG";
        protected static const INTERNAL_EVENT_UNLOCKED: String = "_INTERNAL_EVENT_UNLOCKED";
        public static const COMPONENT_FLAG_NULL: uint = 0;
        public static const COMPONENT_FLAG_DISPOSABLE: uint = 1;
        public static const COMPONENT_FLAG_CONTEXT: uint = 2;
        public static const COMPONENT_FLAG_INTERFACE: uint = 4;

        protected var _references: uint = 0;
        protected var _lastError: String = "";
        protected var _lastDebug: String = "";
        protected var _lastWarning: String = "";
        private var _assets: IAssetLibrary;
        private var _events: EventDispatcher;
        private var _flags: uint;
        private var _interfaceStructList: InterfaceStructList;
        private var _context: IContext = null;
        private var _disposed: Boolean = false;
        private var _locked: Boolean = false;

        public function Component(ctx: IContext, flags: uint = 0, assetLibrary: IAssetLibrary = null)
        {
            this._flags = flags;
            this._interfaceStructList = new InterfaceStructList();
            this._events = new EventDispatcher();
            this._context = ctx;
            this._assets = assetLibrary != null ? assetLibrary : new AssetLibrary("_internal_asset_library");

            if (this._context == null)
            {
                throw new InvalidComponentException("IContext not provided to Component's constructor!");
            }

        }

        public static function getInterfaceStructList(component: Component): InterfaceStructList
        {
            return component._interfaceStructList;
        }

        public function get locked(): Boolean
        {
            return this._locked;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get context(): IContext
        {
            return this._context;
        }

        public function get events(): IEventDispatcher
        {
            return this._events;
        }

        public function get assets(): IAssetLibrary
        {
            return this._assets;
        }

        public function queueInterface(iid: IID, callback: Function = null): IUnknown
        {
            var interfaceStruct: InterfaceStruct = this._interfaceStructList.getStructByInterface(iid);

            if (interfaceStruct == null)
            {
                return this._context.queueInterface(iid, callback);
            }


            if (this._disposed)
            {
                throw new ComponentDisposedException("Failed to queue interface trough disposed Component \"" + getQualifiedClassName(this) + "\"!");
            }


            if (this._locked)
            {
                return null;
            }


            interfaceStruct.reserve();

            var unknown: IUnknown = interfaceStruct.unknown as IUnknown;

            if (callback != null)
            {
                callback(iid, unknown);
            }


            return unknown;
        }

        public function release(iid: IID): uint
        {
            if (this._disposed)
            {
                return 0;
            }


            var interfaceStruct: InterfaceStruct = this._interfaceStructList.getStructByInterface(iid);

            if (interfaceStruct == null)
            {
                this._lastError = "Attempting to release unknown interface:" + iid + "!";
                throw new Error(this._lastError);
            }


            var releaseId: uint = interfaceStruct.release();

            if (this._flags & COMPONENT_FLAG_INTERFACE)
            {
                if (releaseId == 0)
                {
                    if (this._interfaceStructList.getTotalReferenceCount() == 0)
                    {
                        this._context.detachComponent(this);
                        this.dispose();
                    }

                }

            }


            return releaseId;
        }

        public function dispose(): void
        {
            if (!this._disposed)
            {
                Logger.log("Disposing component " + getQualifiedClassName(this));
                this._events.dispatchEvent(new Event(Component.COMPONENT_EVENT_DISPOSING));
                this._events = null;
                this._interfaceStructList.dispose();
                this._interfaceStructList = null;
                this._assets.dispose();
                this._assets = null;
                this._context = null;
                this._references = 0;
                this._disposed = true;
            }

        }

        final protected function lock(): void
        {
            if (!this._locked)
            {
                this._locked = true;
            }

        }

        final protected function unlock(): void
        {
            if (this._locked)
            {
                this._locked = false;
                this._events.dispatchEvent(new LockEvent(INTERNAL_EVENT_UNLOCKED, this));
            }

        }

        public function toString(): String
        {
            return "[component " + getQualifiedClassName(this) + " refs: " + this._references + "]";
        }

        public function toXMLString(param1: uint = 0): String
        {
            var _loc6_: InterfaceStruct;
            var _loc2_: String = "";
            var _loc3_: uint;
            while (_loc3_ < param1)
            {
                _loc2_ = _loc2_ + "\t";
                _loc3_++;
            }

            var _loc4_: String = getQualifiedClassName(this);
            var _loc5_: String = "";
            _loc5_ = _loc5_ + (_loc2_ + "<component class=\"" + _loc4_ + "\">\n");
            var _loc7_: uint = this._interfaceStructList.length;
            var _loc8_: uint;
            while (_loc8_ < _loc7_)
            {
                _loc6_ = this._interfaceStructList.getStructByIndex(_loc8_);
                _loc5_ = _loc5_ + (_loc2_ + "\t<interface iid=\"" + _loc6_.iis + "\" refs=\"" + _loc6_.references + "\"/>\n");
                _loc8_++;
            }

            return _loc5_ + (_loc2_ + "</component>\n");
        }

        public function registerUpdateReceiver(receiver: IUpdateReceiver, param2: uint): void
        {
            this._context.registerUpdateReceiver(receiver, param2);
        }

        public function removeUpdateReceiver(receiver: IUpdateReceiver): void
        {
            this._context.removeUpdateReceiver(receiver);
        }

    }
}
