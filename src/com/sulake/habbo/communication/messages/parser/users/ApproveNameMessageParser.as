package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ApproveNameMessageParser implements IMessageParser 
    {

        private var _result:int;
        private var var_2715:String;

        public function get result():int
        {
            return (this._result);
        }

        public function get nameValidationInfo():String
        {
            return (this.var_2715);
        }

        public function flush():Boolean
        {
            this._result = -1;
            this.var_2715 = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._result = param1.readInteger();
            this.var_2715 = param1.readString();
            return (true);
        }

    }
}