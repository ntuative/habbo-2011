package com.sulake.habbo.communication.messages.parser.inventory.achievements
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AchievementsScoreMessageParser implements IMessageParser
    {

        private var _score: int;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._score = data.readInteger();
            
            return true;
        }

        public function get score(): int
        {
            return this._score;
        }

    }
}
