package com.sulake.habbo.communication.messages.outgoing.room.furniture
{

    import com.sulake.core.communication.messages.IMessageComposer;

    public class OpenPetPackageMessageComposer implements IMessageComposer
    {

        private var var_2358: int;
        private var var_3100: String;

        public function OpenPetPackageMessageComposer(param1: int, param2: String)
        {
            this.var_2358 = param1;
            this.var_3100 = param2;
        }

        public function getMessageArray(): Array
        {
            return [this.var_2358, this.var_3100];
        }

        public function dispose(): void
        {
        }

    }
}
