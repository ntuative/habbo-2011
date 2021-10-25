package com.sulake.habbo.communication.messages.parser.inventory.trading
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.ItemDataStructure;

    public class TradingItemListParser implements IMessageParser
    {

        private var _firstUserId: int;
        private var _firstUserItemArray: Array;
        private var _secondaryUserId: int;
        private var _secondaryUserItemArray: Array;

        public function get firstUserID(): int
        {
            return this._firstUserId;
        }

        public function get firstUserItemArray(): Array
        {
            return this._firstUserItemArray;
        }

        public function get secondUserID(): int
        {
            return this._secondaryUserId;
        }

        public function get secondUserItemArray(): Array
        {
            return this._secondaryUserItemArray;
        }

        public function flush(): Boolean
        {
            this._firstUserId = -1;
            this._firstUserItemArray = null;
            this._secondaryUserId = -1;
            this._secondaryUserItemArray = null;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._firstUserId = data.readInteger();
            this._firstUserItemArray = [];

            if (!this.parseItemData(data, this._firstUserItemArray))
            {
                return false;
            }

            this._secondaryUserId = data.readInteger();
            this._secondaryUserItemArray = [];

            return this.parseItemData(data, this._secondaryUserItemArray);


        }

        private function parseItemData(data: IMessageDataWrapper, userItems: Array): Boolean
        {
            var itemCount: int;
            var itemId: int;
            var itemType: String;
            var roomItemId: int;
            var itemTypeId: int;
            var category: int;
            var stuffData: String;
            var timeToExpiration: int;
            var creationDay: int;
            var creationMonth: int;
            var creationYear: int;
            var groupable: Boolean;
            var extra: int;

            itemCount = data.readInteger();

            while (itemCount > 0)
            {
                itemId = data.readInteger();
                itemType = data.readString().toUpperCase();
                roomItemId = data.readInteger();
                itemTypeId = data.readInteger();
                category = data.readInteger();
                groupable = data.readBoolean();
                stuffData = data.readString();
                timeToExpiration = -1;
                creationDay = data.readInteger();
                creationMonth = data.readInteger();
                creationYear = data.readInteger();
                extra = itemType == "S" ? data.readInteger() : -1;

                userItems.push(new ItemDataStructure(itemId, itemType, roomItemId, itemTypeId, category, stuffData, extra, timeToExpiration, creationDay, creationMonth, creationYear, groupable));

                itemCount--;
            }

            return true;
        }

    }
}
