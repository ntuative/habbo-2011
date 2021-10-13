package com.sulake.core.window.services
{
    import com.sulake.core.runtime.IDisposable;
    import flash.display.DisplayObject;
    import com.sulake.core.window.IWindowContext;

    public class ServiceManager implements IInternalWindowServices, IDisposable 
    {

        private var var_2273:uint;
        private var var_2274:DisplayObject;
        private var _disposed:Boolean = false;
        private var var_2064:IWindowContext;
        private var var_2275:IMouseDraggingService;
        private var var_2276:IMouseScalingService;
        private var var_2277:IMouseListenerService;
        private var var_2278:IFocusManagerService;
        private var var_2279:IToolTipAgentService;
        private var var_2280:IGestureAgentService;

        public function ServiceManager(param1:IWindowContext, param2:DisplayObject)
        {
            this.var_2273 = 0;
            this.var_2274 = param2;
            this.var_2064 = param1;
            this.var_2275 = new WindowMouseDragger(param2);
            this.var_2276 = new WindowMouseScaler(param2);
            this.var_2277 = new WindowMouseListener(param2);
            this.var_2278 = new FocusManager(param2);
            this.var_2279 = new WindowToolTipAgent(param2);
            this.var_2280 = new GestureAgentService();
        }

        public function dispose():void
        {
            if (this.var_2275 != null)
            {
                this.var_2275.dispose();
                this.var_2275 = null;
            };
            if (this.var_2276 != null)
            {
                this.var_2276.dispose();
                this.var_2276 = null;
            };
            if (this.var_2277 != null)
            {
                this.var_2277.dispose();
                this.var_2277 = null;
            };
            if (this.var_2278 != null)
            {
                this.var_2278.dispose();
                this.var_2278 = null;
            };
            if (this.var_2279 != null)
            {
                this.var_2279.dispose();
                this.var_2279 = null;
            };
            if (this.var_2280 != null)
            {
                this.var_2280.dispose();
                this.var_2280 = null;
            };
            this.var_2274 = null;
            this.var_2064 = null;
            this._disposed = true;
        }

        public function getMouseDraggingService():IMouseDraggingService
        {
            return (this.var_2275);
        }

        public function getMouseScalingService():IMouseScalingService
        {
            return (this.var_2276);
        }

        public function getMouseListenerService():IMouseListenerService
        {
            return (this.var_2277);
        }

        public function getFocusManagerService():IFocusManagerService
        {
            return (this.var_2278);
        }

        public function getToolTipAgentService():IToolTipAgentService
        {
            return (this.var_2279);
        }

        public function getGestureAgentService():IGestureAgentService
        {
            return (this.var_2280);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

    }
}