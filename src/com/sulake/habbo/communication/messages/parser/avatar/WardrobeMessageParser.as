package com.sulake.habbo.communication.messages.parser.avatar
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.avatar.OutfitData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class WardrobeMessageParser implements IMessageParser
    {

        private var _state: int;
        private var _outfits: Array;

        public function flush(): Boolean
        {
            this._state = 0;
            this._outfits = [];
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._state = data.readInteger();
            
            var outfit: OutfitData;
            var outfitCount: int = data.readInteger();
            var i: int;
            
            while (i < outfitCount)
            {
                outfit = new OutfitData(data);
                this._outfits.push(outfit);
                i++;
            }

            return true;
        }

        public function get outfits(): Array
        {
            return this._outfits;
        }

        public function get state(): int
        {
            return this._state;
        }

    }
}
