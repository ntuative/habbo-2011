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

        public static const var_1055: uint = 0;
        public static const var_1056: uint = 1;
        public static const var_1057: int = 0;
        public static const var_1058: int = 1;
        public static const var_1059: int = 2;
        public static const var_1060: int = 3;
        public static const var_1061: int = 4;
        public static const var_1062: int = 5;
        public static var var_208: IEventQueue;
        private static var var_1065: IEventProcessor;
        private static var var_1064: uint = var_1055;//0
        private static var stage: Stage;
        private static var var_1063: IWindowRenderer;

        private var var_2345: EventProcessorState;
        private var var_2344: IWindowContextStateListener;
        protected var _localization: ICoreLocalizationManager;
        protected var var_2343: DisplayObjectContainer;
        protected var var_2346: Boolean = true;
        protected var _lastError: Error;
        protected var _lastErrorCode: int = -1;
        protected var _windowServices: IInternalWindowServices;
        protected var _windowParser: IWindowParser;
        protected var _windowFactory: IWindowFactory;
        protected var _desktopWindow: IDesktopWindow;
        protected var var_2351: SubstituteParentController;
        private var _disposed: Boolean = false;
        private var var_2018: Boolean = false;
        private var var_2352: Boolean = false;
        private var _name: String;

        public function WindowContext(param1: String, param2: IWindowRenderer, param3: IWindowFactory, param4: ICoreLocalizationManager, param5: DisplayObjectContainer, param6: Rectangle, param7: IWindowContextStateListener)
        {
            this._name = param1;
            var_1063 = param2;
            this._localization = param4;
            this.var_2343 = param5;
            this._windowServices = new ServiceManager(this, param5);
            this._windowFactory = param3;
            this._windowParser = new WindowParser(this);
            this.var_2344 = param7;
            if (!stage)
            {
                if (this.var_2343 is Stage)
                {
                    stage = (this.var_2343 as Stage);
                }
                else
                {
                    if (this.var_2343.stage)
                    {
                        stage = this.var_2343.stage;
                    }

                }

            }

            Classes.init();
            if (param6 == null)
            {
                param6 = new Rectangle(0, 0, 800, 600);
            }

            this._desktopWindow = new DesktopController("_CONTEXT_DESKTOP_" + this._name, this, param6);
            this._desktopWindow.limits.maxWidth = param6.width;
            this._desktopWindow.limits.maxHeight = param6.height;
            this.var_2343.addChild(this._desktopWindow.getDisplayObject());
            this.var_2343.doubleClickEnabled = true;
            this.var_2343.addEventListener(Event.RESIZE, this.stageResizedHandler);
            this.var_2345 = new EventProcessorState(var_1063, this._desktopWindow, this._desktopWindow, null, this.var_2344);
            inputMode = var_1055;
            this.var_2351 = new SubstituteParentController(this);
        }

        public static function get inputMode(): uint
        {
            return var_1064;
        }

        public static function set inputMode(value: uint): void
        {
            if (var_208)
            {
                if (var_208 is IDisposable)
                {
                    IDisposable(var_208).dispose();
                }

            }

            if (var_1065)
            {
                if (var_1065 is IDisposable)
                {
                    IDisposable(var_1065).dispose();
                }

            }

            switch (value)
            {
                case var_1055:
                    var_208 = new MouseEventQueue(stage);
                    var_1065 = new MouseEventProcessor();
                    try
                    {
                    }
                    catch (e: Error)
                    {
                    }

                    return;
                case var_1056:
                    var_208 = new TabletEventQueue(stage);
                    var_1065 = new TabletEventProcessor();
                    try
                    {
                    }
                    catch (e: Error)
                    {
                    }

                    return;
                default:
                    inputMode = var_1055;
                    throw new Error("Unknown input mode " + value);
            }

        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function dispose(): void
        {
            if (!this._disposed)
            {
                this._disposed = true;
                this.var_2343.removeEventListener(Event.RESIZE, this.stageResizedHandler);
                this.var_2343.removeChild(IGraphicContextHost(this._desktopWindow)
                                                  .getGraphicContext(true) as DisplayObject);
                this._desktopWindow.destroy();
                this._desktopWindow = null;
                this.var_2351.destroy();
                this.var_2351 = null;
                if (this._windowServices is IDisposable)
                {
                    IDisposable(this._windowServices).dispose();
                }

                this._windowServices = null;
                this._windowParser.dispose();
                this._windowParser = null;
                var_1063 = null;
            }

        }

        public function getLastError(): Error
        {
            return this._lastError;
        }

        public function getLastErrorCode(): int
        {
            return this._lastErrorCode;
        }

        public function handleError(errorCode: int, error: Error): void
        {
            this._lastError = error;
            this._lastErrorCode = errorCode;

            if (this.var_2346)
            {
                throw error;
            }

        }

        public function flushError(): void
        {
            this._lastError = null;
            this._lastErrorCode = -1;
        }

        public function getWindowServices(): IInternalWindowServices
        {
            return this._windowServices;
        }

        public function getWindowParser(): IWindowParser
        {
            return this._windowParser;
        }

        public function getWindowFactory(): IWindowFactory
        {
            return this._windowFactory;
        }

        public function getDesktopWindow(): IDesktopWindow
        {
            return this._desktopWindow;
        }

        public function findWindowByName(param1: String): IWindow
        {
            return this._desktopWindow.findChildByName(param1);
        }

        public function registerLocalizationListener(param1: String, param2: IWindow): void
        {
            this._localization.registerListener(param1, param2 as ILocalizable);
        }

        public function removeLocalizationListener(param1: String, param2: IWindow): void
        {
            this._localization.removeListener(param1, param2 as ILocalizable);
        }

        public function create(param1: String, param2: String, param3: uint, param4: uint, param5: uint, param6: Rectangle, param7: Function, param8: IWindow, param9: uint, param10: Array = null, param11: Array = null): IWindow
        {
            var _loc12_: IWindow;
            var _loc13_: Class = Classes.getWindowClassByType(param3);
            if (_loc13_ == null)
            {
                this.handleError(WindowContext.var_1061, new Error("Failed to solve implementation for window \"" + param1 + "\"!"));
                return null;
            }

            if (param8 == null)
            {
                if (param5 & WindowParam.var_693)
                {
                    param8 = this.var_2351;
                }

            }

            _loc12_ = new _loc13_(param1, param3, param4, param5, this, param6, param8 != null
                    ? param8
                    : this._desktopWindow, param7, param10, param11, param9);
            if (param2 && param2.length)
            {
                _loc12_.caption = param2;
            }

            return _loc12_;
        }

        public function destroy(param1: IWindow): Boolean
        {
            if (param1 == this._desktopWindow)
            {
                this._desktopWindow = null;
            }

            if (param1.state != WindowState.var_991)
            {
                param1.destroy();
            }

            return true;
        }

        public function invalidate(param1: IWindow, param2: Rectangle, param3: uint): void
        {
            if (!this.disposed)
            {
                var_1063.addToRenderQueue(WindowController(param1), param2, param3);
            }

        }

        public function update(param1: uint): void
        {
            this.var_2018 = true;
            if (this._lastError)
            {
                throw this._lastError;
            }

            var_1065.process(this.var_2345, var_208);
            this.var_2018 = false;
        }

        public function render(param1: uint): void
        {
            this.var_2352 = true;
            var_1063.update(param1);
            this.var_2352 = false;
        }

        private function stageResizedHandler(param1: Event): void
        {
            if (this._desktopWindow != null && !this._desktopWindow.disposed)
            {
                if (this.var_2343 is Stage)
                {
                    this._desktopWindow.limits.maxWidth = Stage(this.var_2343).stageWidth;
                    this._desktopWindow.limits.maxHeight = Stage(this.var_2343).stageHeight;
                    this._desktopWindow.width = Stage(this.var_2343).stageWidth;
                    this._desktopWindow.height = Stage(this.var_2343).stageHeight;
                }
                else
                {
                    this._desktopWindow.limits.maxWidth = this.var_2343.width;
                    this._desktopWindow.limits.maxHeight = this.var_2343.height;
                    this._desktopWindow.width = this.var_2343.width;
                    this._desktopWindow.height = this.var_2343.height;
                }

            }

        }

    }
}
