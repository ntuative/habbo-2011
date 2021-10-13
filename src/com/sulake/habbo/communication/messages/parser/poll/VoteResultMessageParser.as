package com.sulake.habbo.communication.messages.parser.poll
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class VoteResultMessageParser implements IMessageParser 
    {

        private var var_3275:String;
        private var var_3276:Array;
        private var var_3277:Array;
        private var var_3278:int;

        public function get question():String
        {
            return (this.var_3275);
        }

        public function get choices():Array
        {
            return (this.var_3276.slice());
        }

        public function get votes():Array
        {
            return (this.var_3277.slice());
        }

        public function get totalVotes():int
        {
            return (this.var_3278);
        }

        public function flush():Boolean
        {
            this.var_3275 = "";
            this.var_3276 = [];
            this.var_3277 = [];
            this.var_3278 = 0;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3275 = param1.readString();
            this.var_3276 = [];
            this.var_3277 = [];
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                param1.readInteger();
                this.var_3276.push(param1.readString());
                this.var_3277.push(param1.readInteger());
                _loc3_++;
            };
            this.var_3278 = param1.readInteger();
            return (true);
        }

    }
}