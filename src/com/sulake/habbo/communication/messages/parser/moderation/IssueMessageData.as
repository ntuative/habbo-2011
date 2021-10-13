package com.sulake.habbo.communication.messages.parser.moderation
{
    public class IssueMessageData 
    {

        public static const var_1530:int = 1;
        public static const var_1531:int = 2;
        public static const var_1532:int = 3;

        private var var_3223:int;
        private var _state:int;
        private var var_2465:int;
        private var _reportedCategoryId:int;
        private var var_3225:int;
        private var _priority:int;
        private var var_3226:int = 0;
        private var var_3227:int;
        private var var_3228:String;
        private var var_2953:int;
        private var var_3229:String;
        private var var_3230:int;
        private var var_3231:String;
        private var _message:String;
        private var var_2954:int;
        private var var_2970:String;
        private var var_3232:int;
        private var var_3233:String;
        private var var_2972:int;
        private var var_3234:String;
        private var var_3235:String;
        private var var_3003:int;
        private var var_3004:int;

        public function IssueMessageData(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:String, param9:int, param10:String, param11:int, param12:String, param13:String, param14:int, param15:String, param16:int, param17:String, param18:int, param19:String, param20:String, param21:int, param22:int)
        {
            this.var_3223 = param1;
            this._state = param2;
            this.var_2465 = param3;
            this._reportedCategoryId = param4;
            this.var_3225 = param5;
            this._priority = param6;
            this.var_3227 = param7;
            this.var_3228 = param8;
            this.var_2953 = param9;
            this.var_3229 = param10;
            this.var_3230 = param11;
            this.var_3231 = param12;
            this._message = param13;
            this.var_2954 = param14;
            this.var_2970 = param15;
            this.var_3232 = param16;
            this.var_3233 = param17;
            this.var_2972 = param18;
            this.var_3234 = param19;
            this.var_3235 = param20;
            this.var_3003 = param21;
            this.var_3004 = param22;
        }

        public function get issueId():int
        {
            return (this.var_3223);
        }

        public function get state():int
        {
            return (this._state);
        }

        public function get categoryId():int
        {
            return (this.var_2465);
        }

        public function get reportedCategoryId():int
        {
            return (this._reportedCategoryId);
        }

        public function get timeStamp():int
        {
            return (this.var_3225);
        }

        public function get priority():int
        {
            return (this._priority + this.var_3226);
        }

        public function get reporterUserId():int
        {
            return (this.var_3227);
        }

        public function get reporterUserName():String
        {
            return (this.var_3228);
        }

        public function get reportedUserId():int
        {
            return (this.var_2953);
        }

        public function get reportedUserName():String
        {
            return (this.var_3229);
        }

        public function get pickerUserId():int
        {
            return (this.var_3230);
        }

        public function get pickerUserName():String
        {
            return (this.var_3231);
        }

        public function get message():String
        {
            return (this._message);
        }

        public function get chatRecordId():int
        {
            return (this.var_2954);
        }

        public function get roomName():String
        {
            return (this.var_2970);
        }

        public function get roomType():int
        {
            return (this.var_3232);
        }

        public function get flatType():String
        {
            return (this.var_3233);
        }

        public function get flatId():int
        {
            return (this.var_2972);
        }

        public function get flatOwnerName():String
        {
            return (this.var_3234);
        }

        public function get var_3236():String
        {
            return (this.var_3235);
        }

        public function get unitPort():int
        {
            return (this.var_3003);
        }

        public function get worldId():int
        {
            return (this.var_3004);
        }

        public function set temporalPriority(param1:int):void
        {
            this.var_3226 = param1;
        }

        public function getOpenTime(param1:int):String
        {
            var _loc2_:int = int(((param1 - this.var_3225) / 1000));
            var _loc3_:int = (_loc2_ % 60);
            var _loc4_:int = int((_loc2_ / 60));
            var _loc5_:int = (_loc4_ % 60);
            var _loc6_:int = int((_loc4_ / 60));
            var _loc7_:String = ((_loc3_ < 10) ? ("0" + _loc3_) : ("" + _loc3_));
            var _loc8_:String = ((_loc5_ < 10) ? ("0" + _loc5_) : ("" + _loc5_));
            var _loc9_:String = ((_loc6_ < 10) ? ("0" + _loc6_) : ("" + _loc6_));
            return ((((_loc9_ + ":") + _loc8_) + ":") + _loc7_);
        }

    }
}