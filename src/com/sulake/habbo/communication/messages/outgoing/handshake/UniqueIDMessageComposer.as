package com.sulake.habbo.communication.messages.outgoing.handshake
{

    import com.sulake.core.communication.messages.IMessageComposer;

    public class UniqueIDMessageComposer implements IMessageComposer
    {

        private var var_3083: String;

        public function UniqueIDMessageComposer(param1: String)
        {
            this.var_3083 = param1;
        }

        public function dispose(): void
        {
        }

        public function getMessageArray(): Array
        {
            return [this.var_3083];
        }

    }
}
