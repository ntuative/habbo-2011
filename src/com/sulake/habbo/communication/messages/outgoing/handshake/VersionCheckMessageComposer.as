package com.sulake.habbo.communication.messages.outgoing.handshake
{

    import com.sulake.core.communication.messages.IMessageComposer;

    public class VersionCheckMessageComposer implements IMessageComposer
    {

        private var var_3084: int;
        private var var_2888: String;
        private var var_3085: String;

        public function VersionCheckMessageComposer(param1: int, param2: String, param3: String)
        {
            this.var_3084 = param1;
            this.var_2888 = param2;
            this.var_3085 = param3;
        }

        public function dispose(): void
        {
        }

        public function getMessageArray(): Array
        {
            return [this.var_3084, this.var_2888, this.var_3085];
        }

    }
}
