package com.sulake.habbo.communication.messages.parser.sound
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.sound.SongInfoEntry;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class TraxSongInfoMessageParser implements IMessageParser
    {

        private var _songs: Array;

        public function get songs(): Array
        {
            return this._songs;
        }

        public function flush(): Boolean
        {
            this._songs = [];

            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean
        {
            var id: int;
            var songName: String;
            var data: String;
            var length: int;
            var songCreator: String;
            var songInfo: SongInfoEntry;
            
            var songCount: int = param1.readInteger();
            var i: int;

            while (i < songCount)
            {
                id = param1.readInteger();
                songName = param1.readString();
                data = param1.readString();
                length = param1.readInteger();
                songCreator = param1.readString();
                
                songInfo = new SongInfoEntry(id, length, songName, songCreator, data);
                
                this._songs.push(songInfo);
                
                i++;
            }

            return true;
        }

    }
}
