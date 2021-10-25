package com.sulake.core.window.components
{

    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.WindowContext;

    import flash.geom.Rectangle;

    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.WindowController;

    public class ActivatorController extends ContainerController
    {

        protected var _activeChild: IWindow;

        public function ActivatorController(param1: String, param2: uint, param3: uint, param4: uint, param5: WindowContext, param6: Rectangle, param7: IWindow, param8: Function = null, param9: Array = null, param10: Array = null, param11: uint = 0)
        {
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
        }

        override public function update(param1: WindowController, param2: WindowEvent): Boolean
        {
            if (param2.type == WindowEvent.var_584)
            {
                this.setActiveChild(param1 as IWindow);
            }
            else
            {
                if (param2.type == WindowEvent.var_589)
                {
                    return true;
                }

            }

            return super.update(param1, param2);
        }

        public function getActiveChild(): IWindow
        {
            return this._activeChild;
        }

        public function setActiveChild(window: IWindow): IWindow
        {
            if (window.parent != this)
            {
                while (true)
                {
                    window = window.parent;

                    if (window == null)
                    {
                        throw new Error("Window passed to activator is not a child!");
                    }


                    if (window.parent == this)
                    {
                        break;
                    }
                }

            }


            var previous: IWindow = this._activeChild;

            if (this._activeChild != window)
            {
                if (this._activeChild != null)
                {
                    if (!this._activeChild.disposed)
                    {
                        this._activeChild.deactivate();
                    }

                }


                this._activeChild = window;

                if (getChildIndex(window) != numChildren - 1)
                {
                    setChildIndex(window, numChildren - 1);
                }

            }


            return previous;
        }

    }
}
