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

        public static const TUTORIAL_UI_MAIN_VIEW: String = "TUI_MAIN_VIEW";
        public static const TUTORIAL_UI_NAME_VIEW: String = "TUI_NAME_VIEW";
        public static const TUTORIAL_UI_CLOTHES_VIEW: String = "TUI_CLOTHES_VIEW";
        public static const TUTORIAL_UI_GUIDEBOT_VIEW: String = "TUI_GUIDEBOT_VIEW";

        private var _width: int = 0;
        private var _height: int = 0;
        private var _help: HabboHelp;
        private var _window: IFrameWindow;
        private var _tutorialUI: ITutorialUIView;
        private var _nameChangeUI: NameChangeView;
        private var _hasChangedLooks: Boolean = false;
        private var _hasChangedName: Boolean = false;
        private var _hasCalledGuideBot: Boolean = false;
        private var _isEditingAvatar: Boolean = false;
        private var _visible: Boolean;

        public function TutorialUI(help: HabboHelp, visible: Boolean = true)
        {
            this._help = help;
            this._visible = visible;
            
            this._help.events.addEventListener(HabboHelpTutorialEvent.HHTPNUFWE_DONE_GUIDEBOT, this.onTaskDoneEvent);
            this._help.events.addEventListener(HabboHelpTutorialEvent.HHTE_DONE_AVATAR_EDITOR_OPENING, this.onTaskDoneEvent);
            this._help.events.addEventListener(HabboHelpTutorialEvent.HHTE_DONE_AVATAR_EDITOR_CLOSING, this.onTaskDoneEvent);
            
            if (this._help.sessionDataManager != null)
            {
                this._help.sessionDataManager.events.addEventListener(HabboSessionFigureUpdatedEvent.HABBO_SESSION_FIGURE_UPDATE, this.onFigureUpdate);
            }

        }

        public function get help(): HabboHelp
        {
            return this._help;
        }

        public function get assets(): IAssetLibrary
        {
            return this._help.assets;
        }

        public function get localization(): IHabboLocalizationManager
        {
            return this._help.localization;
        }

        public function get myName(): String
        {
            return this._help.ownUserName;
        }

        public function get hasTasksDone(): Boolean
        {
            return this._hasChangedLooks && this._hasChangedName && this._hasCalledGuideBot;
        }

        public function get hasChangedLooks(): Boolean
        {
            return this._hasChangedLooks;
        }

        public function get hasChangedName(): Boolean
        {
            return this._hasChangedName;
        }

        public function get hasCalledGuideBot(): Boolean
        {
            return this._hasCalledGuideBot;
        }

        public function dispose(): void
        {
            this.disposeView();
            
            if (this._help)
            {
                this._help.events.removeEventListener(HabboHelpTutorialEvent.HHTPNUFWE_DONE_GUIDEBOT, this.onTaskDoneEvent);
                this._help.events.removeEventListener(HabboHelpTutorialEvent.HHTE_DONE_AVATAR_EDITOR_OPENING, this.onTaskDoneEvent);
                this._help.events.removeEventListener(HabboHelpTutorialEvent.HHTE_DONE_AVATAR_EDITOR_CLOSING, this.onTaskDoneEvent);
                
                if (this._help.sessionDataManager != null)
                {
                    this._help.sessionDataManager.events.removeEventListener(HabboSessionFigureUpdatedEvent.HABBO_SESSION_FIGURE_UPDATE, this.onFigureUpdate);
                }

                this._help = null;
            }

        }

        public function update(hasChangedLooks: Boolean, hasChangedName: Boolean, hasCalledGuideBot: Boolean): void
        {
            this._hasChangedLooks = hasChangedLooks;
            this._hasChangedName = hasChangedName;
            this._hasCalledGuideBot = hasCalledGuideBot;

            if (this._tutorialUI == null || this._tutorialUI.id == TUTORIAL_UI_MAIN_VIEW)
            {
                this.prepareForTutorial();
                this.showView(TUTORIAL_UI_MAIN_VIEW);
            }

        }

        public function onTaskDoneEvent(event: HabboHelpTutorialEvent): void
        {
            switch (event.type)
            {
                case HabboHelpTutorialEvent.HHTPNUFWE_DONE_GUIDEBOT:
                    this._hasCalledGuideBot = true;
                    
                    if (this._tutorialUI != null && this._tutorialUI.id == TUTORIAL_UI_GUIDEBOT_VIEW)
                    {
                        this.showView(TUTORIAL_UI_MAIN_VIEW);
                    }

                    return;
                
                case HabboHelpTutorialEvent.HHTE_DONE_AVATAR_EDITOR_OPENING:
                
                    if (this._tutorialUI != null && this._tutorialUI.id == TUTORIAL_UI_CLOTHES_VIEW)
                    {
                        this._isEditingAvatar = true;
                        this.disposeWindow();
                    }

                    return;

                case HabboHelpTutorialEvent.HHTE_DONE_AVATAR_EDITOR_CLOSING:
                    
                    if (this._isEditingAvatar)
                    {
                        this._isEditingAvatar = false;
                        this.showView(TUTORIAL_UI_MAIN_VIEW);
                    }

                    return;
            }

        }

        public function showView(viewName: String): void
        {
            var contentList: IItemListWindow;
            
            if (this.hasTasksDone)
            {
                if (this._help)
                {
                    this._help.removeTutorialUI();
                }

                return;
            }

            var visible: Boolean;
            
            if (this._window == null)
            {
                this._window = (this.buildXmlWindow("tutorial_frame") as IFrameWindow);
                
                if (this._window == null)
                {
                    return;
                }

                this._window.procedure = this.windowProcedure;
                contentList = (this._window.findChildByName("content_list") as IItemListWindow);
                
                if (contentList == null)
                {
                    return;
                }

                this._width = this._window.width - contentList.width;
                this._height = this._window.height;
                
                visible = true;
            }

            contentList = (this._window.findChildByName("content_list") as IItemListWindow);
            
            if (contentList == null)
            {
                return;
            }

            contentList.destroyListItems();
            contentList.height = 0;
            
            if (this._tutorialUI != null)
            {
                this._tutorialUI.dispose();
            }

            this._window.visible = true;
            
            switch (viewName)
            {
                case TUTORIAL_UI_MAIN_VIEW:
                    if (this._nameChangeUI != null)
                    {
                        this._nameChangeUI.dispose();
                    }

                    if (this._visible)
                    {
                        this._tutorialUI = new TutorialMainView(contentList, this);
                    }
                    else
                    {
                        this._window.visible = false;
                        return;
                    }

                    break;

                case TUTORIAL_UI_NAME_VIEW:
                    this._window.visible = false;

                    if (this._nameChangeUI == null)
                    {
                        this._nameChangeUI = new NameChangeView(this);
                    }

                    this._nameChangeUI.showMainView();
                    this.prepareForTutorial();

                    break;

                case TUTORIAL_UI_CLOTHES_VIEW:
                    this._tutorialUI = new TutorialClothesChangeView(contentList, this);
                    
                    break;
                
                case TUTORIAL_UI_GUIDEBOT_VIEW:
                    this._tutorialUI = new TutorialCallGuideBotView(contentList, this);
                
                    break;
            }

            this._window.height = contentList.height + this._height;
            this._window.width = contentList.width + this._width;
            
            if (visible)
            {
                if (this._window == null)
                {
                    return;
                }

                this._window.x = this._window.context.getDesktopWindow().width / 2 - this._window.width / 2;
                this._window.y = 0;
            }

        }

        public function buildXmlWindow(assetName: String, param2: uint = 1): IWindow
        {
            if (this._help == null || this._help.assets == null)
            {
                return null;
            }

            var layout: XmlAsset = XmlAsset(this._help.assets.getAssetByName(assetName + "_xml"));
            
            if (layout == null || this._help.windowManager == null)
            {
                return null;
            }

            return this._help.windowManager.buildFromXML(XML(layout.content), param2);
        }

        private function disposeWindow(event: WindowEvent = null): void
        {
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            }
        }

        private function disposeView(): void
        {
            if (this._tutorialUI != null)
            {
                this._tutorialUI.dispose();
                this._tutorialUI = null;
            }

            if (this._nameChangeUI != null)
            {
                this._nameChangeUI.dispose();
                this._nameChangeUI = null;
            }

            this.disposeWindow();
        }

        public function setRoomSessionStatus(status: Boolean): void
        {
            if (!status)
            {
                this.disposeView();
            }

        }

        public function prepareForTutorial(): void
        {
            if (this._help == null || this._help.events == null)
            {
                return;
            }

            this._help.hideUI();
            this._help.events.dispatchEvent(new HabboHelpTutorialEvent(HabboHelpTutorialEvent.var_1306));
        }

        public function windowProcedure(event: WindowEvent, window: IWindow): void
        {
            switch (event.type)
            {
                case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
                    if (window.name == "header_button_close")
                    {
                        this.disposeView();
                    }

                    return;
            }

        }

        public function changeName(name: String): void
        {
            this.disposeWindow();
            this._help.sendMessage(new ChangeUserNameMessageComposer(name));
        }

        public function checkName(name: String): void
        {
            this.disposeWindow();
            this._help.sendMessage(new CheckUserNameMessageComposer(name));
        }

        public function onUserNameChanged(name: String): void
        {
            if (!this._help || !this._help.localization || !this._help.windowManager)
            {
                return;
            }

            this._hasChangedName = true;
            this._help.localization.registerParameter("help.tutorial.name.changed", "name", name);
            
            this._help.windowManager.alert("${generic.notice}", "${help.tutorial.name.changed}", 0, function (dialog: IAlertDialog, event: WindowEvent): void
            {
                dialog.dispose();
            });
            
            if (this._tutorialUI != null && (this._tutorialUI.id == TUTORIAL_UI_NAME_VIEW || this._tutorialUI.id == TUTORIAL_UI_MAIN_VIEW))
            {
                this.showView(TUTORIAL_UI_MAIN_VIEW);
            }

        }

        private function onFigureUpdate(session: HabboSessionFigureUpdatedEvent): void
        {
            var isSameSession: Boolean;
            
            if (this._help == null || session == null)
            {
                return;
            }

            if (!this._hasChangedLooks)
            {
                if (this._help.sessionDataManager != null)
                {
                    isSameSession = session.userId == this._help.sessionDataManager.userId;
                    
                    if (isSameSession)
                    {
                        this._help.sessionDataManager.events.removeEventListener(HabboSessionFigureUpdatedEvent.HABBO_SESSION_FIGURE_UPDATE, this.onFigureUpdate);
                        this.onUserChanged();
                    }

                }

            }

        }

        public function onUserChanged(): void
        {
            this._hasChangedLooks = true;

            if (this._tutorialUI != null && (this._tutorialUI.id == TUTORIAL_UI_CLOTHES_VIEW || this._tutorialUI.id == TUTORIAL_UI_MAIN_VIEW))
            {
                this.showView(TUTORIAL_UI_MAIN_VIEW);
            }

        }

        public function onChangeUserNameResult(event: ChangeUserNameResultMessageEvent): void
        {
            if (event == null)
            {
                return;
            }

            var parser: ChangeUserNameResultMessageParser = event.getParser();
            
            if (parser.resultCode == ChangeUserNameResultMessageEvent.NAME_CHANGE_SUCCESS)
            {
                this._hasChangedName = true;
                this.showView(TutorialUI.TUTORIAL_UI_MAIN_VIEW);
            }
            else
            {
                this._nameChangeUI.setNameNotAvailableView(parser.resultCode, parser.name, parser.nameSuggestions);
            }

        }

        public function onCheckUserNameResult(event: CheckUserNameResultMessageEvent): void
        {
            if (!event)
            {
                return;
            }

            var parser: CheckUserNameResultMessageParser = event.getParser();
            
            if (parser.resultCode == ChangeUserNameResultMessageEvent.NAME_CHANGE_SUCCESS)
            {
                this._nameChangeUI.checkedName = parser.name;
            }
            else
            {
                this._nameChangeUI.setNameNotAvailableView(parser.resultCode, parser.name, parser.nameSuggestions);
            }

        }

    }
}
