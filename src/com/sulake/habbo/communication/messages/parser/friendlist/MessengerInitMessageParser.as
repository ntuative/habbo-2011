package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendCategoryData;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MessengerInitMessageParser implements IMessageParser 
    {

        private var var_3153:int;
        private var var_3154:int;
        private var var_3155:int;
        private var var_3156:int;
        private var var_511:Array;
        private var var_2681:Array;

        public function flush():Boolean
        {
            this.var_511 = new Array();
            this.var_2681 = new Array();
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc4_:int;
            this.var_3153 = param1.readInteger();
            this.var_3154 = param1.readInteger();
            this.var_3155 = param1.readInteger();
            this.var_3156 = param1.readInteger();
            var _loc2_:int = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc2_)
            {
                this.var_511.push(new FriendCategoryData(param1));
                _loc4_++;
            };
            var _loc3_:int = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc3_)
            {
                this.var_2681.push(new FriendData(param1));
                _loc4_++;
            };
            return (true);
        }

        public function get userFriendLimit():int
        {
            return (this.var_3153);
        }

        public function get normalFriendLimit():int
        {
            return (this.var_3154);
        }

        public function get extendedFriendLimit():int
        {
            return (this.var_3155);
        }

        public function get categories():Array
        {
            return (this.var_511);
        }

        public function get friends():Array
        {
            return (this.var_2681);
        }

        public function get evenMoreExtendedFriendLimit():int
        {
            return (this.var_3156);
        }

    }
}