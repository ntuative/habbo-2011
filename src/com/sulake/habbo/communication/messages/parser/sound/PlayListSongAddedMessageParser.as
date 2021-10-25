package com.sulake.habbo.communication.messages.parser.sound
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.sound.PlayListEntry;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PlayListSongAddedMessageParser implements IMessageParser
    {

        private var _entry: PlayListEntry;

        public function get entry(): PlayListEntry
        {
            return this._entry;
        }

        public function flush(): Boolean
        {
            this._entry = null;
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            var id: int = data.readInteger();
            var length: int = data.readInteger();
            var songName: String = data.readString();
            var songCreator: String = data.readString();

            this._entry = new PlayListEntry(id, length, songName, songCreator);
            
            return true;
        }

    }
}
