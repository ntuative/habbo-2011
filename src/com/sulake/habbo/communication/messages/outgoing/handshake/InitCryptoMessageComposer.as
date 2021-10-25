package com.sulake.habbo.communication.messages.outgoing.handshake
{

    import com.sulake.core.communication.messages.IMessageComposer;

    public class InitCryptoMessageComposer implements IMessageComposer
    {

        private var var_1997: Array;

        public function InitCryptoMessageComposer(param1: int)
        {
            this.var_1997 = [];
            this.var_1997.push(param1);
        }

        public function dispose(): void
        {
        }

        public function getMessageArray(): Array
        {
            return this.var_1997;
        }

    }
}
