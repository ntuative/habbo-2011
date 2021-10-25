package com.sulake.habbo.communication.messages.parser.quest
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class QuestsMessageParser implements IMessageParser
    {

        private var _quests: Array;
        private var _openWindow: Boolean;

        public function flush(): Boolean
        {
            var quest: QuestMessageData;

            if (this._quests)
            {
                for each (quest in this._quests)
                {
                    quest.dispose();
                }

            }

            this._quests = [];

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            var messageCount: int = data.readInteger();
            var i: int;

            while (i < messageCount)
            {
                this._quests.push(new QuestMessageData(data));
                i++;
            }

            this._openWindow = data.readBoolean();
            
            return true;
        }

        public function get quests(): Array
        {
            return this._quests;
        }

        public function get openWindow(): Boolean
        {
            return this._openWindow;
        }

    }
}
