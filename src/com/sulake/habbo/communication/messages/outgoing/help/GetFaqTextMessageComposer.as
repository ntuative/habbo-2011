package com.sulake.habbo.communication.messages.outgoing.help
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class GetFaqTextMessageComposer implements IMessageComposer 
    {

        private var var_3086:int;

        public function GetFaqTextMessageComposer(param1:int)
        {
            this.var_3086 = param1;
        }

        public function getMessageArray():Array
        {
            return ([this.var_3086]);
        }

        public function dispose():void
        {
        }

    }
}