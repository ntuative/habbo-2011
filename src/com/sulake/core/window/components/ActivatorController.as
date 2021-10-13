package com.sulake.core.window.components
{
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.WindowController;

    public class ActivatorController extends ContainerController 
    {

        protected var var_1982:IWindow;

        public function ActivatorController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function=null, param9:Array=null, param10:Array=null, param11:uint=0)
        {
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
        }

        override public function update(param1:WindowController, param2:WindowEvent):Boolean
        {
            if (param2.type == WindowEvent.var_584)
            {
                this.setActiveChild((param1 as IWindow));
            }
            else
            {
                if (param2.type == WindowEvent.var_589)
                {
                    return (true);
                };
            };
            return (super.update(param1, param2));
        }

        public function getActiveChild():IWindow
        {
            return (this.var_1982);
        }

        public function setActiveChild(param1:IWindow):IWindow
        {
            if (param1.parent != this)
            {
                while (true)
                {
                    param1 = param1.parent;
                    if (param1 == null)
                    {
                        throw (new Error("Window passed to activator is not a child!"));
                    };
                    if (param1.parent == this) break;
                };
            };
            var _loc2_:IWindow = this.var_1982;
            if (this.var_1982 != param1)
            {
                if (this.var_1982 != null)
                {
                    if (!this.var_1982.disposed)
                    {
                        this.var_1982.deactivate();
                    };
                };
                this.var_1982 = param1;
                if (getChildIndex(param1) != (numChildren - 1))
                {
                    setChildIndex(param1, (numChildren - 1));
                };
            };
            return (_loc2_);
        }

    }
}