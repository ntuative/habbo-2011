package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FaqCategoryMessageParser implements IMessageParser 
    {

        private var var_2465:int;
        private var var_2400:String;
        private var _data:Map;

        public function get categoryId():int
        {
            return (this.var_2465);
        }

        public function get description():String
        {
            return (this.var_2400);
        }

        public function get data():Map
        {
            return (this._data);
        }

        public function flush():Boolean
        {
            if (this._data != null)
            {
                this._data.dispose();
            };
            this._data = null;
            this.var_2465 = -1;
            this.var_2400 = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc3_:int;
            var _loc4_:String;
            this._data = new Map();
            this.var_2465 = param1.readInteger();
            this.var_2400 = param1.readString();
            var _loc2_:int = param1.readInteger();
            var _loc5_:int;
            while (_loc5_ < _loc2_)
            {
                _loc3_ = param1.readInteger();
                _loc4_ = param1.readString();
                this._data.add(_loc3_, _loc4_);
                _loc5_++;
            };
            return (true);
        }

    }
}