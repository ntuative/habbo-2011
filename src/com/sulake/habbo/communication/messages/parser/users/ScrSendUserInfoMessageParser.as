package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ScrSendUserInfoMessageParser implements IMessageParser 
    {

        public static const var_605:int = 1;
        public static const var_121:int = 2;

        private var var_2763:String;
        private var var_3353:int;
        private var var_3354:int;
        private var var_3355:int;
        private var var_3356:int;
        private var var_3357:Boolean;
        private var var_2700:Boolean;
        private var var_2701:int;
        private var var_2702:int;
        private var var_3358:Boolean;
        private var var_3359:int;
        private var var_3360:int;

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_2763 = param1.readString();
            this.var_3353 = param1.readInteger();
            this.var_3354 = param1.readInteger();
            this.var_3355 = param1.readInteger();
            this.var_3356 = param1.readInteger();
            this.var_3357 = param1.readBoolean();
            this.var_2700 = param1.readBoolean();
            this.var_2701 = param1.readInteger();
            this.var_2702 = param1.readInteger();
            this.var_3358 = param1.readBoolean();
            this.var_3359 = param1.readInteger();
            this.var_3360 = param1.readInteger();
            return (true);
        }

        public function get productName():String
        {
            return (this.var_2763);
        }

        public function get daysToPeriodEnd():int
        {
            return (this.var_3353);
        }

        public function get memberPeriods():int
        {
            return (this.var_3354);
        }

        public function get periodsSubscribedAhead():int
        {
            return (this.var_3355);
        }

        public function get responseType():int
        {
            return (this.var_3356);
        }

        public function get hasEverBeenMember():Boolean
        {
            return (this.var_3357);
        }

        public function get isVIP():Boolean
        {
            return (this.var_2700);
        }

        public function get pastClubDays():int
        {
            return (this.var_2701);
        }

        public function get pastVipDays():int
        {
            return (this.var_2702);
        }

        public function get isShowBasicPromo():Boolean
        {
            return (this.var_3358);
        }

        public function get basicNormalPrice():int
        {
            return (this.var_3359);
        }

        public function get basicPromoPrice():int
        {
            return (this.var_3360);
        }

    }
}