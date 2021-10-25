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

        private var _engine: HabboQuestEngine;
        private var _communication: IHabboCommunicationManager;
        private var _dialog: IAlertDialog;
        private var _disposed: Boolean = false;

        public function IncomingMessages(engine: HabboQuestEngine)
        {
            this._engine = engine;
            this._communication = this._engine.communication;

            this._communication.addHabboConnectionMessageEvent(new QuestCompletedMessageEvent(this.onQuestCompleted));
            this._communication.addHabboConnectionMessageEvent(new CloseConnectionMessageEvent(this.onRoomExit));
            this._communication.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(this.onRoomEnter));
            this._communication.addHabboConnectionMessageEvent(new QuestsMessageEvent(this.onQuests));
            this._communication.addHabboConnectionMessageEvent(new QuestMessageEvent(this.onQuest));
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        private function onQuestCompleted(event: IMessageEvent): void
        {
            var parser: QuestCompletedMessageParser = (event as QuestCompletedMessageEvent).getParser();
           
            Logger.log("Quest Completed: " + parser.questData.campaignCode + " quest: " + parser.questData.id);
           
            new QuestCompleted(this._engine, parser.questData);
        }

        private function onQuests(event: IMessageEvent): void
        {
            var parser: QuestsMessageParser = (event as QuestsMessageEvent).getParser();
            
            Logger.log("Got Quests: " + parser.quests + ", " + parser.openWindow);
            
            this._engine.controller.onQuests(parser.quests, parser.openWindow);
        }

        private function onQuest(event: IMessageEvent): void
        {
            var parser: QuestMessageParser = (event as QuestMessageEvent).getParser();
            
            Logger.log("Got Quest: " + parser.quest);
            
            this._engine.controller.onQuest(parser.quest);
        }

        public function dispose(): void
        {
            if (this._dialog)
            {
                this._dialog.dispose();
                this._dialog = null;
            }

            this._disposed = true;
        }

        private function onCloseAlert(param1: IAlertDialog, param2: WindowEvent): void
        {
            param1.dispose();
        }

        private function getCampaignCode(): String
        {
            var defaultCampaign: String = this._engine.configuration.getKey("questing.defaultCampaign", "");
            var overrideCampaign: String = this._engine.configuration.getKey("questing.defaultCampaign.override", "");
            var excludedCampaignCode: String = this._engine.configuration.getKey("questing.excludedCampaignCode", "");
            var normalizedCampaign: String = defaultCampaign && defaultCampaign != "" ? defaultCampaign : "";
            
            return overrideCampaign && overrideCampaign != "" && overrideCampaign != excludedCampaignCode ? overrideCampaign : normalizedCampaign;
        }

        private function onRoomEnter(event: IMessageEvent): void
        {
            this._engine.controller.onRoomEnter();
            this._engine.toolbar.events.dispatchEvent(new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.var_145, HabboToolbarIconEnum.QUESTS));
        }

        private function onRoomExit(event: IMessageEvent): void
        {
            this._engine.controller.onRoomExit();
            this._engine.toolbar.events.dispatchEvent(new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.var_306, HabboToolbarIconEnum.QUESTS));
        }

    }
}
