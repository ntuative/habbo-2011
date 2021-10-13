package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import flash.utils.Timer;
    import com.sulake.habbo.communication.messages.outgoing.quest.GetQuestsMessageComposer;
    import flash.events.TimerEvent;
    import com.sulake.habbo.communication.messages.outgoing.quest.StartCampaignMessageComposer;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.quest.AcceptQuestMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.quest.RejectQuestMessageComposer;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.quest.enum.QuestTypeEnum;
    import flash.display.BitmapData;
    import com.sulake.habbo.window.utils.IAlertDialog;

    public class QuestController implements IDisposable 
    {

        private static const var_1443:int = 5;

        private var var_3922:HabboQuestEngine;
        private var var_978:Boolean = false;
        private var _window:IFrameWindow;
        private var var_3927:IWindowContainer;
        private var var_3928:IFrameWindow;
        private var var_2190:IItemListWindow;
        private var var_2051:IScrollbarWindow;
        private var var_3929:QuestMessageData;
        private var var_3930:Timer;

        public function QuestController(param1:HabboQuestEngine)
        {
            this.var_3922 = param1;
        }

        public function onToolbarClick():void
        {
            if (!this.isQuestingEnabled())
            {
                this.var_3922.windowManager.alert("${quests.workinprogress.title}", "${quests.workinprogress.text}", 0, this.onAlert);
                return;
            };
            if (this.isVisible())
            {
                this.close();
            }
            else
            {
                this.var_3922.send(new GetQuestsMessageComposer());
            };
        }

        public function onQuests(param1:Array, param2:Boolean):void
        {
            this.checkTrackerClose(param1);
            if (((!(this.isVisible())) && (!(param2))))
            {
                return;
            };
            this.refresh(param1);
            this._window.visible = true;
            this._window.activate();
        }

        public function onQuest(param1:QuestMessageData):void
        {
            this.var_3929 = param1;
            this.prepareTrackerWindow();
            this.refreshTrackerDetails(param1);
            this.var_3927.visible = true;
        }

        public function onRoomEnter():void
        {
            var _loc3_:int;
            var _loc1_:Boolean = Boolean(parseInt(this.var_3922.configuration.getKey("new.identity", "0")));
            var _loc2_:String = this.getDefaultCampaign();
            if (((((this.var_3930 == null) && (_loc1_)) && (!(_loc2_ == ""))) && (this.isQuestingEnabled())))
            {
                _loc3_ = int(this.questEngine.configuration.getKey("questing.startQuestDelayInSeconds", "30"));
                this.var_3930 = new Timer((_loc3_ * 1000), 1);
                this.var_3930.addEventListener(TimerEvent.TIMER, this.onStartQuestTimer);
                this.var_3930.start();
                Logger.log(("Initialized start quest timer with period: " + _loc3_));
            };
        }

        public function onRoomExit():void
        {
            this.close();
            if (((!(this.var_3927 == null)) && (this.var_3927.visible)))
            {
                this.var_3927.findChildByName("more_info_txt").visible = false;
            };
            if (this.var_3928)
            {
                this.var_3928.visible = false;
            };
        }

        public function onStartQuestTimer(param1:TimerEvent):void
        {
            this.var_3922.send(new StartCampaignMessageComposer(this.getDefaultCampaign()));
        }

        private function getDefaultCampaign():String
        {
            var _loc1_:String = this.var_3922.configuration.getKey("questing.defaultCampaign");
            return ((_loc1_ == null) ? "" : _loc1_);
        }

        private function isQuestingEnabled():Boolean
        {
            return (this.var_3922.configuration.getKey("questing.enabled", "false") == "true");
        }

        public function isVisible():Boolean
        {
            return ((this._window) && (this._window.visible));
        }

        public function close():void
        {
            if (this._window)
            {
                this._window.visible = false;
            };
        }

        public function get questEngine():HabboQuestEngine
        {
            return (this.var_3922);
        }

        private function checkTrackerClose(param1:Array):void
        {
            var _loc2_:QuestMessageData;
            for each (_loc2_ in param1)
            {
                if ((((!(this.var_3929 == null)) && (_loc2_.id == this.var_3929.id)) && (_loc2_.accepted)))
                {
                    return;
                };
            };
            this.var_3929 = null;
            if (this.var_3927)
            {
                this.var_3927.visible = false;
            };
            if (this.var_3928)
            {
                this.var_3928.visible = false;
            };
        }

        private function refresh(param1:Array):void
        {
            var _loc3_:Boolean;
            this.prepareWindow();
            this.var_2190.autoArrangeItems = false;
            var _loc2_:int;
            while (true)
            {
                if (_loc2_ < param1.length)
                {
                    this.refreshEntry(true, _loc2_, param1[_loc2_]);
                }
                else
                {
                    _loc3_ = this.refreshEntry(false, _loc2_, null);
                    if (_loc3_) break;
                };
                _loc2_++;
            };
            this.var_2190.autoArrangeItems = true;
        }

        private function prepareWindow():void
        {
            if (this._window != null)
            {
                return;
            };
            this._window = IFrameWindow(this.var_3922.getXmlWindow("Quests"));
            this._window.findChildByTag("close").procedure = this.onWindowClose;
            this.var_2190 = IItemListWindow(this._window.findChildByName("quest_list"));
            this.var_2051 = IScrollbarWindow(this._window.findChildByName("scroller"));
            this._window.center();
            this.var_2190.spacing = 10;
        }

        private function prepareTrackerWindow():void
        {
            if (this.var_3927 != null)
            {
                return;
            };
            this.var_3927 = IWindowContainer(this.var_3922.getXmlWindow("QuestTracker"));
            var _loc1_:IDesktopWindow = this.var_3927.desktop;
            this.var_3927.x = ((_loc1_.width - this.var_3927.width) - 10);
            this.var_3927.y = ((_loc1_.height - this.var_3927.height) / 2);
            this.var_3927.findChildByName("more_info_txt").procedure = this.onMoreInfo;
            this.var_3927.findChildByName("more_info_txt").mouseThreshold = 0;
            new PendingImage(this.var_3922, IBitmapWrapperWindow(this.var_3927.findChildByName("quest_tracker_bg")), "questtrackerbkg");
        }

        private function refreshEntry(param1:Boolean, param2:int, param3:QuestMessageData):Boolean
        {
            var _loc4_:IWindowContainer = IWindowContainer(this.var_2190.getListItemAt(param2));
            var _loc5_:Boolean;
            if (_loc4_ == null)
            {
                if (!param1)
                {
                    return (true);
                };
                _loc4_ = this.createListEntry();
                this.var_2190.addListItem(_loc4_);
                _loc5_ = true;
            };
            if (param1)
            {
                this.refreshEntryDetails(_loc4_, param3);
                _loc4_.visible = true;
            }
            else
            {
                _loc4_.visible = false;
            };
            return (false);
        }

        private function createListEntry():IWindowContainer
        {
            var _loc1_:IWindowContainer = IWindowContainer(this.var_3922.getXmlWindow("QuestEntry"));
            var _loc2_:IWindowContainer = IWindowContainer(this.var_3922.getXmlWindow("Campaign"));
            var _loc3_:IWindowContainer = IWindowContainer(this.var_3922.getXmlWindow("Quest"));
            var _loc4_:IWindowContainer = IWindowContainer(this.var_3922.getXmlWindow("EntryArrows"));
            _loc1_.addChild(_loc2_);
            _loc1_.addChild(_loc3_);
            _loc1_.addChild(_loc4_);
            _loc3_.findChildByName("accept_button").procedure = this.onAcceptQuest;
            _loc3_.findChildByName("cancel_txt").procedure = this.onCancelQuest;
            _loc1_.findChildByName("hint_txt").visible = false;
            new PendingImage(this.var_3922, IBitmapWrapperWindow(_loc4_.findChildByName("arrow_0")), "quest_arrow1");
            new PendingImage(this.var_3922, IBitmapWrapperWindow(_loc4_.findChildByName("arrow_1")), "quest_arrow2");
            new PendingImage(this.var_3922, IBitmapWrapperWindow(_loc2_.findChildByName("completion_bg_bitmap")), "quest_counterbkg");
            _loc3_.x = ((_loc2_.x + _loc2_.width) + var_1443);
            _loc1_.width = (_loc3_.x + _loc3_.width);
            this.setEntryHeight(_loc1_);
            return (_loc1_);
        }

        private function setEntryHeight(param1:IWindowContainer):void
        {
            var _loc2_:IWindowContainer = IWindowContainer(param1.findChildByName("campaign_container"));
            var _loc3_:IWindowContainer = IWindowContainer(param1.findChildByName("quest_container"));
            var _loc4_:IWindowContainer = IWindowContainer(param1.findChildByName("entry_arrows_cont"));
            _loc2_.height = _loc3_.height;
            param1.height = _loc3_.height;
            _loc4_.x = ((_loc2_.x + _loc2_.width) - 2);
            _loc4_.y = (Math.floor(((_loc2_.height - _loc4_.height) / 2)) + 1);
            _loc2_.findChildByName("completion_txt").y = (_loc2_.height - 32);
            var _loc5_:int = 2;
            var _loc6_:IWindow = _loc2_.findChildByName("bg_bottom");
            _loc6_.height = Math.floor(((_loc2_.height - (2 * _loc5_)) / 2));
            _loc6_.y = (_loc5_ + _loc6_.height);
        }

        private function refreshEntryDetails(param1:IWindowContainer, param2:QuestMessageData):void
        {
            param1.findChildByName("campaign_header_txt").caption = this.getCampaignName(param2);
            param1.findChildByName("completion_txt").caption = ((param2.completedQuestsInCampaign + "/") + param2.questCountInCampaign);
            param1.findChildByName("quest_header_txt").caption = this.getQuestTitle(param2);
            param1.findChildByName("desc_txt").caption = this.getQuestDesc(param2);
            param1.findChildByName("reward_amount_txt").caption = ("" + param2.rewardCurrencyAmount);
            param1.findChildByName("cancel_txt").visible = param2.accepted;
            param1.findChildByName("cancel_txt").mouseThreshold = 0;
            param1.findChildByName("accept_button").visible = (!(param2.accepted));
            param1.findChildByName("accept_button").id = param2.id;
            param1.findChildByName("arrow_0").visible = (!(param2.accepted));
            param1.findChildByName("arrow_1").visible = param2.accepted;
            var _loc3_:Boolean = param2.accepted;
            this.setColor(param1, "quest_container", _loc3_, 15982264, 0xC8C8C8);
            this.setColor(param1, "quest_header", _loc3_, 15577658, 0x8D8D8D);
            this.setColor(param1, "bg", _loc3_, 4290944315, 4284769380);
            this.setColor(param1, "bg_top", _loc3_, 0xFFFFD788, 4290427578);
            this.setColor(param1, "bg_bottom", _loc3_, 0xFFFFC758, 4289440683);
            ITextWindow(param1.findChildByName("quest_header_txt")).textColor = ((_loc3_) ? 0xFFFFFFFF : 4281808695);
            this.setupQuestImage(param1, param2);
            this.setupRewardImage(param1, param2);
            this.setupCampaignImage(param1, param2);
        }

        private function getQuestLocalizationKey(param1:QuestMessageData):String
        {
            return ((("quest_" + param1.campaignCode) + "_") + param1.localizationCode);
        }

        private function getQuestTitle(param1:QuestMessageData):String
        {
            var _loc2_:* = (this.getQuestLocalizationKey(param1) + ".short");
            return ((((((this.getCampaignName(param1) + ": ") + (param1.completedQuestsInCampaign + 1)) + "/") + param1.questCountInCampaign) + ": ") + this.questEngine.localization.getKey(_loc2_, _loc2_));
        }

        private function getQuestDesc(param1:QuestMessageData):String
        {
            var _loc2_:* = (this.getQuestLocalizationKey(param1) + ".desc");
            return (this.questEngine.localization.getKey(_loc2_, _loc2_));
        }

        private function getQuestHint(param1:QuestMessageData):String
        {
            var _loc2_:* = (this.getQuestLocalizationKey(param1) + ".hint");
            return (this.questEngine.localization.getKey(_loc2_, _loc2_));
        }

        private function getCampaignName(param1:QuestMessageData):String
        {
            var _loc2_:* = (("quest_" + param1.campaignCode) + ".tab");
            return (this.questEngine.localization.getKey(_loc2_, _loc2_));
        }

        private function setColor(param1:IWindowContainer, param2:String, param3:Boolean, param4:uint, param5:uint):void
        {
            param1.findChildByName(param2).color = ((param3) ? param4 : param5);
        }

        private function refreshTrackerDetails(param1:QuestMessageData):void
        {
            this.var_3927.findChildByName("header_txt").caption = this.getQuestTitle(param1);
            this.var_3927.findChildByName("desc_txt").caption = this.getQuestDesc(param1);
            this.var_3927.findChildByName("more_info_txt").visible = true;
            this.var_3922.localization.registerParameter("quests.tracker.progress", "completedSteps", ("" + param1.completedSteps));
            this.var_3922.localization.registerParameter("quests.tracker.progress", "totalSteps", ("" + param1.totalSteps));
            this.setupQuestImage(this.var_3927, param1);
        }

        private function onAcceptQuest(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            var _loc3_:int = param2.id;
            Logger.log(("Accept quest: " + _loc3_));
            this.var_3922.send(new AcceptQuestMessageComposer(_loc3_));
            this._window.visible = false;
        }

        private function onCancelQuest(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log("Reject quest");
            this.var_3922.send(new RejectQuestMessageComposer());
        }

        private function onMoreInfo(param1:WindowEvent, param2:IWindow):void
        {
            var _loc7_:IWindowContainer;
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            if (((this.var_3928) && (this.var_3928.visible)))
            {
                this.var_3928.visible = false;
                return;
            };
            if (this.var_3929 == null)
            {
                return;
            };
            if (this.var_3928 == null)
            {
                this.var_3928 = IFrameWindow(this.var_3922.getXmlWindow("QuestDetails"));
                this.var_3928.findChildByTag("close").procedure = this.onDetailsWindowClose;
                this.var_3928.center();
                _loc7_ = this.createListEntry();
                _loc7_.x = 10;
                _loc7_.y = 10;
                this.var_3928.content.addChild(_loc7_);
            };
            _loc7_ = IWindowContainer(this.var_3928.findChildByName("entry_container"));
            this.refreshEntryDetails(_loc7_, this.var_3929);
            var _loc3_:ITextWindow = ITextWindow(_loc7_.findChildByName("hint_txt"));
            var _loc4_:int = _loc3_.height;
            _loc3_.caption = this.getQuestHint(this.var_3929);
            _loc3_.height = (_loc3_.textHeight + 5);
            var _loc5_:int = ((_loc3_.height - _loc4_) + ((_loc3_.visible) ? 0 : 30));
            var _loc6_:IWindowContainer = IWindowContainer(_loc7_.findChildByName("quest_container"));
            _loc6_.height = (_loc6_.height + _loc5_);
            _loc3_.visible = true;
            this.setEntryHeight(_loc7_);
            this.var_3928.height = (_loc7_.height + 55);
            this.var_3928.visible = true;
        }

        private function onWindowClose(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                this.close();
            };
        }

        private function onDetailsWindowClose(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                this.var_3928.visible = false;
            };
        }

        public function dispose():void
        {
            this.var_978 = true;
            if (this._window)
            {
                this._window.dispose();
                this._window = null;
            };
            if (this.var_3927)
            {
                this.var_3927.dispose();
                this.var_3927 = null;
            };
            if (this.var_3928)
            {
                this.var_3928.dispose();
                this.var_3928 = null;
            };
            if (this.var_3930)
            {
                this.var_3930.stop();
                this.var_3930 = null;
            };
            this.var_2190 = null;
            this.var_2051 = null;
        }

        public function get disposed():Boolean
        {
            return (this.var_978);
        }

        private function setupQuestImage(param1:IWindowContainer, param2:QuestMessageData):void
        {
            var _loc4_:Array;
            var _loc5_:String;
            var _loc6_:int;
            var _loc7_:IFurnitureData;
            var _loc3_:IBitmapWrapperWindow = IBitmapWrapperWindow(param1.findChildByName("quest_pic_bitmap"));
            if (_loc3_.id == param2.id)
            {
                Logger.log("No need to refresh image...");
                return;
            };
            _loc3_.id = param2.id;
            if (param2.type == QuestTypeEnum.FIND_STUFF)
            {
                _loc4_ = param2.roomItemTypeName.split("*");
                _loc5_ = ((_loc4_.length > 0) ? _loc4_[0] : "");
                _loc6_ = ((_loc4_.length > 1) ? parseInt(_loc4_[1]) : 0);
                _loc7_ = this.var_3922.sessionDataManager.getFloorItemDataByName(_loc5_, _loc6_);
                if (_loc7_)
                {
                    new PendingFurniImage(this.var_3922, _loc3_, _loc7_, _loc6_);
                };
            }
            else
            {
                if (param2.type == QuestTypeEnum.FIND_HIDDEN_STUFF)
                {
                    new PendingImage(this.var_3922, _loc3_, "icon_quest_hidden");
                }
                else
                {
                    if (param2.type == QuestTypeEnum.GIVE_BADGE)
                    {
                        new PendingImage(this.var_3922, _loc3_, "NewUserBadgeReceiver");
                    }
                    else
                    {
                        QuestUtils.setElementImage(_loc3_, new BitmapData(1, 1, true));
                    };
                };
            };
        }

        private function setupRewardImage(param1:IWindowContainer, param2:QuestMessageData):void
        {
            var _loc3_:IBitmapWrapperWindow = IBitmapWrapperWindow(param1.findChildByName("currency_bitmap"));
            if (_loc3_.id == param2.id)
            {
                Logger.log("No need to refresh reward image...");
                return;
            };
            _loc3_.id = param2.id;
            new PendingImage(this.var_3922, _loc3_, "quest_pixel");
        }

        private function setupCampaignImage(param1:IWindowContainer, param2:QuestMessageData):void
        {
            var _loc3_:IBitmapWrapperWindow = IBitmapWrapperWindow(param1.findChildByName("campaign_pic_bitmap"));
            if (_loc3_.tags[0] == param2.campaignCode)
            {
                Logger.log("No need to refresh campaign image...");
                return;
            };
            _loc3_.tags[0] = param2.campaignCode;
            var _loc4_:String = "icon_quest_hidden";
            new PendingImage(this.var_3922, _loc3_, _loc4_);
        }

        public function onAlert(param1:IAlertDialog, param2:WindowEvent):void
        {
            if (((param2.type == WindowEvent.var_138) || (param2.type == WindowEvent.var_139)))
            {
                param1.dispose();
            };
        }

    }
}