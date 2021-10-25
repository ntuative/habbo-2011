package com.sulake.habbo.communication.messages.outgoing.marketplace
{

    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class MakeOfferMessageComposer implements IMessageComposer, IDisposable
    {

        public static const var_1792: int = 1;
        public static const var_1793: int = 2;

        private var var_2217: Array = [];

        public function MakeOfferMessageComposer(param1: int, param2: int, param3: int)
        {
            this.var_2217.push(param1);
            this.var_2217.push(param2);
            this.var_2217.push(param3);
        }

        public function getMessageArray(): Array
        {
            return this.var_2217;
        }

        public function dispose(): void
        {
            this.var_2217 = null;
        }

        public function get disposed(): Boolean
        {
            return false;
        }

    }
}
