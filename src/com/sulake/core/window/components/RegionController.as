package com.sulake.core.window.components
{

    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.WindowContext;

    import flash.geom.Rectangle;

    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.enum.MouseCursorType;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.events.WindowEvent;

    public class RegionController extends ContainerController implements IRegionWindow
    {

        protected static const var_2024: String = "tool_tip_caption";
        protected static const var_2025: String = "";
        protected static const KEY_TOOLTIP_DELAY: String = "tool_tip_delay";
        protected static const var_2026: uint = 500;

        protected var _tooltipDelay: uint = 500;
        protected var _tooltipCaption: String = "";

        public function RegionController(param1: String, param2: uint, param3: uint, param4: uint, param5: WindowContext, param6: Rectangle, param7: IWindow, param8: Function = null, param9: Array = null, param10: Array = null, param11: uint = 0)
        {
            param4 = param4 | WindowParam.var_593;
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
        }

        public function set toolTipCaption(caption: String): void
        {
            this._tooltipCaption = caption == null ? "" : caption;
        }

        public function get toolTipCaption(): String
        {
            return this._tooltipCaption;
        }

        public function set toolTipDelay(delay: uint): void
        {
            this._tooltipDelay = delay;
        }

        public function get toolTipDelay(): uint
        {
            return this._tooltipDelay;
        }

        public function showToolTip(param1: IToolTipWindow): void
        {
        }

        public function hideToolTip(): void
        {
        }

        public function setMouseCursorForState(param1: uint, param2: uint): uint
        {
            return MouseCursorType.var_525;
        }

        public function getMouseCursorByState(param1: uint): uint
        {
            return MouseCursorType.var_525;
        }

        override public function update(param1: WindowController, param2: WindowEvent): Boolean
        {
            var _loc3_: Boolean = super.update(param1, param2);
            if (param1 == this)
            {
                InteractiveController.processInteractiveWindowEvents(this, param2);
            }

            return _loc3_;
        }

        override public function get properties(): Array
        {
            return InteractiveController.writeInteractiveWindowProperties(this, super.properties);
        }

        override public function set properties(param1: Array): void
        {
            InteractiveController.readInteractiveWindowProperties(this, param1);
            super.properties = param1;
        }

    }
}
