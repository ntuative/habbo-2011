package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestCompletedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageEvent;
    import com.sulake.habbo.communication.messages.parser.quest.QuestCompletedMessageParser;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.quest.QuestsMessageParser;
    import com.sulake.habbo.communication.messages.parser.quest.QuestMessageParser;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.toolbar.events.HabboToolbarSetIconEvent;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;

    public class IncomingMessages implements IDisposable 
    {

        private var var_3922:HabboQuestEngine;
        private var _communication:IHabboCommunicationManager;
        private var var_3923:IAlertDialog;
        private var var_978:Boolean = false;

        public function IncomingMessages(param1:HabboQuestEngine)
        {
            this.var_3922 = param1;
            this._communication = this.var_3922.communication;
            this._communication.addHabboConnectionMessageEvent(new QuestCompletedMessageEvent(this.onQuestCompleted));
            this._communication.addHabboConnectionMessageEvent(new CloseConnectionMessageEvent(this.onRoomExit));
            this._communication.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(this.onRoomEnter));
            this._communication.addHabboConnectionMessageEvent(new QuestsMessageEvent(this.onQuests));
            this._communication.addHabboConnectionMessageEvent(new QuestMessageEvent(this.onQuest));
        }

        public function get disposed():Boolean
        {
            return (this.var_978);
        }

        private function onQuestCompleted(param1:IMessageEvent):void
        {
            var _loc2_:QuestCompletedMessageParser = (param1 as QuestCompletedMessageEvent).getParser();
            Logger.log(((("Quest Completed: " + _loc2_.questData.campaignCode) + " quest: ") + _loc2_.questData.id));
            new QuestCompleted(this.var_3922, _loc2_.questData);
        }

        private function onQuests(param1:IMessageEvent):void
        {
            var _loc2_:QuestsMessageParser = (param1 as QuestsMessageEvent).getParser();
            Logger.log(((("Got Quests: " + _loc2_.quests) + ", ") + _loc2_.openWindow));
            this.var_3922.controller.onQuests(_loc2_.quests, _loc2_.openWindow);
        }

        private function onQuest(param1:IMessageEvent):void
        {
            var _loc2_:QuestMessageParser = (param1 as QuestMessageEvent).getParser();
            Logger.log(("Got Quest: " + _loc2_.quest));
            this.var_3922.controller.onQuest(_loc2_.quest);
        }

        public function dispose():void
        {
            if (this.var_3923)
            {
                this.var_3923.dispose();
                this.var_3923 = null;
            };
            this.var_978 = true;
        }

        private function onCloseAlert(param1:IAlertDialog, param2:WindowEvent):void
        {
            param1.dispose();
        }

        private function getCampaignCode():String
        {
            var _loc1_:String = this.var_3922.configuration.getKey("questing.defaultCampaign", "");
            var _loc2_:String = this.var_3922.configuration.getKey("questing.defaultCampaign.override", "");
            var _loc3_:String = this.var_3922.configuration.getKey("questing.excludedCampaignCode", "");
            var _loc4_:String = (((_loc1_) && (!(_loc1_ == ""))) ? _loc1_ : "");
            return ((((_loc2_) && (!(_loc2_ == ""))) && (!(_loc2_ == _loc3_))) ? _loc2_ : _loc4_);
        }

        private function onRoomEnter(param1:IMessageEvent):void
        {
            this.var_3922.controller.onRoomEnter();
            this.var_3922.toolbar.events.dispatchEvent(new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.var_145, HabboToolbarIconEnum.QUESTS));
        }

        private function onRoomExit(param1:IMessageEvent):void
        {
            this.var_3922.controller.onRoomExit();
            this.var_3922.toolbar.events.dispatchEvent(new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.var_306, HabboToolbarIconEnum.QUESTS));
        }

    }
}