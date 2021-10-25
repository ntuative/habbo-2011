package com.sulake.habbo.communication.messages.outgoing.room.avatar
{

    import com.sulake.core.communication.messages.IMessageComposer;

    public class ChangeMottoMessageComposer implements IMessageComposer
    {

        private var var_2910: String;

        public function ChangeMottoMessageComposer(param1: String)
        {
            this.var_2910 = param1;
        }

        public function dispose(): void
        {
        }

        public function getMessageArray(): Array
        {
            return [this.var_2910];
        }

    }
}
