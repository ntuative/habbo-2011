package com.sulake.habbo.communication.messages.outgoing.room.avatar
{

    import com.sulake.core.communication.messages.IMessageComposer;

    public class LookToMessageComposer implements IMessageComposer
    {

        private var var_3092: int;
        private var var_3093: int;

        public function LookToMessageComposer(param1: int, param2: int)
        {
            this.var_3092 = param1;
            this.var_3093 = param2;
        }

        public function getMessageArray(): Array
        {
            return [this.var_3092, this.var_3093];
        }

        public function dispose(): void
        {
        }

    }
}
