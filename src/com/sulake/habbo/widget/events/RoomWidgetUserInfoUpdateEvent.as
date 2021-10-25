package com.sulake.habbo.widget.events
{

    import flash.display.BitmapData;

    public class RoomWidgetUserInfoUpdateEvent extends RoomWidgetUpdateEvent
    {

        public static const var_1255: String = "RWUIUE_OWN_USER";
        public static const BOT: String = "RWUIUE_BOT";
        public static const RWUIUE_PEER: String = "RWUIUE_PEER";
        public static const TRADE_REASON_OK: int = 0;
        public static const var_1809: int = 2;
        public static const var_1810: int = 3;
        public static const var_1812: String = "BOT";

        private var _name: String = "";
        private var var_2910: String = "";
        private var var_3046: int;
        private var var_3047: int = 0;
        private var var_3050: int = 0;
        private var var_2534: String = "";
        private var var_988: BitmapData = null;
        private var var_3350: Array = [];
        private var var_3351: int = 0;
        private var var_4722: String = "";
        private var var_4723: int = 0;
        private var var_4724: int = 0;
        private var var_4433: Boolean = false;
        private var var_2912: String = "";
        private var var_4725: Boolean = false;
        private var var_4726: Boolean = true;
        private var _respectLeft: int = 0;
        private var var_4727: Boolean = false;
        private var var_4728: Boolean = false;
        private var var_4729: Boolean = false;
        private var var_4730: Boolean = false;
        private var var_4731: Boolean = false;
        private var var_4732: Boolean = false;
        private var var_4733: int = 0;
        private var var_4430: Boolean = false;

        public function RoomWidgetUserInfoUpdateEvent(param1: String, param2: Boolean = false, param3: Boolean = false)
        {
            super(param1, param2, param3);
        }

        public function set name(param1: String): void
        {
            this._name = param1;
        }

        public function get name(): String
        {
            return this._name;
        }

        public function set motto(param1: String): void
        {
            this.var_2910 = param1;
        }

        public function get motto(): String
        {
            return this.var_2910;
        }

        public function set achievementScore(param1: int): void
        {
            this.var_3046 = param1;
        }

        public function get achievementScore(): int
        {
            return this.var_3046;
        }

        public function set webID(param1: int): void
        {
            this.var_3047 = param1;
        }

        public function get webID(): int
        {
            return this.var_3047;
        }

        public function set xp(param1: int): void
        {
            this.var_3050 = param1;
        }

        public function get xp(): int
        {
            return this.var_3050;
        }

        public function set figure(param1: String): void
        {
            this.var_2534 = param1;
        }

        public function get figure(): String
        {
            return this.var_2534;
        }

        public function set image(param1: BitmapData): void
        {
            this.var_988 = param1;
        }

        public function get image(): BitmapData
        {
            return this.var_988;
        }

        public function set badges(param1: Array): void
        {
            this.var_3350 = param1;
        }

        public function get badges(): Array
        {
            return this.var_3350;
        }

        public function set groupId(param1: int): void
        {
            this.var_3351 = param1;
        }

        public function get groupId(): int
        {
            return this.var_3351;
        }

        public function set groupBadgeId(param1: String): void
        {
            this.var_4722 = param1;
        }

        public function get groupBadgeId(): String
        {
            return this.var_4722;
        }

        public function set canBeAskedAsFriend(param1: Boolean): void
        {
            this.var_4725 = param1;
        }

        public function get canBeAskedAsFriend(): Boolean
        {
            return this.var_4725;
        }

        public function set respectLeft(param1: int): void
        {
            this._respectLeft = param1;
        }

        public function get respectLeft(): int
        {
            return this._respectLeft;
        }

        public function set isIgnored(param1: Boolean): void
        {
            this.var_4727 = param1;
        }

        public function get isIgnored(): Boolean
        {
            return this.var_4727;
        }

        public function set amIOwner(param1: Boolean): void
        {
            this.var_4728 = param1;
        }

        public function get amIOwner(): Boolean
        {
            return this.var_4728;
        }

        public function set amIController(param1: Boolean): void
        {
            this.var_4729 = param1;
        }

        public function get amIController(): Boolean
        {
            return this.var_4729;
        }

        public function set amIAnyRoomController(param1: Boolean): void
        {
            this.var_4730 = param1;
        }

        public function get amIAnyRoomController(): Boolean
        {
            return this.var_4730;
        }

        public function set hasFlatControl(param1: Boolean): void
        {
            this.var_4731 = param1;
        }

        public function get hasFlatControl(): Boolean
        {
            return this.var_4731;
        }

        public function set canTrade(param1: Boolean): void
        {
            this.var_4732 = param1;
        }

        public function get canTrade(): Boolean
        {
            return this.var_4732;
        }

        public function set canTradeReason(param1: int): void
        {
            this.var_4733 = param1;
        }

        public function get canTradeReason(): int
        {
            return this.var_4733;
        }

        public function set canBeKicked(param1: Boolean): void
        {
            this.var_4726 = param1;
        }

        public function get canBeKicked(): Boolean
        {
            return this.var_4726;
        }

        public function set isRoomOwner(param1: Boolean): void
        {
            this.var_4430 = param1;
        }

        public function get isRoomOwner(): Boolean
        {
            return this.var_4430;
        }

        public function set carryItem(param1: int): void
        {
            this.var_4723 = param1;
        }

        public function get carryItem(): int
        {
            return this.var_4723;
        }

        public function set userRoomId(param1: int): void
        {
            this.var_4724 = param1;
        }

        public function get userRoomId(): int
        {
            return this.var_4724;
        }

        public function set isSpectatorMode(param1: Boolean): void
        {
            this.var_4433 = param1;
        }

        public function get isSpectatorMode(): Boolean
        {
            return this.var_4433;
        }

        public function set realName(param1: String): void
        {
            this.var_2912 = param1;
        }

        public function get realName(): String
        {
            return this.var_2912;
        }

    }
}
