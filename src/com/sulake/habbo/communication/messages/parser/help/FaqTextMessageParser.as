package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FaqTextMessageParser implements IMessageParser 
    {

        private var var_3086:int;
        private var var_3187:String;

        public function get questionId():int
        {
            return (this.var_3086);
        }

        public function get answerText():String
        {
            return (this.var_3187);
        }

        public function flush():Boolean
        {
            this.var_3086 = -1;
            this.var_3187 = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3086 = param1.readInteger();
            this.var_3187 = param1.readString();
            return (true);
        }

    }
}