package com.sulake.habbo.communication.messages.outgoing.navigator
{

    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class PopularRoomsSearchMessageComposer implements IMessageComposer, IDisposable
    {

        private var var_2217: Array = [];

        public function PopularRoomsSearchMessageComposer(param1: String, param2: int)
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
