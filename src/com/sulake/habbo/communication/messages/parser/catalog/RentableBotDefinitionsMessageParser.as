package com.sulake.habbo.communication.messages.parser.catalog
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RentableBotDefinitionsMessageParser implements IMessageParser
    {

        private var _rentableBots: Map;

        public function RentableBotDefinitionsMessageParser()
        {
            this._rentableBots = new Map();
        }

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            var id: String;
            var figureData: String;
            
            var rentableBotCount: int = data.readInteger();
            var i: int;
            
            while (i < rentableBotCount)
            {
                id = data.readString().toLowerCase();
                figureData = data.readString();
                
                this._rentableBots[id] = figureData;
                i++;
            }

            return true;
        }

        public function get rentableBots(): Map
        {
            return this._rentableBots;
        }

    }
}
