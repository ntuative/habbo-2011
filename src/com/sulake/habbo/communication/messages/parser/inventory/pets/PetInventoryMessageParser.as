package com.sulake.habbo.communication.messages.parser.inventory.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetInventoryMessageParser implements IMessageParser 
    {

        private var var_3204:Array;

        public function flush():Boolean
        {
            this.var_3204 = [];
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc4_:PetData;
            this.var_3204 = [];
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                _loc4_ = new PetData(param1);
                this.var_3204.push(_loc4_);
                _loc3_++;
            };
            return (true);
        }

        public function get pets():Array
        {
            return (this.var_3204);
        }

    }
}