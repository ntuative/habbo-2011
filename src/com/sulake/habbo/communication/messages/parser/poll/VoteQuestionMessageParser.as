﻿package com.sulake.habbo.communication.messages.parser.poll
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class VoteQuestionMessageParser implements IMessageParser 
    {

        private var var_3275:String;
        private var var_3276:Array;

        public function get question():String
        {
            return (this.var_3275);
        }

        public function get choices():Array
        {
            return (this.var_3276.slice());
        }

        public function flush():Boolean
        {
            this.var_3275 = "";
            this.var_3276 = [];
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3275 = param1.readString();
            this.var_3276 = [];
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                param1.readInteger();
                this.var_3276.push(param1.readString());
                _loc3_++;
            };
            return (true);
        }

    }
}