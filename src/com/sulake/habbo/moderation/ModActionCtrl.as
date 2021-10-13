package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.habbo.communication.messages.incoming.moderation.OffenceCategoryData;
    import com.sulake.habbo.communication.messages.incoming.moderation.OffenceData;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.incoming.moderation.INamed;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModAlertMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModKickMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModBanMessageComposer;
    import com.sulake.habbo.window.utils.IAlertDialog;

    public class ModActionCtrl implements IDisposable, TrackedWindow 
    {

        private static var var_3680:Array;

        private var var_3486:ModerationManager;
        private var var_3681:int;
        private var var_3682:String;
        private var var_3683:String;
        private var _frame:IFrameWindow;
        private var var_3684:IDropMenuWindow;
        private var var_3685:ITextFieldWindow;
        private var _disposed:Boolean;
        private var var_3686:Boolean = true;
        private var var_3687:OffenceCategoryData;
        private var var_3688:OffenceData;
        private var var_3689:IButtonWindow;
        private var var_3690:IButtonWindow;

        public function ModActionCtrl(param1:ModerationManager, param2:int, param3:String, param4:String)
        {
            this.var_3486 = param1;
            this.var_3681 = param2;
            this.var_3682 = param3;
            this.var_3683 = param4;
            if (var_3680 == null)
            {
                var_3680 = new Array();
                var_3680.push(new BanDefinition("2 hours", 2));
                var_3680.push(new BanDefinition("4 hours", 4));
                var_3680.push(new BanDefinition("12 hours", 12));
                var_3680.push(new BanDefinition("24 hours", 24));
                var_3680.push(new BanDefinition("2 days", 48));
                var_3680.push(new BanDefinition("3 days", 72));
                var_3680.push(new BanDefinition("1 week", 168));
                var_3680.push(new BanDefinition("2 weeks", 336));
                var_3680.push(new BanDefinition("3 weeks", 504));
                var_3680.push(new BanDefinition("1 month", 720));
                var_3680.push(new BanDefinition("2 months", 1440));
                var_3680.push(new BanDefinition("1 year", 8760));
                var_3680.push(new BanDefinition("2 years", 17520));
                var_3680.push(new BanDefinition("Permanent", 100000));
            };
            this.var_3689 = IButtonWindow(this.var_3486.getXmlWindow("modact_offence"));
            this.var_3690 = IButtonWindow(this.var_3486.getXmlWindow("modact_offencectg"));
        }

        public static function hideChildren(param1:IWindowContainer):void
        {
            var _loc2_:int;
            while (_loc2_ < param1.numChildren)
            {
                param1.getChildAt(_loc2_).visible = false;
                _loc2_++;
            };
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function show():void
        {
            this._frame = IFrameWindow(this.var_3486.getXmlWindow("modact_summary"));
            this._frame.caption = ("Mod action on: " + this.var_3682);
            this._frame.findChildByName("send_caution_but").procedure = this.onSendCautionButton;
            this._frame.findChildByName("kick_but").procedure = this.onKickButton;
            this._frame.findChildByName("ban_but").procedure = this.onBanButton;
            this._frame.findChildByName("change_categorization_but").procedure = this.onChangeCategorizationButton;
            this.var_3486.disableButton(this.var_3486.initMsg.alertPermission, this._frame, "send_caution_but");
            this.var_3486.disableButton(this.var_3486.initMsg.kickPermission, this._frame, "kick_but");
            this.var_3486.disableButton(this.var_3486.initMsg.banPermission, this._frame, "ban_but");
            this.var_3685 = ITextFieldWindow(this._frame.findChildByName("message_input"));
            this.var_3685.procedure = this.onInputClick;
            this.var_3684 = IDropMenuWindow(this._frame.findChildByName("banLengthSelect"));
            this.prepareBanSelect(this.var_3684);
            var _loc1_:IWindow = this._frame.findChildByTag("close");
            _loc1_.procedure = this.onClose;
            this.refreshCategorization();
            this._frame.visible = true;
        }

        public function refreshCategorization():void
        {
            var _loc1_:IWindowContainer = IWindowContainer(this._frame.findChildByName("categorization_cont"));
            hideChildren(_loc1_);
            _loc1_.findChildByName("categorization_caption_txt").visible = true;
            _loc1_.findChildByName("change_categorization_but").visible = (!(this.var_3687 == null));
            if (this.var_3688 != null)
            {
                this._frame.findChildByName("offence_txt").caption = this.var_3688.name;
                this._frame.findChildByName("offence_category").visible = true;
            }
            else
            {
                if (this.var_3687 != null)
                {
                    this.refreshButtons("offences_cont", 2, this.var_3687.offences, this.var_3689, this.onOffenceButton);
                }
                else
                {
                    this.refreshButtons("offence_categories_cont", 3, this.var_3486.initMsg.offenceCategories, this.var_3690, this.onOffenceCtgButton);
                    _loc1_.height = RoomToolCtrl.getLowestPoint(_loc1_);
                };
            };
        }

        private function refreshButtons(param1:String, param2:int, param3:Array, param4:IWindow, param5:Function):void
        {
            var _loc11_:INamed;
            var _loc12_:String;
            var _loc13_:IButtonWindow;
            var _loc6_:IWindowContainer = IWindowContainer(this._frame.findChildByName(param1));
            hideChildren(_loc6_);
            var _loc7_:int;
            var _loc8_:int;
            var _loc9_:int;
            var _loc10_:int = 5;
            for each (_loc11_ in param3)
            {
                _loc12_ = ("" + _loc7_);
                _loc13_ = IButtonWindow(_loc6_.findChildByName(_loc12_));
                if (_loc13_ == null)
                {
                    _loc13_ = IButtonWindow(param4.clone());
                    _loc13_.procedure = param5;
                    _loc13_.x = (_loc9_ * (param4.width + _loc10_));
                    _loc13_.y = (_loc8_ * (param4.height + _loc10_));
                    _loc13_.name = _loc12_;
                    _loc6_.addChild(_loc13_);
                };
                _loc13_.caption = _loc11_.name;
                _loc13_.visible = true;
                _loc7_++;
                if (++_loc9_ >= param2)
                {
                    _loc9_ = 0;
                    _loc8_++;
                };
            };
            _loc6_.height = RoomToolCtrl.getLowestPoint(_loc6_);
            _loc6_.visible = true;
        }

        public function getType():int
        {
            return (WindowTracker.var_1524);
        }

        public function getId():String
        {
            return (this.var_3682);
        }

        public function getFrame():IFrameWindow
        {
            return (this._frame);
        }

        private function prepareBanSelect(param1:IDropMenuWindow):void
        {
            var _loc3_:BanDefinition;
            var _loc2_:Array = new Array();
            for each (_loc3_ in var_3680)
            {
                _loc2_.push(_loc3_.name);
            };
            param1.populate(_loc2_);
        }

        private function onSendCautionButton(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log("Sending caution...");
            if (!this.isMsgGiven())
            {
                return;
            };
            this.var_3486.connection.send(new ModAlertMessageComposer(this.var_3681, this.var_3685.text, this.var_3683));
            this.dispose();
        }

        private function onOffenceCtgButton(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            var _loc3_:int = int(param2.name);
            this.var_3687 = this.var_3486.initMsg.offenceCategories[_loc3_];
            this.refreshCategorization();
        }

        private function onOffenceButton(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            var _loc3_:int = int(param2.name);
            this.var_3688 = this.var_3687.offences[_loc3_];
            this.var_3685.text = this.var_3688.msg;
            this.var_3686 = false;
            this.refreshCategorization();
        }

        private function onChangeCategorizationButton(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            if (this.var_3688 != null)
            {
                this.var_3688 = null;
            }
            else
            {
                this.var_3687 = null;
            };
            this.refreshCategorization();
        }

        private function onKickButton(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log("Kick...");
            if (!this.isMsgGiven())
            {
                return;
            };
            this.var_3486.connection.send(new ModKickMessageComposer(this.var_3681, this.var_3685.text, this.var_3683));
            this.dispose();
        }

        private function onBanButton(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            Logger.log("Ban...");
            if (!this.isMsgGiven())
            {
                return;
            };
            if (this.var_3684.selection < 0)
            {
                this.var_3486.windowManager.alert("Alert", "You must select ban lenght", 0, this.onAlertClose);
                return;
            };
            this.var_3486.connection.send(new ModBanMessageComposer(this.var_3681, this.var_3685.text, this.getBanLength(), this.var_3683));
            this.dispose();
        }

        private function isMsgGiven():Boolean
        {
            if (((this.var_3686) || (this.var_3685.text == "")))
            {
                this.var_3486.windowManager.alert("Alert", "You must input a message to the user", 0, this.onAlertClose);
                return (false);
            };
            return (true);
        }

        private function getBanLength():int
        {
            var _loc1_:int = this.var_3684.selection;
            var _loc2_:BanDefinition = var_3680[_loc1_];
            return (_loc2_.banLengthHours);
        }

        private function onClose(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            this.dispose();
        }

        private function onInputClick(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowEvent.var_552)
            {
                return;
            };
            if (!this.var_3686)
            {
                return;
            };
            this.var_3685.text = "";
            this.var_3686 = false;
        }

        public function dispose():void
        {
            if (this._disposed)
            {
                return;
            };
            this._disposed = true;
            if (this._frame != null)
            {
                this._frame.destroy();
                this._frame = null;
            };
            if (this.var_3689 != null)
            {
                this.var_3689.destroy();
                this.var_3689 = null;
            };
            if (this.var_3690 != null)
            {
                this.var_3690.destroy();
                this.var_3690 = null;
            };
            this.var_3684 = null;
            this.var_3685 = null;
            this.var_3486 = null;
        }

        private function onAlertClose(param1:IAlertDialog, param2:WindowEvent):void
        {
            param1.dispose();
        }

    }
}