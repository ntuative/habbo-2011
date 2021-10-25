package com.sulake.core.window.services
{

    import com.sulake.core.runtime.IDisposable;

    import flash.display.DisplayObject;

    import com.sulake.core.window.IWindowContext;

    public class ServiceManager implements IInternalWindowServices, IDisposable
    {

        private var var_2273: uint;
        private var _displayObject: DisplayObject;
        private var _disposed: Boolean = false;
        private var _context: IWindowContext;
        private var _mouseDraggingService: IMouseDraggingService;
        private var _mouseScalingService: IMouseScalingService;
        private var _mouseListenerService: IMouseListenerService;
        private var _focusManagerService: IFocusManagerService;
        private var _toolTipAgentService: IToolTipAgentService;
        private var _gestureAgentService: IGestureAgentService;

        public function ServiceManager(ctx: IWindowContext, displayObject: DisplayObject)
        {
            this.var_2273 = 0;
            this._context = ctx;
            this._displayObject = displayObject;
            this._mouseDraggingService = new WindowMouseDragger(displayObject);
            this._mouseScalingService = new WindowMouseScaler(displayObject);
            this._mouseListenerService = new WindowMouseListener(displayObject);
            this._focusManagerService = new FocusManager(displayObject);
            this._toolTipAgentService = new WindowToolTipAgent(displayObject);
            this._gestureAgentService = new GestureAgentService();
        }

        public function dispose(): void
        {
            if (this._mouseDraggingService != null)
            {
                this._mouseDraggingService.dispose();
                this._mouseDraggingService = null;
            }

            if (this._mouseScalingService != null)
            {
                this._mouseScalingService.dispose();
                this._mouseScalingService = null;
            }

            if (this._mouseListenerService != null)
            {
                this._mouseListenerService.dispose();
                this._mouseListenerService = null;
            }

            if (this._focusManagerService != null)
            {
                this._focusManagerService.dispose();
                this._focusManagerService = null;
            }

            if (this._toolTipAgentService != null)
            {
                this._toolTipAgentService.dispose();
                this._toolTipAgentService = null;
            }

            if (this._gestureAgentService != null)
            {
                this._gestureAgentService.dispose();
                this._gestureAgentService = null;
            }

            this._displayObject = null;
            this._context = null;
            this._disposed = true;
        }

        public function getMouseDraggingService(): IMouseDraggingService
        {
            return this._mouseDraggingService;
        }

        public function getMouseScalingService(): IMouseScalingService
        {
            return this._mouseScalingService;
        }

        public function getMouseListenerService(): IMouseListenerService
        {
            return this._mouseListenerService;
        }

        public function getFocusManagerService(): IFocusManagerService
        {
            return this._focusManagerService;
        }

        public function getToolTipAgentService(): IToolTipAgentService
        {
            return this._toolTipAgentService;
        }

        public function getGestureAgentService(): IGestureAgentService
        {
            return this._gestureAgentService;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

    }
}
