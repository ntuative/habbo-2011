package com.sulake.habbo.communication.messages.parser.quest
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class QuestMessageParser implements IMessageParser
    {

        private var _quest: QuestMessageData;

        public function flush(): Boolean
        {
            if (this._quest)
            {
                this._quest.dispose();
            }

            this._quest = null;
            
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._quest = new QuestMessageData(data);

            return true;
        }

        public function get quest(): QuestMessageData
        {
            return this._quest;
        }

    }
}
