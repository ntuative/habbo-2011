package com.sulake.habbo.communication.messages.parser.navigator
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FavouritesMessageParser implements IMessageParser
    {

        private var _limit: int;
        private var _favouriteRoomIds: Array;

        public function flush(): Boolean
        {
            this._favouriteRoomIds = [];
            
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._limit = data.readInteger();
            
            var favouritesCount: int = data.readInteger();
            var i: int;

            while (i < favouritesCount)
            {
                this._favouriteRoomIds.push(data.readInteger());
                i++;
            }

            return true;
        }

        public function get limit(): int
        {
            return this._limit;
        }

        public function get favouriteRoomIds(): Array
        {
            return this._favouriteRoomIds;
        }

    }
}
