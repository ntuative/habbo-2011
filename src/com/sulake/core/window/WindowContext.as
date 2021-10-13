package com.sulake.core.window
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.window.utils.IEventQueue;
    import com.sulake.core.window.utils.IEventProcessor;
    import flash.display.Stage;
    import com.sulake.core.window.graphics.IWindowRenderer;
    import com.sulake.core.window.utils.EventProcessorState;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import flash.display.DisplayObjectContainer;
    import com.sulake.core.window.services.IInternalWindowServices;
    import com.sulake.core.window.utils.IWindowParser;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.window.components.SubstituteParentController;
    import com.sulake.core.window.services.ServiceManager;
    import com.sulake.core.window.utils.WindowParser;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.DesktopController;
    import flash.events.Event;
    import com.sulake.core.window.utils.MouseEventQueue;
    import com.sulake.core.window.utils.MouseEventProcessor;
    import com.sulake.core.window.utils.tablet.TabletEventQueue;
    import com.sulake.core.window.utils.tablet.TabletEventProcessor;
    import com.sulake.core.window.graphics.IGraphicContextHost;
    import flash.display.DisplayObject;
    import com.sulake.core.localization.ILocalizable;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.enum.WindowState;

    public class WindowContext implements IWindowContext, IDisposable, IUpdateReceiver 
    {

        public static const var_1055:uint = 0;
        public static const var_1056:uint = 1;
        public static const var_1057:int = 0;
        public static const var_1058:int = 1;
        public static const var_1059:int = 2;
        public static const var_1060:int = 3;
        public static const var_1061:int = 4;
        public static const var_1062:int = 5;
        public static var var_208:IEventQueue;
        private static var var_1065:IEventProcessor;
        private static var var_1064:uint = var_1055;//0
        private static var stage:Stage;
        private static var var_1063:IWindowRenderer;

        private var var_2345:EventProcessorState;
        private var var_2344:IWindowContextStateListener;
        protected var _localization:ICoreLocalizationManager;
        protected var var_2343:DisplayObjectContainer;
        protected var var_2346:Boolean = true;
        protected var var_287:Error;
        protected var var_2347:int = -1;
        protected var var_2348:IInternalWindowServices;
        protected var var_2349:IWindowParser;
        protected var var_2350:IWindowFactory;
        protected var var_2060:IDesktopWindow;
        protected var var_2351:SubstituteParentController;
        private var _disposed:Boolean = false;
        private var var_2018:Boolean = false;
        private var var_2352:Boolean = false;
        private var _name:String;

        public function WindowContext(param1:String, param2:IWindowRenderer, param3:IWindowFactory, param4:ICoreLocalizationManager, param5:DisplayObjectContainer, param6:Rectangle, param7:IWindowContextStateListener)
        {
            this._name = param1;
            var_1063 = param2;
            this._localization = param4;
            this.var_2343 = param5;
            this.var_2348 = new ServiceManager(this, param5);
            this.var_2350 = param3;
            this.var_2349 = new WindowParser(this);
            this.var_2344 = param7;
            if (!stage)
            {
                if ((this.var_2343 is Stage))
                {
                    stage = (this.var_2343 as Stage);
                }
                else
                {
                    if (this.var_2343.stage)
                    {
                        stage = this.var_2343.stage;
                    };
                };
            };
            Classes.init();
            if (param6 == null)
            {
                param6 = new Rectangle(0, 0, 800, 600);
            };
            this.var_2060 = new DesktopController(("_CONTEXT_DESKTOP_" + this._name), this, param6);
            this.var_2060.limits.maxWidth = param6.width;
            this.var_2060.limits.maxHeight = param6.height;
            this.var_2343.addChild(this.var_2060.getDisplayObject());
            this.var_2343.doubleClickEnabled = true;
            this.var_2343.addEventListener(Event.RESIZE, this.stageResizedHandler);
            this.var_2345 = new EventProcessorState(var_1063, this.var_2060, this.var_2060, null, this.var_2344);
            inputMode = var_1055;
            this.var_2351 = new SubstituteParentController(this);
        }

        public static function get inputMode():uint
        {
            return (var_1064);
        }

        public static function set inputMode(value:uint):void
        {
            if (var_208)
            {
                if ((var_208 is IDisposable))
                {
                    IDisposable(var_208).dispose();
                };
            };
            if (var_1065)
            {
                if ((var_1065 is IDisposable))
                {
                    IDisposable(var_1065).dispose();
                };
            };
            switch (value)
            {
                case var_1055:
                    var_208 = new MouseEventQueue(stage);
                    var_1065 = new MouseEventProcessor();
                    try
                    {
                    }
                    catch(e:Error)
                    {
                    };
                    return;
                case var_1056:
                    var_208 = new TabletEventQueue(stage);
                    var_1065 = new TabletEventProcessor();
                    try
                    {
                    }
                    catch(e:Error)
                    {
                    };
                    return;
                default:
                    inputMode = var_1055;
                    throw (new Error(("Unknown input mode " + value)));
            };
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this._disposed = true;
                this.var_2343.removeEventListener(Event.RESIZE, this.stageResizedHandler);
                this.var_2343.removeChild((IGraphicContextHost(this.var_2060).getGraphicContext(true) as DisplayObject));
                this.var_2060.destroy();
                this.var_2060 = null;
                this.var_2351.destroy();
                this.var_2351 = null;
                if ((this.var_2348 is IDisposable))
                {
                    IDisposable(this.var_2348).dispose();
                };
                this.var_2348 = null;
                this.var_2349.dispose();
                this.var_2349 = null;
                var_1063 = null;
            };
        }

        public function getLastError():Error
        {
            return (this.var_287);
        }

        public function getLastErrorCode():int
        {
            return (this.var_2347);
        }

        public function handleError(param1:int, param2:Error):void
        {
            this.var_287 = param2;
            this.var_2347 = param1;
            if (this.var_2346)
            {
                throw (param2);
            };
        }

        public function flushError():void
        {
            this.var_287 = null;
            this.var_2347 = -1;
        }

        public function getWindowServices():IInternalWindowServices
        {
            return (this.var_2348);
        }

        public function getWindowParser():IWindowParser
        {
            return (this.var_2349);
        }

        public function getWindowFactory():IWindowFactory
        {
            return (this.var_2350);
        }

        public function getDesktopWindow():IDesktopWindow
        {
            return (this.var_2060);
        }

        public function findWindowByName(param1:String):IWindow
        {
            return (this.var_2060.findChildByName(param1));
        }

        public function registerLocalizationListener(param1:String, param2:IWindow):void
        {
            this._localization.registerListener(param1, (param2 as ILocalizable));
        }

        public function removeLocalizationListener(param1:String, param2:IWindow):void
        {
            this._localization.removeListener(param1, (param2 as ILocalizable));
        }

        public function create(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:Rectangle, param7:Function, param8:IWindow, param9:uint, param10:Array=null, param11:Array=null):IWindow
        {
            var _loc12_:IWindow;
            var _loc13_:Class = Classes.getWindowClassByType(param3);
            if (_loc13_ == null)
            {
                this.handleError(WindowContext.var_1061, new Error((('Failed to solve implementation for window "' + param1) + '"!')));
                return (null);
            };
            if (param8 == null)
            {
                if ((param5 & WindowParam.var_693))
                {
                    param8 = this.var_2351;
                };
            };
            _loc12_ = new _loc13_(param1, param3, param4, param5, this, param6, ((param8 != null) ? param8 : this.var_2060), param7, param10, param11, param9);
            if (((param2) && (param2.length)))
            {
                _loc12_.caption = param2;
            };
            return (_loc12_);
        }

        public function destroy(param1:IWindow):Boolean
        {
            if (param1 == this.var_2060)
            {
                this.var_2060 = null;
            };
            if (param1.state != WindowState.var_991)
            {
                param1.destroy();
            };
            return (true);
        }

        public function invalidate(param1:IWindow, param2:Rectangle, param3:uint):void
        {
            if (!this.disposed)
            {
                var_1063.addToRenderQueue(WindowController(param1), param2, param3);
            };
        }

        public function update(param1:uint):void
        {
            this.var_2018 = true;
            if (this.var_287)
            {
                throw (this.var_287);
            };
            var_1065.process(this.var_2345, var_208);
            this.var_2018 = false;
        }

        public function render(param1:uint):void
        {
            this.var_2352 = true;
            var_1063.update(param1);
            this.var_2352 = false;
        }

        private function stageResizedHandler(param1:Event):void
        {
            if (((!(this.var_2060 == null)) && (!(this.var_2060.disposed))))
            {
                if ((this.var_2343 is Stage))
                {
                    this.var_2060.limits.maxWidth = Stage(this.var_2343).stageWidth;
                    this.var_2060.limits.maxHeight = Stage(this.var_2343).stageHeight;
                    this.var_2060.width = Stage(this.var_2343).stageWidth;
                    this.var_2060.height = Stage(this.var_2343).stageHeight;
                }
                else
                {
                    this.var_2060.limits.maxWidth = this.var_2343.width;
                    this.var_2060.limits.maxHeight = this.var_2343.height;
                    this.var_2060.width = this.var_2343.width;
                    this.var_2060.height = this.var_2343.height;
                };
            };
        }

    }
}