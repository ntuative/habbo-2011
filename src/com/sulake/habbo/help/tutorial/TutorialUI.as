package com.sulake.habbo.help.tutorial
{
    import com.sulake.habbo.help.INameChangeUI;
    import com.sulake.habbo.help.HabboHelp;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.help.enum.HabboHelpTutorialEvent;
    import com.sulake.habbo.session.events.HabboSessionFigureUpdatedEvent;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.avatar.ChangeUserNameMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.avatar.CheckUserNameMessageComposer;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.communication.messages.parser.avatar.ChangeUserNameResultMessageParser;
    import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
    import com.sulake.habbo.communication.messages.parser.avatar.CheckUserNameResultMessageParser;
    import com.sulake.habbo.communication.messages.incoming.avatar.CheckUserNameResultMessageEvent;

    public class TutorialUI implements INameChangeUI 
    {

        public static const var_1427:String = "TUI_MAIN_VIEW";
        public static const var_303:String = "TUI_NAME_VIEW";
        public static const var_1428:String = "TUI_CLOTHES_VIEW";
        public static const var_1429:String = "TUI_GUIDEBOT_VIEW";

        private var var_3481:int = 0;
        private var var_3482:int = 0;
        private var var_3486:HabboHelp;
        private var _window:IFrameWindow;
        private var var_3495:ITutorialUIView;
        private var var_3503:NameChangeView;
        private var var_3189:Boolean = false;
        private var var_3190:Boolean = false;
        private var var_3191:Boolean = false;
        private var var_3504:Boolean = false;
        private var var_3505:Boolean;

        public function TutorialUI(param1:HabboHelp, param2:Boolean=true)
        {
            this.var_3486 = param1;
            this.var_3505 = param2;
            this.var_3486.events.addEventListener(HabboHelpTutorialEvent.var_1424, this.onTaskDoneEvent);
            this.var_3486.events.addEventListener(HabboHelpTutorialEvent.var_1430, this.onTaskDoneEvent);
            this.var_3486.events.addEventListener(HabboHelpTutorialEvent.var_1431, this.onTaskDoneEvent);
            if (this.var_3486.sessionDataManager != null)
            {
                this.var_3486.sessionDataManager.events.addEventListener(HabboSessionFigureUpdatedEvent.var_1432, this.onFigureUpdate);
            };
        }

        public function get help():HabboHelp
        {
            return (this.var_3486);
        }

        public function get assets():IAssetLibrary
        {
            return (this.var_3486.assets);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (this.var_3486.localization);
        }

        public function get myName():String
        {
            return (this.var_3486.ownUserName);
        }

        public function get hasTasksDone():Boolean
        {
            return (((this.var_3189) && (this.var_3190)) && (this.var_3191));
        }

        public function get hasChangedLooks():Boolean
        {
            return (this.var_3189);
        }

        public function get hasChangedName():Boolean
        {
            return (this.var_3190);
        }

        public function get hasCalledGuideBot():Boolean
        {
            return (this.var_3191);
        }

        public function dispose():void
        {
            this.disposeView();
            if (this.var_3486)
            {
                this.var_3486.events.removeEventListener(HabboHelpTutorialEvent.var_1424, this.onTaskDoneEvent);
                this.var_3486.events.removeEventListener(HabboHelpTutorialEvent.var_1430, this.onTaskDoneEvent);
                this.var_3486.events.removeEventListener(HabboHelpTutorialEvent.var_1431, this.onTaskDoneEvent);
                if (this.var_3486.sessionDataManager != null)
                {
                    this.var_3486.sessionDataManager.events.removeEventListener(HabboSessionFigureUpdatedEvent.var_1432, this.onFigureUpdate);
                };
                this.var_3486 = null;
            };
        }

        public function update(param1:Boolean, param2:Boolean, param3:Boolean):void
        {
            this.var_3189 = param1;
            this.var_3190 = param2;
            this.var_3191 = param3;
            if (((this.var_3495 == null) || (this.var_3495.id == var_1427)))
            {
                this.prepareForTutorial();
                this.showView(var_1427);
            };
        }

        public function onTaskDoneEvent(param1:HabboHelpTutorialEvent):void
        {
            switch (param1.type)
            {
                case HabboHelpTutorialEvent.var_1424:
                    this.var_3191 = true;
                    if (((!(this.var_3495 == null)) && (this.var_3495.id == var_1429)))
                    {
                        this.showView(var_1427);
                    };
                    return;
                case HabboHelpTutorialEvent.var_1430:
                    if (((!(this.var_3495 == null)) && (this.var_3495.id == var_1428)))
                    {
                        this.var_3504 = true;
                        this.disposeWindow();
                    };
                    return;
                case HabboHelpTutorialEvent.var_1431:
                    if (this.var_3504)
                    {
                        this.var_3504 = false;
                        this.showView(var_1427);
                    };
                    return;
            };
        }

        public function showView(param1:String):void
        {
            var _loc2_:IItemListWindow;
            if (this.hasTasksDone)
            {
                if (this.var_3486)
                {
                    this.var_3486.removeTutorialUI();
                };
                return;
            };
            var _loc3_:Boolean;
            if (this._window == null)
            {
                this._window = (this.buildXmlWindow("tutorial_frame") as IFrameWindow);
                if (this._window == null)
                {
                    return;
                };
                this._window.procedure = this.windowProcedure;
                _loc2_ = (this._window.findChildByName("content_list") as IItemListWindow);
                if (_loc2_ == null)
                {
                    return;
                };
                this.var_3481 = (this._window.width - _loc2_.width);
                this.var_3482 = this._window.height;
                _loc3_ = true;
            };
            _loc2_ = (this._window.findChildByName("content_list") as IItemListWindow);
            if (_loc2_ == null)
            {
                return;
            };
            _loc2_.destroyListItems();
            _loc2_.height = 0;
            if (this.var_3495 != null)
            {
                this.var_3495.dispose();
            };
            this._window.visible = true;
            switch (param1)
            {
                case var_1427:
                    if (this.var_3503 != null)
                    {
                        this.var_3503.dispose();
                    };
                    if (this.var_3505)
                    {
                        this.var_3495 = new TutorialMainView(_loc2_, this);
                    }
                    else
                    {
                        this._window.visible = false;
                        return;
                    };
                    break;
                case var_303:
                    this._window.visible = false;
                    if (this.var_3503 == null)
                    {
                        this.var_3503 = new NameChangeView(this);
                    };
                    this.var_3503.showMainView();
                    this.prepareForTutorial();
                    break;
                case var_1428:
                    this.var_3495 = new TutorialClothesChangeView(_loc2_, this);
                    break;
                case var_1429:
                    this.var_3495 = new TutorialCallGuideBotView(_loc2_, this);
                    break;
            };
            this._window.height = (_loc2_.height + this.var_3482);
            this._window.width = (_loc2_.width + this.var_3481);
            if (_loc3_)
            {
                if (this._window == null)
                {
                    return;
                };
                this._window.x = ((this._window.context.getDesktopWindow().width / 2) - (this._window.width / 2));
                this._window.y = 0;
            };
        }

        public function buildXmlWindow(param1:String, param2:uint=1):IWindow
        {
            if (((this.var_3486 == null) || (this.var_3486.assets == null)))
            {
                return (null);
            };
            var _loc3_:XmlAsset = XmlAsset(this.var_3486.assets.getAssetByName((param1 + "_xml")));
            if (((_loc3_ == null) || (this.var_3486.windowManager == null)))
            {
                return (null);
            };
            return (this.var_3486.windowManager.buildFromXML(XML(_loc3_.content), param2));
        }

        private function disposeWindow(param1:WindowEvent=null):void
        {
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
        }

        private function disposeView():void
        {
            if (this.var_3495 != null)
            {
                this.var_3495.dispose();
                this.var_3495 = null;
            };
            if (this.var_3503 != null)
            {
                this.var_3503.dispose();
                this.var_3503 = null;
            };
            this.disposeWindow();
        }

        public function setRoomSessionStatus(param1:Boolean):void
        {
            if (param1 == false)
            {
                this.disposeView();
            };
        }

        public function prepareForTutorial():void
        {
            if (((this.var_3486 == null) || (this.var_3486.events == null)))
            {
                return;
            };
            this.var_3486.hideUI();
            this.var_3486.events.dispatchEvent(new HabboHelpTutorialEvent(HabboHelpTutorialEvent.var_1306));
        }

        public function windowProcedure(param1:WindowEvent, param2:IWindow):void
        {
            switch (param1.type)
            {
                case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
                    if (param2.name == "header_button_close")
                    {
                        this.disposeView();
                    };
                    return;
            };
        }

        public function changeName(param1:String):void
        {
            this.disposeWindow();
            this.var_3486.sendMessage(new ChangeUserNameMessageComposer(param1));
        }

        public function checkName(param1:String):void
        {
            this.disposeWindow();
            this.var_3486.sendMessage(new CheckUserNameMessageComposer(param1));
        }

        public function onUserNameChanged(name:String):void
        {
            if ((((!(this.var_3486)) || (!(this.var_3486.localization))) || (!(this.var_3486.windowManager))))
            {
                return;
            };
            this.var_3190 = true;
            this.var_3486.localization.registerParameter("help.tutorial.name.changed", "name", name);
            this.var_3486.windowManager.alert("${generic.notice}", "${help.tutorial.name.changed}", 0, function (param1:IAlertDialog, param2:WindowEvent):void
            {
                param1.dispose();
            });
            if (((!(this.var_3495 == null)) && ((this.var_3495.id == var_303) || (this.var_3495.id == var_1427))))
            {
                this.showView(var_1427);
            };
        }

        private function onFigureUpdate(param1:HabboSessionFigureUpdatedEvent):void
        {
            var _loc2_:Boolean;
            if (((this.var_3486 == null) || (param1 == null)))
            {
                return;
            };
            if (!this.var_3189)
            {
                if (this.var_3486.sessionDataManager != null)
                {
                    _loc2_ = (param1.userId == this.var_3486.sessionDataManager.userId);
                    if (_loc2_)
                    {
                        this.var_3486.sessionDataManager.events.removeEventListener(HabboSessionFigureUpdatedEvent.var_1432, this.onFigureUpdate);
                        this.onUserChanged();
                    };
                };
            };
        }

        public function onUserChanged():void
        {
            this.var_3189 = true;
            if (((!(this.var_3495 == null)) && ((this.var_3495.id == var_1428) || (this.var_3495.id == var_1427))))
            {
                this.showView(var_1427);
            };
        }

        public function onChangeUserNameResult(param1:ChangeUserNameResultMessageEvent):void
        {
            if (param1 == null)
            {
                return;
            };
            var _loc2_:ChangeUserNameResultMessageParser = param1.getParser();
            if (_loc2_.resultCode == ChangeUserNameResultMessageEvent.var_1425)
            {
                this.var_3190 = true;
                this.showView(TutorialUI.var_1427);
            }
            else
            {
                this.var_3503.setNameNotAvailableView(_loc2_.resultCode, _loc2_.name, _loc2_.nameSuggestions);
            };
        }

        public function onCheckUserNameResult(param1:CheckUserNameResultMessageEvent):void
        {
            if (!param1)
            {
                return;
            };
            var _loc2_:CheckUserNameResultMessageParser = param1.getParser();
            if (_loc2_.resultCode == ChangeUserNameResultMessageEvent.var_1425)
            {
                this.var_3503.checkedName = _loc2_.name;
            }
            else
            {
                this.var_3503.setNameNotAvailableView(_loc2_.resultCode, _loc2_.name, _loc2_.nameSuggestions);
            };
        }

    }
}