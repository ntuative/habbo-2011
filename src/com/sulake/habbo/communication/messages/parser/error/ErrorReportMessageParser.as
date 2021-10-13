package com.sulake.habbo.communication.messages.parser.error
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ErrorReportMessageParser implements IMessageParser 
    {

        private var var_2102:int;
        private var var_3139:int;
        private var var_3140:String;

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3139 = param1.readInteger();
            this.var_2102 = param1.readInteger();
            this.var_3140 = param1.readString();
            return (true);
        }

        public function flush():Boolean
        {
            this.var_2102 = 0;
            this.var_3139 = 0;
            this.var_3140 = null;
            return (true);
        }

        public function get errorCode():int
        {
            return (this.var_2102);
        }

        public function get messageId():int
        {
            return (this.var_3139);
        }

        public function get timestamp():String
        {
            return (this.var_3140);
        }

    }
}