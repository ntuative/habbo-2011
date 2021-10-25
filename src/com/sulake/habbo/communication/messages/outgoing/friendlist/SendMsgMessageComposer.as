package com.sulake.habbo.communication.messages.outgoing.friendlist
{

    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class SendMsgMessageComposer implements IMessageComposer, IDisposable
    {

        private var var_2217: Array = [];

        public function SendMsgMessageComposer(param1: int, param2: String)
        {
            this.var_2217.push(param1);
            this.var_2217.push(param2);
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
