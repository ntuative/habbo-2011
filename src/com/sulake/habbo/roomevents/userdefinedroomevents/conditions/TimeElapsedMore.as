package com.sulake.habbo.roomevents.userdefinedroomevents.conditions
{

    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.roomevents.userdefinedroomevents.common.SliderWindowController;
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;

    import flash.events.Event;

    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs.TriggerOnce;
    import com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs.*;

    public class TimeElapsedMore implements ConditionType
    {

        private var var_4378: HabboUserDefinedRoomEvents;
        private var _slider: SliderWindowController;

        public function get code(): int
        {
            return ConditionCodes.var_1948;
        }

        public function get requiresFurni(): int
        {
            return UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_NONE;
        }

        public function get hasStateSnapshot(): Boolean
        {
            return false;
        }

        public function readIntParamsFromForm(param1: IWindowContainer): Array
        {
            var _loc2_: Array = [];
            var _loc3_: int = this._slider.getValue();
            _loc2_.push(_loc3_ + 1);
            return _loc2_;
        }

        public function readStringParamFromForm(param1: IWindowContainer): String
        {
            return "";
        }

        public function onInit(param1: IWindowContainer, param2: HabboUserDefinedRoomEvents): void
        {
            this.var_4378 = param2;
            this._slider = new SliderWindowController(param2, this.getInput(param1), param2.assets, 1, 1200, 1);
            this._slider.setValue(1);
            this._slider.addEventListener(Event.CHANGE, this.onSliderChange);
        }

        public function onEditStart(param1: IWindowContainer, param2: Triggerable): void
        {
            var _loc3_: int = param2.intParams[0] - 1;
            this._slider.setValue(_loc3_);
        }

        public function get hasSpecialInputs(): Boolean
        {
            return true;
        }

        private function getInput(param1: IWindowContainer): IWindowContainer
        {
            return param1.findChildByName("slider_container") as IWindowContainer;
        }

        private function onSliderChange(param1: Event): void
        {
            var _loc2_: SliderWindowController;
            var _loc3_: Number;
            var _loc4_: int;
            var _loc5_: String;
            if (param1.type == Event.CHANGE)
            {
                _loc2_ = (param1.target as SliderWindowController);
                if (_loc2_)
                {
                    _loc3_ = _loc2_.getValue();
                    _loc4_ = int(_loc3_);
                    _loc5_ = TriggerOnce.getSecsFromPulses(_loc4_);
                    this.var_4378.localization.registerParameter("wiredfurni.params.allowafter", "seconds", _loc5_);
                }

            }

        }

    }
}
