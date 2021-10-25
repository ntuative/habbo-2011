package com.sulake.habbo.communication.messages.parser.help
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FaqClientFaqsMessageParser implements IMessageParser
    {

        private var _urgentData: Map;
        private var _normalData: Map;

        public function get urgentData(): Map
        {
            return this._urgentData;
        }

        public function get normalData(): Map
        {
            return this._normalData;
        }

        public function flush(): Boolean
        {
            if (this._urgentData != null)
            {
                this._urgentData.dispose();
            }

            this._urgentData = null;

            if (this._normalData != null)
            {
                this._normalData.dispose();
            }

            this._normalData = null;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            
            this._urgentData = new Map();
            this._normalData = new Map();
            
            var itemCount: int = data.readInteger();
            var i: int = 0;

            var key: int;
            var value: String;

            while (i < itemCount)
            {
                key = data.readInteger();
                value = data.readString();

                this._urgentData.add(key, value);
                i++;
            }

            itemCount = data.readInteger();
            i = 0;

            while (i < itemCount)
            {
                key = data.readInteger();
                value = data.readString();

                this._normalData.add(key, value);
                i++;
            }

            return true;
        }

    }
}
