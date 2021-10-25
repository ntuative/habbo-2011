package com.sulake.habbo.communication.messages.outgoing.help
{

    import com.sulake.core.communication.messages.IMessageComposer;

    public class GetFaqCategoryMessageComposer implements IMessageComposer
    {

        private var var_2465: int;

        public function GetFaqCategoryMessageComposer(param1: int)
        {
            this.var_2465 = param1;
        }

        public function getMessageArray(): Array
        {
            return [this.var_2465];
        }

        public function dispose(): void
        {
        }

    }
}
