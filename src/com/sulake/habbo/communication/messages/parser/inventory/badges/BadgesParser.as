package com.sulake.habbo.communication.messages.parser.inventory.badges
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class BadgesParser implements IMessageParser
    {

        private var var_3194: Array;
        private var var_3195: Array;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean
        {
            var _loc6_: int;
            var _loc7_: String;
            this.var_3194 = [];
            var _loc2_: int = param1.readInteger();
            var _loc3_: int;
            while (_loc3_ < _loc2_)
            {
                this.var_3194.push(param1.readString());
                _loc3_++;
            }

            this.var_3195 = [];
            var _loc4_: int = param1.readInteger();
            var _loc5_: int;
            while (_loc5_ < _loc4_)
            {
                _loc6_ = param1.readInteger();
                _loc7_ = param1.readString();
                this.var_3195.push(_loc7_);
                _loc5_++;
            }

            return true;
        }

        public function getAllBadgeIds(): Array
        {
            return this.var_3194;
        }

        public function getActiveBadgeIds(): Array
        {
            return this.var_3195;
        }

    }
}
