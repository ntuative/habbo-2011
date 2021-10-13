package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PublicSpaceCastLibsMessageParser implements IMessageParser 
    {

        private var var_2979:int;
        private var var_3005:String;
        private var var_3003:int;

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_2979 = param1.readInteger();
            this.var_3005 = param1.readString();
            this.var_3003 = param1.readInteger();
            return (true);
        }

        public function get nodeId():int
        {
            return (this.var_2979);
        }

        public function get castLibs():String
        {
            return (this.var_3005);
        }

        public function get unitPort():int
        {
            return (this.var_3003);
        }

    }
}