package com.sulake.habbo.communication.messages.parser.help
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FaqCategoryMessageParser implements IMessageParser
    {

        private var _categoryId: int;
        private var _description: String;
        private var _data: Map;

        public function get categoryId(): int
        {
            return this._categoryId;
        }

        public function get description(): String
        {
            return this._description;
        }

        public function get data(): Map
        {
            return this._data;
        }

        public function flush(): Boolean
        {
            if (this._data != null)
            {
                this._data.dispose();
            }

            this._data = null;
            this._categoryId = -1;
            this._description = null;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._data = new Map();
            this._categoryId = data.readInteger();
            this._description = data.readString();

            var dataCount: int = data.readInteger();
            var key: int;
            var value: String;
            var i: int;

            while (i < dataCount)
            {
                key = data.readInteger();
                value = data.readString();
                
                this._data.add(key, value);
                i++;
            }

            return true;
        }

    }
}
