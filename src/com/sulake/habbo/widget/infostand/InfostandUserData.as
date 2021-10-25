package com.sulake.habbo.widget.infostand
{

    import com.sulake.habbo.widget.events.RoomWidgetUserInfoUpdateEvent;

    public class InfostandUserData
    {

        private var _userId: int = 0;
        private var _userName: String = "";
        private var var_3350: Array = [];
        private var var_3351: int = 0;
        private var var_4722: String = "";
        private var _respectLeft: int = 0;
        private var var_4723: int = 0;
        private var var_4724: int = 0;
        private var _type: String;
        private var var_3181: int = 0;

        public function set userId(param1: int): void
        {
            this._userId = param1;
        }

        public function set userName(param1: String): void
        {
            this._userName = param1;
        }

        public function set badges(param1: Array): void
        {
            this.var_3350 = param1;
        }

        public function set groupId(param1: int): void
        {
            this.var_3351 = param1;
        }

        public function set groupBadgeId(param1: String): void
        {
            this.var_4722 = param1;
        }

        public function set respectLeft(param1: int): void
        {
            this._respectLeft = param1;
        }

        public function set carryItem(param1: int): void
        {
            this.var_4723 = param1;
        }

        public function set userRoomId(param1: int): void
        {
            this.var_4724 = param1;
        }

        public function set type(param1: String): void
        {
            this._type = param1;
        }

        public function set petRespectLeft(param1: int): void
        {
            this.var_3181 = param1;
        }

        public function get userId(): int
        {
            return this._userId;
        }

        public function get userName(): String
        {
            return this._userName;
        }

        public function get badges(): Array
        {
            return this.var_3350.slice();
        }

        public function get groupId(): int
        {
            return this.var_3351;
        }

        public function get groupBadgeId(): String
        {
            return this.var_4722;
        }

        public function get respectLeft(): int
        {
            return this._respectLeft;
        }

        public function get carryItem(): int
        {
            return this.var_4723;
        }

        public function get userRoomId(): int
        {
            return this.var_4724;
        }

        public function get type(): String
        {
            return this._type;
        }

        public function get petRespectLeft(): int
        {
            return this.var_3181;
        }

        public function isBot(): Boolean
        {
            return this.type == RoomWidgetUserInfoUpdateEvent.BOT;
        }

        public function setData(param1: RoomWidgetUserInfoUpdateEvent): void
        {
            this.userId = param1.webID;
            this.userName = param1.name;
            this.badges = param1.badges;
            this.groupId = param1.groupId;
            this.groupBadgeId = param1.groupBadgeId;
            this.respectLeft = param1.respectLeft;
            this.carryItem = param1.carryItem;
            this.userRoomId = param1.userRoomId;
            this.type = param1.type;
        }

    }
}
