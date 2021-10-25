package com.sulake.habbo.communication.messages.parser.handshake
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UniqueMachineIDParser implements IMessageParser
    {

        private var _machineId: String;

        public function UniqueMachineIDParser()
        {
            this._machineId = "";
        }

        public function flush(): Boolean
        {
            this._machineId = "";
            
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._machineId = data.readString();

            return true;
        }

        public function get machineID(): String
        {
            return this._machineId;
        }

    }
}
