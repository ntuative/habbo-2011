package com.sulake.habbo.room.events
{

    import com.sulake.room.events.RoomObjectEvent;

    public class RoomObjectFurnitureActionEvent extends RoomObjectEvent
    {

        public static const var_1183: String = "ROFCAE_DICE_OFF";
        public static const var_1182: String = "ROFCAE_DICE_ACTIVATE";
        public static const var_1190: String = "ROFCAE_USE_HABBOWHEEL";
        public static const var_1189: String = "ROFCAE_STICKIE";
        public static const var_1184: String = "ROFCAE_VIRAL_GIFT";
        public static const var_1213: String = "ROFCAE_ENTER_ONEWAYDOOR";
        public static const var_1204: String = "ROFCAE_QUEST_VENDING";
        public static const var_1194: String = "ROFCAE_SOUND_MACHINE_INIT";
        public static const var_1191: String = "ROFCAE_SOUND_MACHINE_START";
        public static const var_1192: String = "ROFCAE_SOUND_MACHINE_STOP";
        public static const var_1193: String = "ROFCAE_SOUND_MACHINE_DISPOSE";
        public static const var_1210: String = "ROFCAE_JUKEBOX_INIT";
        public static const var_1207: String = "ROFCAE_JUKEBOX_START";
        public static const var_1208: String = "ROFCAE_JUKEBOX_MACHINE_STOP";
        public static const var_1209: String = "ROFCAE_JUKEBOX_DISPOSE";
        public static const var_445: String = "ROFCAE_MOUSE_BUTTON";
        public static const var_1181: String = "ROFCAE_MOUSE_ARROW";

        public function RoomObjectFurnitureActionEvent(param1: String, param2: int, param3: String, param4: Boolean = false, param5: Boolean = false)
        {
            super(param1, param2, param3, param4, param5);
        }

    }
}
