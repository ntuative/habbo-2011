package com.sulake.core.window.services
{

    import com.sulake.core.window.components.IToolTipWindow;

    import flash.utils.Timer;
    import flash.geom.Point;
    import flash.display.DisplayObject;

    import com.sulake.core.window.components.IInteractiveWindow;

    import flash.events.TimerEvent;

    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.enum.WindowParam;

    public class WindowToolTipAgent extends WindowMouseOperator implements IToolTipAgentService
    {

        protected var var_2005: String;
        protected var var_2284: IToolTipWindow;
        protected var var_2285: Timer;

        protected var var_2287: Point = new Point();
        protected var var_2286: Point = new Point(20, 20);
        protected var var_2006: uint = 500;

        public function WindowToolTipAgent(param1: DisplayObject)
        {
            super(param1);
        }

        override public function begin(param1: IWindow, param2: uint = 0): IWindow
        {
            if (param1 && !param1.disposed)
            {
                if (param1 is IInteractiveWindow)
                {
                    this.var_2005 = IInteractiveWindow(param1).toolTipCaption;
                    this.var_2006 = IInteractiveWindow(param1).toolTipDelay;
                }
                else
                {
                    this.var_2005 = param1.caption;
                    this.var_2006 = 500;
                }

                _mouse.x = var_2274.mouseX;
                _mouse.y = var_2274.mouseY;
                getMousePositionRelativeTo(param1, _mouse, this.var_2287);
                if (this.var_2005 != null && this.var_2005 != "")
                {
                    if (this.var_2285 == null)
                    {
                        this.var_2285 = new Timer(this.var_2006, 1);
                        this.var_2285.addEventListener(TimerEvent.TIMER, this.showToolTip);
                    }

                    this.var_2285.reset();
                    this.var_2285.start();
                }

            }

            return super.begin(param1, param2);
        }

        override public function end(param1: IWindow): IWindow
        {
            if (this.var_2285 != null)
            {
                this.var_2285.stop();
                this.var_2285.removeEventListener(TimerEvent.TIMER, this.showToolTip);
                this.var_2285 = null;
            }

            this.hideToolTip();
            return super.end(param1);
        }

        override public function operate(param1: int, param2: int): void
        {
            if (_window && !_window.disposed)
            {
                _mouse.x = param1;
                _mouse.y = param2;
                getMousePositionRelativeTo(_window, _mouse, this.var_2287);
                if (this.var_2284 != null && !this.var_2284.disposed)
                {
                    this.var_2284.x = param1 + this.var_2286.x;
                    this.var_2284.y = param2 + this.var_2286.y;
                }

            }

        }

        protected function showToolTip(param1: TimerEvent): void
        {
            var _loc2_: Point;
            if (this.var_2285 != null)
            {
                this.var_2285.reset();
            }

            if (_window && !_window.disposed)
            {
                if (this.var_2284 == null || this.var_2284.disposed)
                {
                    this.var_2284 = (_window.context.create(_window.name + "::ToolTip", this.var_2005, WindowType.var_203, _window.style, WindowParam.var_691 | WindowParam.var_694, null, null, null, 0, null, null) as IToolTipWindow);
                }

                _loc2_ = new Point();
                _window.getGlobalPosition(_loc2_);
                this.var_2284.x = _loc2_.x + this.var_2287.x + this.var_2286.x;
                this.var_2284.y = _loc2_.y + this.var_2287.y + this.var_2286.y;
            }

        }

        protected function hideToolTip(): void
        {
            if (this.var_2284 != null && !this.var_2284.disposed)
            {
                this.var_2284.destroy();
                this.var_2284 = null;
            }

        }

    }
}
