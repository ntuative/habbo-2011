package com.sulake.habbo.communication.messages.incoming.handshake
{

    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.SessionParamsMessageParser;

    public class SessionParamsMessageEvent extends MessageEvent implements IMessageEvent
    {

        public function SessionParamsMessageEvent(param1: Function)
        {
            super(param1, SessionParamsMessageParser);
        }

        public function get coppa(): Boolean
        {
            return (this._parser as SessionParamsMessageParser).coppa;
        }

        public function get voucher(): Boolean
        {
            return (this._parser as SessionParamsMessageParser).voucher;
        }

        public function get parentEmailRequired(): Boolean
        {
            return (this._parser as SessionParamsMessageParser).parentEmailRequired;
        }

        public function get parentEmailRequiredInReRegistration(): Boolean
        {
            return (this._parser as SessionParamsMessageParser).parentEmailRequiredInReRegistration;
        }

        public function get allowDirectEmail(): Boolean
        {
            return (this._parser as SessionParamsMessageParser).allowDirectEmail;
        }

        public function get date(): String
        {
            return (this._parser as SessionParamsMessageParser).date;
        }

        public function get confPartnerIntegration(): Boolean
        {
            return (this._parser as SessionParamsMessageParser).confPartnerIntegration;
        }

        public function get allowProfileEditing(): Boolean
        {
            return (this._parser as SessionParamsMessageParser).allowProfileEditing;
        }

        public function get tracking_header(): String
        {
            return (this._parser as SessionParamsMessageParser).tracking_header;
        }

        public function get tutorialEnabled(): Boolean
        {
            return (this._parser as SessionParamsMessageParser).tutorialEnabled;
        }

    }
}
