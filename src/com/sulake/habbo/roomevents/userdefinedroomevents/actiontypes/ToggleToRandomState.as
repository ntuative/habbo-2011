package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes
{

    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;

    public class ToggleToRandomState extends DefaultActionType
    {

        override public function get code(): int
        {
            return ActionTypeCodes.var_1935;
        }

        override public function get requiresFurni(): int
        {
            return UserDefinedRoomEventsCtrl.var_624;
        }

    }
}
