package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RentableBotDefinitionsMessageParser implements IMessageParser 
    {

        private var var_2723:Map;

        public function RentableBotDefinitionsMessageParser()
        {
            this.var_2723 = new Map();
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc4_:String;
            var _loc5_:String;
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                _loc4_ = param1.readString().toLowerCase();
                _loc5_ = param1.readString();
                this.var_2723[_loc4_] = _loc5_;
                _loc3_++;
            };
            return (true);
        }

        public function get rentableBots():Map
        {
            return (this.var_2723);
        }

    }
}