package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FavouritesMessageParser implements IMessageParser 
    {

        private var var_3193:int;
        private var var_3252:Array;

        public function flush():Boolean
        {
            this.var_3252 = new Array();
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3193 = param1.readInteger();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_3252.push(param1.readInteger());
                _loc3_++;
            };
            return (true);
        }

        public function get limit():int
        {
            return (this.var_3193);
        }

        public function get favouriteRoomIds():Array
        {
            return (this.var_3252);
        }

    }
}