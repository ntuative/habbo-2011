package com.sulake.habbo.communication.messages.parser.room.publicroom
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ParkBusCannotEnterMessageParser implements IMessageParser
    {

        private var _reason: String = "";

        public function get reason(): String
        {
            return this._reason;
        }

        public function flush(): Boolean
        {
            this._reason = "";
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._reason = data.readString();
            
            return true;
        }

    }
}
