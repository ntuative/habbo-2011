package com.sulake.habbo.communication.messages.outgoing.sound
{

    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class RemoveJukeboxDiskComposer implements IMessageComposer, IDisposable
    {

        private var var_2217: Array = [];

        public function RemoveJukeboxDiskComposer(param1: int)
        {
            this.var_2217.push(param1);
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
