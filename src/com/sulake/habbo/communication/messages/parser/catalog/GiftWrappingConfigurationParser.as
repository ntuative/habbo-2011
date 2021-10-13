package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class GiftWrappingConfigurationParser implements IMessageParser 
    {

        private var var_3132:Boolean;
        private var var_3133:int;
        private var var_2672:Array;
        private var var_2673:Array;
        private var var_2674:Array;

        public function get isWrappingEnabled():Boolean
        {
            return (this.var_3132);
        }

        public function get wrappingPrice():int
        {
            return (this.var_3133);
        }

        public function get stuffTypes():Array
        {
            return (this.var_2672);
        }

        public function get boxTypes():Array
        {
            return (this.var_2673);
        }

        public function get ribbonTypes():Array
        {
            return (this.var_2674);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc2_:int;
            this.var_2672 = [];
            this.var_2673 = [];
            this.var_2674 = [];
            this.var_3132 = param1.readBoolean();
            this.var_3133 = param1.readInteger();
            var _loc3_:int = param1.readInteger();
            _loc2_ = 0;
            while (_loc2_ < _loc3_)
            {
                this.var_2672.push(param1.readInteger());
                _loc2_++;
            };
            _loc3_ = param1.readInteger();
            _loc2_ = 0;
            while (_loc2_ < _loc3_)
            {
                this.var_2673.push(param1.readInteger());
                _loc2_++;
            };
            _loc3_ = param1.readInteger();
            _loc2_ = 0;
            while (_loc2_ < _loc3_)
            {
                this.var_2674.push(param1.readInteger());
                _loc2_++;
            };
            return (true);
        }

    }
}