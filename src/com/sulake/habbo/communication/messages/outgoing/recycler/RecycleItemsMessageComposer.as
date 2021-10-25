package com.sulake.habbo.communication.messages.outgoing.recycler
{

    import com.sulake.core.communication.messages.IMessageComposer;

    public class RecycleItemsMessageComposer implements IMessageComposer
    {

        private var var_3090: Array;

        public function RecycleItemsMessageComposer(param1: Array)
        {
            this.var_3090 = [];
            this.var_3090.push(param1.length);
            this.var_3090 = this.var_3090.concat(param1);
        }

        public function dispose(): void
        {
        }

        public function getMessageArray(): Array
        {
            return this.var_3090;
        }

    }
}
