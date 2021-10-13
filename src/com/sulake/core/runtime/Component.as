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

        public static const COMPONENT_EVENT_RUNNING:String = "COMPONENT_EVENT_RUNNING";
        public static const COMPONENT_EVENT_DISPOSING:String = "COMPONENT_EVENT_DISPOSING";
        public static const COMPONENT_EVENT_WARNING:String = "COMPONENT_EVENT_WARNING";
        public static const COMPONENT_EVENT_ERROR:String = "COMPONENT_EVENT_ERROR";
        public static const COMPONENT_EVENT_DEBUG:String = "COMPONENT_EVENT_DEBUG";
        protected static const var_41:String = "_INTERNAL_EVENT_UNLOCKED";
        public static const COMPONENT_FLAG_NULL:uint = 0;
        public static const var_39:uint = 1;
        public static const COMPONENT_FLAG_CONTEXT:uint = 2;
        public static const var_40:uint = 4;

        protected var var_2174:uint = 0;
        protected var var_287:String = "";
        protected var var_286:String = "";
        protected var _lastWarning:String = "";
        private var _assets:IAssetLibrary;
        private var _events:EventDispatcher;
        private var var_2175:uint;
        private var var_2176:InterfaceStructList;
        private var _context:IContext = null;
        private var _disposed:Boolean = false;
        private var var_2173:Boolean = false;

        public function Component(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            this.var_2175 = param2;
            this.var_2176 = new InterfaceStructList();
            this._events = new EventDispatcher();
            this._context = param1;
            this._assets = ((param3 != null) ? param3 : new AssetLibrary("_internal_asset_library"));
            if (this._context == null)
            {
                throw (new InvalidComponentException("IContext not provided to Component's constructor!"));
            };
        }

        public static function getInterfaceStructList(param1:Component):InterfaceStructList
        {
            return (param1.var_2176);
        }

        public function get locked():Boolean
        {
            return (this.var_2173);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get context():IContext
        {
            return (this._context);
        }

        public function get events():IEventDispatcher
        {
            return (this._events);
        }

        public function get assets():IAssetLibrary
        {
            return (this._assets);
        }

        public function queueInterface(param1:IID, param2:Function=null):IUnknown
        {
            var _loc3_:InterfaceStruct = this.var_2176.getStructByInterface(param1);
            if (_loc3_ == null)
            {
                return (this._context.queueInterface(param1, param2));
            };
            if (this._disposed)
            {
                throw (new ComponentDisposedException((('Failed to queue interface trough disposed Component "' + getQualifiedClassName(this)) + '"!')));
            };
            if (this.var_2173)
            {
                return (null);
            };
            _loc3_.reserve();
            var _loc4_:IUnknown = (_loc3_.unknown as IUnknown);
            if (param2 != null)
            {
                (param2(param1, _loc4_));
            };
            return (_loc4_);
        }

        public function release(param1:IID):uint
        {
            if (this._disposed)
            {
                return (0);
            };
            var _loc2_:InterfaceStruct = this.var_2176.getStructByInterface(param1);
            if (_loc2_ == null)
            {
                this.var_287 = (("Attempting to release unknown interface:" + param1) + "!");
                throw (new Error(this.var_287));
            };
            var _loc3_:uint = _loc2_.release();
            if ((this.var_2175 & var_40))
            {
                if (_loc3_ == 0)
                {
                    if (this.var_2176.getTotalReferenceCount() == 0)
                    {
                        this._context.detachComponent(this);
                        this.dispose();
                    };
                };
            };
            return (_loc3_);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                Logger.log(("Disposing component " + getQualifiedClassName(this)));
                this._events.dispatchEvent(new Event(Component.COMPONENT_EVENT_DISPOSING));
                this._events = null;
                this.var_2176.dispose();
                this.var_2176 = null;
                this._assets.dispose();
                this._assets = null;
                this._context = null;
                this.var_2174 = 0;
                this._disposed = true;
            };
        }

        final protected function lock():void
        {
            if (!this.var_2173)
            {
                this.var_2173 = true;
            };
        }

        final protected function unlock():void
        {
            if (this.var_2173)
            {
                this.var_2173 = false;
                this._events.dispatchEvent(new LockEvent(var_41, this));
            };
        }

        public function toString():String
        {
            return (((("[component " + getQualifiedClassName(this)) + " refs: ") + this.var_2174) + "]");
        }

        public function toXMLString(param1:uint=0):String
        {
            var _loc6_:InterfaceStruct;
            var _loc2_:String = "";
            var _loc3_:uint;
            while (_loc3_ < param1)
            {
                _loc2_ = (_loc2_ + "\t");
                _loc3_++;
            };
            var _loc4_:String = getQualifiedClassName(this);
            var _loc5_:String = "";
            _loc5_ = (_loc5_ + (((_loc2_ + '<component class="') + _loc4_) + '">\n'));
            var _loc7_:uint = this.var_2176.length;
            var _loc8_:uint;
            while (_loc8_ < _loc7_)
            {
                _loc6_ = this.var_2176.getStructByIndex(_loc8_);
                _loc5_ = (_loc5_ + (((((_loc2_ + '\t<interface iid="') + _loc6_.iis) + '" refs="') + _loc6_.references) + '"/>\n'));
                _loc8_++;
            };
            return (_loc5_ + (_loc2_ + "</component>\n"));
        }

        public function registerUpdateReceiver(param1:IUpdateReceiver, param2:uint):void
        {
            this._context.registerUpdateReceiver(param1, param2);
        }

        public function removeUpdateReceiver(param1:IUpdateReceiver):void
        {
            this._context.removeUpdateReceiver(param1);
        }

    }
}