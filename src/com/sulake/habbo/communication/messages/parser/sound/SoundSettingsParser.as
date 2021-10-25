package com.sulake.habbo.communication.messages.parser.sound
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class SoundSettingsParser implements IMessageParser
    {

        private var _volume: int;

        public function get volume(): int
        {
            return this._volume;
        }

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._volume = data.readInteger();
            
            return true;
        }

    }
}
