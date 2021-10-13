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

        private const var_1917:String = "achievement_bg_001";

        private var var_3926:IFrameWindow;
        private var var_3922:HabboQuestEngine;
        private var var_3280:QuestMessageData;
        private var var_978:Boolean = false;

        public function QuestCompleted(param1:HabboQuestEngine, param2:QuestMessageData)
        {
            this.var_3922 = param1;
            this.var_3280 = param2;
            this.localize();
        }

        public function dispose():void
        {
            if (this.var_3926)
            {
                this.var_3926.dispose();
                this.var_3926 = null;
            };
            this.var_978 = true;
        }

        public function get disposed():Boolean
        {
            return (this.var_978);
        }

        private function onClose(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                this.var_3922.send(new OpenQuestTrackerMessageComposer());
                this.dispose();
            };
        }

        private function localize():void
        {
            this.var_3926 = IFrameWindow(this.var_3922.getXmlWindow("QuestCompletedDialog"));
            this.var_3926.findChildByTag("close").procedure = this.onClose;
            var _loc1_:IWindow = this.var_3926.findChildByName("close_button");
            _loc1_.procedure = this.onClose;
            var _loc2_:String = ("quest_" + this.var_3280.campaignCode);
            var _loc3_:String = ((_loc2_ + "_") + this.var_3280.localizationCode);
            var _loc4_:* = (_loc3_ + ".completed.desc");
            this.var_3922.localization.registerParameter(_loc4_, "amount", this.var_3280.rewardCurrencyAmount.toString());
            this.var_3926.findChildByName("description_txt").caption = this.var_3922.localization.getKey(_loc4_);
            var _loc5_:* = (_loc2_ + ".completed.currency");
            this.var_3922.localization.registerParameter(_loc5_, "amount", this.var_3280.rewardCurrencyAmount.toString());
            this.var_3926.findChildByName("reward_txt").caption = this.var_3922.localization.getKey(_loc5_);
            var _loc6_:IWindow = this.var_3926.findChildByName("reward_info_txt");
            _loc6_.caption = this.var_3922.localization.getKey((_loc2_ + ".completed.reward"));
            _loc6_.mouseThreshold = 0;
            _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onRewardInfo);
            var _loc7_:IBitmapWrapperWindow = IBitmapWrapperWindow(this.var_3926.findChildByName("quest.reward.icon"));
            var _loc8_:String = ((("icon_" + this.var_3280.campaignCode) + "_reward_") + this.var_3280.rewardCurrencyAmount);
            this.var_3922.setImageFromAsset(_loc7_, _loc8_, this.onRewardImageReady);
            var _loc9_:IBitmapWrapperWindow = IBitmapWrapperWindow(this.var_3926.findChildByName("background_image"));
            this.var_3922.setImageFromAsset(_loc9_, "QuestCompletedBackground", this.onBackgroundImageReady);
            this.var_3926.center();
        }

        private function onRewardImageReady(param1:AssetLoaderEvent):void
        {
            var _loc3_:IBitmapWrapperWindow;
            var _loc2_:AssetLoaderStruct = (param1.target as AssetLoaderStruct);
            if ((((!(this.var_978)) && (this.var_3926)) && (_loc2_)))
            {
                _loc3_ = IBitmapWrapperWindow(this.var_3926.findChildByName("quest.reward.icon"));
                this.var_3922.setImageFromAsset(_loc3_, _loc2_.assetName, this.onRewardImageReady);
            };
        }

        private function onBackgroundImageReady(param1:AssetLoaderEvent):void
        {
            var _loc3_:IBitmapWrapperWindow;
            var _loc2_:AssetLoaderStruct = (param1.target as AssetLoaderStruct);
            if ((((!(this.var_978)) && (this.var_3926)) && (_loc2_)))
            {
                _loc3_ = IBitmapWrapperWindow(this.var_3926.findChildByName("background_image"));
                this.var_3922.setImageFromAsset(_loc3_, _loc2_.assetName, this.onRewardImageReady);
            };
        }

        public function onRewardInfo(param1:WindowEvent, param2:IWindow=null):void
        {
            if (this.var_3280)
            {
                return;
            };
            var _loc3_:String = ("catalog.page.quest." + this.var_3280.campaignCode);
            Logger.log(("Questing->Open Catalog: " + _loc3_));
            this.var_3922.openCatalog(_loc3_);
            param1.stopPropagation();
            param1.stopImmediatePropagation();
        }

    }
}