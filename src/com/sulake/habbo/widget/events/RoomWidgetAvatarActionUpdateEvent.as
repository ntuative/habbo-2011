package com.sulake.habbo.widget.events
{

    public class RoomWidgetAvatarActionUpdateEvent extends RoomWidgetUpdateEvent
    {

        public static const var_1304: String = "RWBIUE_AVATAR_ACTION";
        public static const EFFECT_ACTIVE: String = "EFFECT_ACTIVE";
        public static const EFFECT_INACTIVE: String = "EFFECT_INACTIVE";

        private var var_2386: String = "";

        public function RoomWidgetAvatarActionUpdateEvent(param1: String, param2: String, param3: Boolean = false, param4: Boolean = false)
        {
            super(var_1304, param3, param4);
            switch (param1)
            {
                case "fx":
                    if (param2 == "0")
                    {
                        this.var_2386 = EFFECT_INACTIVE;
                    }
                    else
                    {
                        this.var_2386 = EFFECT_ACTIVE;
                    }

                    return;
                default:
                    Logger.log("RoomWidgetAvatarActionUpdateEvent, unknown actiontype: " + param1);
            }

        }

        public function get actionType(): String
        {
            return this.var_2386;
        }

    }
}
