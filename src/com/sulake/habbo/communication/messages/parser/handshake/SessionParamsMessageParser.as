package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class SessionParamsMessageParser implements IMessageParser 
    {

        protected var var_3166:Boolean;
        protected var var_3167:Boolean;
        protected var var_3168:String;
        protected var var_3169:Boolean;
        protected var var_3170:Boolean;
        protected var var_3171:Boolean;
        protected var _confPartnerIntegration:Boolean;
        protected var var_3172:Boolean;
        protected var var_3173:String;
        protected var var_3174:Boolean;

        public function flush():Boolean
        {
            this.var_3166 = false;
            this.var_3167 = false;
            this.var_3168 = "";
            this.var_3169 = false;
            this.var_3170 = false;
            this.var_3171 = false;
            this._confPartnerIntegration = false;
            this.var_3172 = false;
            this.var_3173 = "";
            this.var_3174 = false;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc4_:int;
            var _loc5_:int;
            var _loc6_:String;
            var _loc7_:String;
            var _loc2_:int = param1.readInteger();
            Logger.log((("[Parser.SessionParams] Got " + _loc2_) + " pairs"));
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                _loc4_ = param1.readInteger();
                Logger.log(("[Parser.SessionParams] Got id: " + _loc4_));
                switch (_loc4_)
                {
                    case 0:
                        _loc5_ = param1.readInteger();
                        this.var_3166 = (_loc5_ > 0);
                        break;
                    case 1:
                        _loc5_ = param1.readInteger();
                        this.var_3167 = (_loc5_ > 0);
                        break;
                    case 2:
                        _loc5_ = param1.readInteger();
                        this.var_3169 = (_loc5_ > 0);
                        break;
                    case 3:
                        _loc5_ = param1.readInteger();
                        this.var_3170 = (_loc5_ > 0);
                        break;
                    case 4:
                        _loc5_ = param1.readInteger();
                        this.var_3171 = (_loc5_ > 0);
                        break;
                    case 5:
                        _loc6_ = param1.readString();
                        break;
                    case 6:
                        _loc5_ = param1.readInteger();
                        break;
                    case 7:
                        _loc5_ = param1.readInteger();
                        break;
                    case 8:
                        _loc7_ = param1.readString();
                        break;
                    case 9:
                        _loc5_ = param1.readInteger();
                        break;
                    default:
                        Logger.log(("Unknown id: " + _loc4_));
                };
                _loc3_++;
            };
            return (true);
        }

        public function get coppa():Boolean
        {
            return (this.var_3166);
        }

        public function get voucher():Boolean
        {
            return (this.var_3167);
        }

        public function get parentEmailRequired():Boolean
        {
            return (this.var_3169);
        }

        public function get parentEmailRequiredInReRegistration():Boolean
        {
            return (this.var_3170);
        }

        public function get allowDirectEmail():Boolean
        {
            return (this.var_3171);
        }

        public function get date():String
        {
            return (this.var_3168);
        }

        public function get confPartnerIntegration():Boolean
        {
            return (this._confPartnerIntegration);
        }

        public function get allowProfileEditing():Boolean
        {
            return (this.var_3172);
        }

        public function get tracking_header():String
        {
            return (this.var_3173);
        }

        public function get tutorialEnabled():Boolean
        {
            return (this.var_3174);
        }

    }
}