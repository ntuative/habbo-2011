package com.sulake.habbo.communication.messages.parser.quest
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class QuestsMessageParser implements IMessageParser 
    {

        private var var_3281:Array;
        private var var_3282:Boolean;

        public function flush():Boolean
        {
            var _loc1_:QuestMessageData;
            if (this.var_3281)
            {
                for each (_loc1_ in this.var_3281)
                {
                    _loc1_.dispose();
                };
            };
            this.var_3281 = [];
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_3281.push(new QuestMessageData(param1));
                _loc3_++;
            };
            this.var_3282 = param1.readBoolean();
            return (true);
        }

        public function get quests():Array
        {
            return (this.var_3281);
        }

        public function get openWindow():Boolean
        {
            return (this.var_3282);
        }

    }
}