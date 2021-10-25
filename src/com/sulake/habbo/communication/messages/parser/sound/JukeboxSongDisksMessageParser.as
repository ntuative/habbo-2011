package com.sulake.habbo.communication.messages.parser.sound
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class JukeboxSongDisksMessageParser implements IMessageParser
    {

        private var _songDisks: Map;
        private var _maxLength: int;

        public function JukeboxSongDisksMessageParser()
        {
            this._songDisks = new Map();
        }

        public function get songDisks(): Map
        {
            return this._songDisks;
        }

        public function get maxLength(): int
        {
            return this._maxLength;
        }

        public function flush(): Boolean
        {
            this._songDisks.reset();
            this._maxLength = 0;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._maxLength = data.readInteger();
           
            var id: int = -1;
            var length: int = -1;
           
            var diskCount: int = data.readInteger();
            var i: int;

            while (i < diskCount)
            {
                id = data.readInteger();
                length = data.readInteger();

                this._songDisks.add(id, length);
                
                i++;
            }

            return true;
        }

    }
}
