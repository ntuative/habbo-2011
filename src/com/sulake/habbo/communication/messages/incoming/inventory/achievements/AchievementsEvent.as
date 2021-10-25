package com.sulake.habbo.communication.messages.incoming.inventory.achievements
{

    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementsMessageParser;

    public class AchievementsEvent extends MessageEvent
    {

        public function AchievementsEvent(param1: Function)
        {
            super(param1, AchievementsMessageParser);
        }

        public function getParser(): AchievementsMessageParser
        {
            return _parser as AchievementsMessageParser;
        }

    }
}
