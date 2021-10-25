package com.sulake.habbo.quest
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.quest.OpenQuestTrackerMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;

    public class QuestCompleted implements IDisposable
    {

        private const var_1917: String = "achievement_bg_001";

        private var _view: IFrameWindow;
        private var _engine: HabboQuestEngine;
        private var _data: QuestMessageData;
        private var _disposed: Boolean = false;

        public function QuestCompleted(param1: HabboQuestEngine, param2: QuestMessageData)
        {
            this._engine = param1;
            this._data = param2;
            this.localize();
        }

        public function dispose(): void
        {
            if (this._view)
            {
                this._view.dispose();
                this._view = null;
            }

            this._disposed = true;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        private function onClose(event: WindowEvent, param2: IWindow): void
        {
            if (event.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                this._engine.send(new OpenQuestTrackerMessageComposer());
                this.dispose();
            }

        }

        private function localize(): void
        {
            this._view = IFrameWindow(this._engine.getXmlWindow("QuestCompletedDialog"));
            this._view.findChildByTag("close").procedure = this.onClose;
            var _loc1_: IWindow = this._view.findChildByName("close_button");
            _loc1_.procedure = this.onClose;
            var _loc2_: String = "quest_" + this._data.campaignCode;
            var _loc3_: String = _loc2_ + "_" + this._data.localizationCode;
            var _loc4_: * = _loc3_ + ".completed.desc";
            this._engine.localization.registerParameter(_loc4_, "amount", this._data.rewardCurrencyAmount.toString());
            this._view.findChildByName("description_txt").caption = this._engine.localization.getKey(_loc4_);
            var _loc5_: * = _loc2_ + ".completed.currency";
            this._engine.localization.registerParameter(_loc5_, "amount", this._data.rewardCurrencyAmount.toString());
            this._view.findChildByName("reward_txt").caption = this._engine.localization.getKey(_loc5_);
            var _loc6_: IWindow = this._view.findChildByName("reward_info_txt");
            _loc6_.caption = this._engine.localization.getKey(_loc2_ + ".completed.reward");
            _loc6_.mouseThreshold = 0;
            _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onRewardInfo);
            var _loc7_: IBitmapWrapperWindow = IBitmapWrapperWindow(this._view.findChildByName("quest.reward.icon"));
            var _loc8_: String = "icon_" + this._data.campaignCode + "_reward_" + this._data.rewardCurrencyAmount;
            this._engine.setImageFromAsset(_loc7_, _loc8_, this.onRewardImageReady);
            var _loc9_: IBitmapWrapperWindow = IBitmapWrapperWindow(this._view.findChildByName("background_image"));
            this._engine.setImageFromAsset(_loc9_, "QuestCompletedBackground", this.onBackgroundImageReady);
            this._view.center();
        }

        private function onRewardImageReady(param1: AssetLoaderEvent): void
        {
            var _loc3_: IBitmapWrapperWindow;
            var _loc2_: AssetLoaderStruct = param1.target as AssetLoaderStruct;
            if (!this._disposed && this._view && _loc2_)
            {
                _loc3_ = IBitmapWrapperWindow(this._view.findChildByName("quest.reward.icon"));
                this._engine.setImageFromAsset(_loc3_, _loc2_.assetName, this.onRewardImageReady);
            }

        }

        private function onBackgroundImageReady(param1: AssetLoaderEvent): void
        {
            var _loc3_: IBitmapWrapperWindow;
            var _loc2_: AssetLoaderStruct = param1.target as AssetLoaderStruct;
            if (!this._disposed && this._view && _loc2_)
            {
                _loc3_ = IBitmapWrapperWindow(this._view.findChildByName("background_image"));
                this._engine.setImageFromAsset(_loc3_, _loc2_.assetName, this.onRewardImageReady);
            }

        }

        public function onRewardInfo(param1: WindowEvent, param2: IWindow = null): void
        {
            if (this._data)
            {
                return;
            }

            var _loc3_: String = "catalog.page.quest." + this._data.campaignCode;
            Logger.log("Questing->Open Catalog: " + _loc3_);
            this._engine.openCatalog(_loc3_);
            param1.stopPropagation();
            param1.stopImmediatePropagation();
        }

    }
}
