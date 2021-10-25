package com.sulake.habbo.communication.messages.incoming.moderation
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OffenceData implements INamed
    {

        private var _name: String;
        private var _msg: String;

        public function OffenceData(param1: IMessageDataWrapper)
        {
            this._name = param1.readString();
            this._msg = param1.readString();

            Logger.log("READ OFF: " + this._name + ", " + this._msg);
        }

        public function get name(): String
        {
            return this._name;
        }

        public function get msg(): String
        {
            return this._msg;
        }

    }
}
