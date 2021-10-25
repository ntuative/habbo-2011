package com.sulake.habbo.communication.messages.parser.sound
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.sound.PlayListEntry;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PlayListMessageParser implements IMessageParser
    {

        private var _synchronizationCount: int;
        private var _playlist: Array;

        public function get synchronizationCount(): int
        {
            return this._synchronizationCount;
        }

        public function get playList(): Array
        {
            return this._playlist;
        }

        public function flush(): Boolean
        {
            this._synchronizationCount = -1;
            this._playlist = [];

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._synchronizationCount = data.readInteger();
            
            var id: int;
            var length: int;
            var songName: String;
            var songCreator: String;
            
            var trackCount: int = data.readInteger();
            var i: int;
            
            while (i < trackCount)
            {
                id = data.readInteger();
                length = data.readInteger();
                songName = data.readString();
                songCreator = data.readString();

                this._playlist.push(new PlayListEntry(id, length, songName, songCreator));
                i++;
            }

            return true;
        }

    }
}
