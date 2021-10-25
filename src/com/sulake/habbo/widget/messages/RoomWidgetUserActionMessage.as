package com.sulake.habbo.widget.messages
{

    public class RoomWidgetUserActionMessage extends RoomWidgetMessage
    {

        public static const var_1840: String = "RWUAM_WHISPER_USER";
        public static const var_1841: String = "RWUAM_IGNORE_USER";
        public static const var_1842: String = "RWUAM_UNIGNORE_USER";
        public static const var_1839: String = "RWUAM_KICK_USER";
        public static const var_1843: String = "RWUAM_BAN_USER";
        public static const var_1844: String = "RWUAM_SEND_FRIEND_REQUEST";
        public static const var_1845: String = "RWUAM_RESPECT_USER";
        public static const var_1846: String = "RWUAM_GIVE_RIGHTS";
        public static const var_1847: String = "RWUAM_TAKE_RIGHTS";
        public static const var_1848: String = "RWUAM_START_TRADING";
        public static const var_1849: String = "RWUAM_OPEN_HOME_PAGE";
        public static const var_1850: String = "RWUAM_KICK_BOT";
        public static const var_1851: String = "RWUAM_REPORT";
        public static const var_1837: String = "RWUAM_PICKUP_PET";
        public static const var_1852: String = "RWUAM_TRAIN_PET";
        public static const var_1838: String = " RWUAM_RESPECT_PET";
        public static const var_1346: String = "RWUAM_REQUEST_PET_UPDATE";
        public static const var_1808: String = "RWUAM_START_NAME_CHANGE";

        private var _userId: int = 0;

        public function RoomWidgetUserActionMessage(param1: String, param2: int = 0)
        {
            super(param1);
            this._userId = param2;
        }

        public function get userId(): int
        {
            return this._userId;
        }

    }
}
