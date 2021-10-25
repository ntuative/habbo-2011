package com.sulake.habbo.session.events
{

    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionErrorMessageEvent extends RoomSessionEvent
    {

        public static const var_380: String = "RSEME_DOOR_OTHER_DELETED";
        public static const var_379: String = "RSEME_DOOR_NOT_INSTALLED";
        public static const var_376: String = "RSEME_CANT_TRADE_STUFF";
        public static const var_377: String = "RSEME_INVALID_ITEM_LOC";
        public static const var_378: String = "RSEME_CANT_SET_NOT_OWNER";
        public static const var_384: String = "RSEME_MAX_STICKIES";
        public static const var_381: String = "RSEME_MAX_FURNITURE";
        public static const var_382: String = "RSEME_MAX_QUEUE";
        public static const var_383: String = "RSEME_MAX_SOUND";
        public static const var_385: String = "RSEME_KICKED";
        public static const var_387: String = "RSEME_GUIDE_BUSY";
        public static const var_386: String = "RSEME_GUIDE_EXISTS";
        public static const var_388: String = "RSEME_PETS_FORBIDDEN_IN_HOTEL";
        public static const var_389: String = "RSEME_PETS_FORBIDDEN_IN_FLAT";
        public static const var_390: String = "RSEME_MAX_PETS";
        public static const var_391: String = "RSEME_NO_FREE_TILES_FOR_PET";
        public static const var_392: String = "RSEME_SELECTED_TILE_NOT_FREE_FOR_PET";

        private var _message: String;

        public function RoomSessionErrorMessageEvent(param1: String, param2: IRoomSession, param3: String = null, param4: Boolean = false, param5: Boolean = false)
        {
            super(param1, param2, param4, param5);
            this._message = param3;
        }

        public function get message(): String
        {
            return this._message;
        }

    }
}
