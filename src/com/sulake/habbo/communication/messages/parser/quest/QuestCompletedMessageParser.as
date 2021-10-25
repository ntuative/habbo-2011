package com.sulake.habbo.communication.messages.parser.quest
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class QuestCompletedMessageParser implements IMessageParser
    {

        private var _questData: QuestMessageData;

        public function flush(): Boolean
        {
            if (this._questData)
            {
                this._questData.dispose();
            }

            this._questData = null;
            
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._questData = new QuestMessageData(data);

            return true;
        }

        public function get questData(): QuestMessageData
        {
            return this._questData;
        }

    }
}
