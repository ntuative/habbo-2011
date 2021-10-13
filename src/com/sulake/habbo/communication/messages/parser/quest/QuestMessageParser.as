package com.sulake.habbo.communication.messages.parser.quest
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class QuestMessageParser implements IMessageParser 
    {

        private var var_3280:QuestMessageData;

        public function flush():Boolean
        {
            if (this.var_3280)
            {
                this.var_3280.dispose();
            };
            this.var_3280 = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3280 = new QuestMessageData(param1);
            return (true);
        }

        public function get quest():QuestMessageData
        {
            return (this.var_3280);
        }

    }
}