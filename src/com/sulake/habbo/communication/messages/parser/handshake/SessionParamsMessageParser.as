package com.sulake.habbo.communication.messages.parser.handshake
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class SessionParamsMessageParser implements IMessageParser
    {

        protected var _coppa: Boolean;
        protected var _voucher: Boolean;
        protected var _date: String;
        protected var _parentEmailRequired: Boolean;
        protected var _parentEmailRequiredInReRegistration: Boolean;
        protected var _allowDirectEmail: Boolean;
        protected var _confPartnerIntegration: Boolean;
        protected var _allowProfileEditing: Boolean;
        protected var _trackingHeader: String;
        protected var _tutorialEnabled: Boolean;

        public function flush(): Boolean
        {
            this._coppa = false;
            this._voucher = false;
            this._date = "";
            this._parentEmailRequired = false;
            this._parentEmailRequiredInReRegistration = false;
            this._allowDirectEmail = false;
            this._confPartnerIntegration = false;
            this._allowProfileEditing = false;
            this._trackingHeader = "";
            this._tutorialEnabled = false;
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            var pairId: int;
            var _loc5_: int;
            var _loc6_: String;
            var _loc7_: String;
            
            var pairs: int = data.readInteger();
            var i: int;
            
            Logger.log("[Parser.SessionParams] Got " + pairs + " pairs");
            
            while (i < pairs)
            {
                pairId = data.readInteger();
                Logger.log("[Parser.SessionParams] Got id: " + pairId);

                switch (pairId)
                {
                    case 0:
                        this._coppa = data.readInteger() > 0;
                        break;
                    case 1:
                        this._voucher = data.readInteger() > 0;
                        break;
                    case 2:
                        this._parentEmailRequired = data.readInteger() > 0;
                        break;
                    case 3:
                        this._parentEmailRequiredInReRegistration = data.readInteger() > 0;
                        break;
                    case 4:
                        this._allowDirectEmail = data.readInteger() > 0;
                        break;
                    case 5:
                        this._date = data.readString();
                        break;
                    case 6:
                        this._confPartnerIntegration = data.readInteger() > 0;
                        break;
                    case 7:
                        this._allowProfileEditing = data.readInteger() > 0;
                        break;
                    case 8:
                        this._trackingHeader = data.readString();
                        break;
                    case 9:
                        this._tutorialEnabled = data.readInteger() > 0;
                        break;
                    default:
                        Logger.log("Unknown id: " + pairId);
                }

                i++;
            }

            return true;
        }

        public function get coppa(): Boolean
        {
            return this._coppa;
        }

        public function get voucher(): Boolean
        {
            return this._voucher;
        }

        public function get parentEmailRequired(): Boolean
        {
            return this._parentEmailRequired;
        }

        public function get parentEmailRequiredInReRegistration(): Boolean
        {
            return this._parentEmailRequiredInReRegistration;
        }

        public function get allowDirectEmail(): Boolean
        {
            return this._allowDirectEmail;
        }

        public function get date(): String
        {
            return this._date;
        }

        public function get confPartnerIntegration(): Boolean
        {
            return this._confPartnerIntegration;
        }

        public function get allowProfileEditing(): Boolean
        {
            return this._allowProfileEditing;
        }

        public function get tracking_header(): String
        {
            return this._trackingHeader;
        }

        public function get tutorialEnabled(): Boolean
        {
            return this._tutorialEnabled;
        }

    }
}
