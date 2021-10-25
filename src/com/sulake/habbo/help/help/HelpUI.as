package com.sulake.habbo.help.help
{

    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.help.HabboHelp;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.help.enum.HabboHelpViewEnum;
    import com.sulake.habbo.help.cfh.CallForHelpTopicSelection;
    import com.sulake.habbo.help.cfh.CallForHelpTextInput;
    import com.sulake.habbo.help.cfh.CallForHelpSentView;
    import com.sulake.habbo.help.cfh.CallForHelpPendingItemView;
    import com.sulake.habbo.help.cfh.CallForHelpReportUserSelection;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindow;

    import flash.events.Event;

    import com.sulake.habbo.help.enum.HabboHelpTrackingEvent;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.help.enum.CallForHelpResultEnum;
    import com.sulake.habbo.communication.messages.outgoing.room.action.CallGuideBotMessageComposer;
    import com.sulake.habbo.help.enum.HabboHelpTutorialEvent;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.help.help.data.FaqIndex;

    import flash.utils.Dictionary;

    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.assets.BitmapDataAsset;

    import flash.display.BitmapData;

    import com.sulake.core.window.components.IBitmapWrapperWindow;

    import flash.geom.Point;

    public class HelpUI
    {

        private var _assetLibrary: IAssetLibrary;
        private var _windowManager: IHabboWindowManager;
        private var _toolbar: IHabboToolbar;
        private var _window: IWindowContainer;
        private var _component: HabboHelp;
        private var _defaultViewId: String = "HHVE_HELP_FRONTPAGE";
        private var _viewControllerId: String = _defaultViewId;
        private var _previousControllers: Array = [];
        private var _controllers: Map;
        private var _width: int = 0;
        private var _height: int = 0;
        private var _goBackUI: IWindowContainer;
        private var _backButtons: Array = [];
        private var _callForGuideBotEnabled: Boolean = false;

        public function HelpUI(component: HabboHelp, assetLibrary: IAssetLibrary, windowManager: IHabboWindowManager, localizationManager: IHabboLocalizationManager, toolbar: IHabboToolbar)
        {
            this._component = component;
            this._assetLibrary = assetLibrary;
            this._windowManager = windowManager;
            this._windowManager.registerLocalizationParameter("info.client.version", "version", String(201104122301));
            this._toolbar = toolbar;
            this._controllers = new Map();

            this._controllers.add(HabboHelpViewEnum.HVVE_PH, IHelpViewController(new PlaceholderView(this, this._windowManager, this._assetLibrary)));
            this._controllers.add(HabboHelpViewEnum.HHVE_HELP_FRONTPAGE, IHelpViewController(new HelpMainView(this, this._windowManager, this._assetLibrary)));
            this._controllers.add(HabboHelpViewEnum.HHVE_FAQ_TOP, IHelpViewController(new FaqBrowseTopView(this, this._windowManager, this._assetLibrary)));
            this._controllers.add(HabboHelpViewEnum.HHVE_FAQ_CATEGORY, IHelpViewController(new FaqBrowseCategoryView(this, this._windowManager, this._assetLibrary)));
            this._controllers.add(HabboHelpViewEnum.HHVE_FAQ_TOPICS, IHelpViewController(new FaqBrowseEntry(this, this._windowManager, this._assetLibrary)));
            this._controllers.add(HabboHelpViewEnum.HHVE_CFG_TOPIC_SELECT, IHelpViewController(new CallForHelpTopicSelection(this, this._windowManager, this._assetLibrary)));
            this._controllers.add(HabboHelpViewEnum.HHVE_CFH_TEXT_INPUT, IHelpViewController(new CallForHelpTextInput(this, this._windowManager, this._assetLibrary)));
            this._controllers.add(HabboHelpViewEnum.HHVE_CFH_SENT_OK, IHelpViewController(new CallForHelpSentView(this, this._windowManager, this._assetLibrary, "help_cfh_thanks")));
            this._controllers.add(HabboHelpViewEnum.HHVE_CFH_HAS_ABUSIVE, IHelpViewController(new CallForHelpSentView(this, this._windowManager, this._assetLibrary, "help_cfh_abusive")));
            this._controllers.add(HabboHelpViewEnum.HHVE_CFH_PENDING, IHelpViewController(new CallForHelpPendingItemView(this, this._windowManager, this._assetLibrary)));
            this._controllers.add(HabboHelpViewEnum.HHVE_REPORT_USER_SELECT, IHelpViewController(new CallForHelpReportUserSelection(this, this._windowManager, this._assetLibrary)));
        }

        public function dispose(): void
        {
            var _loc3_: String;
            var _loc4_: IHelpViewController;
            if (this._window != null)
            {
                this._window.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClick);
            }

            var _loc1_: Array = this._controllers.getKeys();
            var _loc2_: int;
            while (_loc2_ < _loc1_.length)
            {
                _loc3_ = _loc1_[_loc2_];
                _loc4_ = (this._controllers.getValue(_loc3_) as IHelpViewController);
                if (_loc4_ != null)
                {
                    _loc4_.dispose();
                }

                _loc2_++;
            }

            this._controllers.dispose();
            if (this._goBackUI != null)
            {
                this._goBackUI.dispose();
                this._goBackUI = null;
            }

        }

        public function toggleUI(): void
        {
            if (this._window != null && this._window.visible)
            {
                this.hideUI();
            }
            else
            {
                this.showUI();
            }

        }

        public function showUI(controllerId: String = null, param2: Boolean = true): void
        {
            if (controllerId == null)
            {
                controllerId = this._viewControllerId;
            }

            if (this._window == null)
            {
                this.createWindow();
                if (this._window == null)
                {
                    return;
                }

                this._window.visible = true;
            }
            else
            {
                this.removeCurrentView();
            }

            if (controllerId == this._defaultViewId)
            {
                this._previousControllers = [];
            }
            else
            {
                if (param2)
                {
                    if (this._previousControllers.length == 0 || controllerId != this._viewControllerId)
                    {
                        this._previousControllers.push(this._viewControllerId);
                    }

                }

            }

            this._viewControllerId = controllerId;
            var controller: IHelpViewController = this.getViewController();
            
            if (controller == null)
            {
                Logger.log("* No view controller found for " + this._viewControllerId);
                return;
            }

            var container: IWindowContainer = this._window.findChildByName("content_area") as IWindowContainer;
           
            if (container == null)
            {
                return;
            }

            var contentList: IItemListWindow = this._window.findChildByName("content_list") as IItemListWindow;
            
            if (contentList == null)
            {
                return;
            }

            contentList.height = 0;
            controller.render();
            
            var parent: IWindow = controller.getWindowContainer() as IWindow;
            
            if (parent != null)
            {
                contentList.addListItemAt(parent, 0);
            }

            this.addBackButtonWindow();
            this.updateWindowDimensions();
            this._component.events.dispatchEvent(new Event(HabboHelpTrackingEvent.HABBO_HELP_TRACKING_EVENT_DEFAULT));
        }

        public function tellUI(param1: String, param2: * = null): void
        {
            if (this._viewControllerId != param1)
            {
                return;
            }

            var controller: IHelpViewController = this.getViewController();
            if (controller != null)
            {
                controller.update(param2);
            }

        }

        public function get component(): HabboHelp
        {
            return this._component;
        }

        public function get localization(): IHabboLocalizationManager
        {
            return this._component.localization;
        }

        public function get visible(): Boolean
        {
            if (this._window == null)
            {
                return false;
            }

            return this._window.visible;
        }

        public function get window(): IWindowContainer
        {
            return this._window;
        }

        public function showCallForHelpReply(message: String): void
        {
            this._windowManager.alert("${help.cfh.reply.title}", message, 0, function (dialog: IAlertDialog, event: WindowEvent): void
            {
                dialog.dispose();
            });
        }

        public function showCallForHelpResult(result: String): void
        {
            switch (result)
            {
                case CallForHelpResultEnum.CFHRE_SENT_OK:
                    this.showUI(HabboHelpViewEnum.HHVE_CFH_SENT_OK);
                    return;

                case CallForHelpResultEnum.CFHRE_ERROR_TOO_MANY_PENDING:
                    this.showUI(HabboHelpViewEnum.HHVE_CFH_PENDING);
                    return;

                case CallForHelpResultEnum.CFHRE_HAS_ABUSIVE_CALL:
                    this.showUI(HabboHelpViewEnum.HHVE_CFH_HAS_ABUSIVE);
                    return;
            }

        }

        public function updateCallForGuideBotUI(value: Boolean): void
        {
            this._callForGuideBotEnabled = value;

            var controller: IHelpViewController = this._controllers.getValue(HabboHelpViewEnum.HHVE_HELP_FRONTPAGE) as IHelpViewController;
            
            if (controller != null && !controller.disposed)
            {
                controller.update();
            }

        }

        public function isCallForGuideBotEnabled(): Boolean
        {
            return this._callForGuideBotEnabled;
        }

        public function handleCallGuideBot(): void
        {
            this.sendMessage(new CallGuideBotMessageComposer());
            
            this.hideUI();
            
            this._component.events.dispatchEvent(new HabboHelpTutorialEvent(HabboHelpTutorialEvent.HHTPNUFWE_DONE_GUIDEBOT));
        }

        public function sendMessage(message: IMessageComposer): void
        {
            this._component.sendMessage(message);
        }

        public function getFaq(): FaqIndex
        {
            return this._component.getFaq();
        }

        public function getText(key: String, value: String = null): String
        {
            if (value == null)
            {
                value = key;
            }

            return this.localization.getKey(key, value);
        }

        public function getConfigurationKey(param1: String, param2: String = null, param3: Dictionary = null): String
        {
            return this._component.getConfigurationKey(param1, param2, param3);
        }

        public function setRoomSessionStatus(active: Boolean): void
        {
            var controller: IHelpViewController;
            var i: int;

            while (i < this._controllers.length)
            {
                controller = (this._controllers.getWithIndex(i) as IHelpViewController);
                
                if (controller != null)
                {
                    controller.roomSessionActive = active;
                    
                    if (!controller.disposed)
                    {
                        controller.update();
                    }

                }

                i++;
            }

        }

        private function getViewController(): IHelpViewController
        {
            return this._controllers.getValue(this._viewControllerId);
        }

        private function createWindow(): void
        {
            var layout: XmlAsset = XmlAsset(this._assetLibrary.getAssetByName("help_frame_xml"));
            
            if (layout == null)
            {
                return;
            }

            this._window = (this._windowManager.buildFromXML(XML(layout.content)) as IWindowContainer);
            
            if (this._window == null)
            {
                return;
            }

            this._window.center();
            this._window.setParamFlag(WindowParam.var_593);
            this._window.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClick);
            
            var closeButton: IWindow = this._window.findChildByTag("close");
            
            if (closeButton != null)
            {
                closeButton.setParamFlag(WindowParam.var_593);
                closeButton.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClose);
            }

            var contentList: IItemListWindow = this._window.findChildByName("content_list") as IItemListWindow;
            
            if (contentList == null)
            {
                return;
            }

            this._width = this._window.width - contentList.width;
            this._height = this._window.height;
        }

        private function removeCurrentView(): void
        {
            var view: IItemListWindow;

            if (this._window != null)
            {
                view = (this._window.findChildByName("content_list") as IItemListWindow);
                
                if (view != null)
                {
                    while (view.numListItems > 1)
                    {
                        view.getListItemAt(0).dispose();
                        view.removeListItemAt(0);
                    }

                }

            }

            var controller: IHelpViewController = this.getViewController();
            
            if (controller != null)
            {
                controller.dispose();
            }

        }

        public function updateWindowDimensions(): void
        {
            if (this._window == null)
            {
                return;
            }

            var itemList: IItemListWindow = this._window.findChildByName("content_list") as IItemListWindow;
            
            if (itemList == null)
            {
                return;
            }

            this._window.height = itemList.height + this._height;
            this._window.width = itemList.width + this._width;
        }

        public function hideUI(): void
        {
            if (this._window != null)
            {
                this.removeCurrentView();
                this._window.dispose();
                this._window = null;
            }

            this._viewControllerId = this._defaultViewId;
            this._component.events.dispatchEvent(new Event(HabboHelpTrackingEvent.HABBO_HELP_TRACKING_EVENT_CLOSED));
        }

        private function onClose(param1: WindowMouseEvent): void
        {
            this.hideUI();
        }

        private function onBack(param1: WindowMouseEvent): void
        {
            if (this._previousControllers.length > 0)
            {
                this.showUI(this._previousControllers.pop(), false);
            }

        }

        private function onMouseOut(param1: WindowMouseEvent): void
        {
            this.setBackButtonActiveState(false);
        }

        private function onMouseOver(param1: WindowMouseEvent): void
        {
            this.setBackButtonActiveState(true);
        }

        private function onClick(param1: WindowMouseEvent): void
        {
            var target: IWindow = param1.target as IWindow;

            if (target.tags.indexOf("close") > -1)
            {
                this.hideUI();
                return;
            }

            if (target.tags.indexOf("back") > -1)
            {
                if (this._previousControllers.length > 0)
                {
                    this.showUI(this._previousControllers.pop(), false);
                }

            }

        }

        private function setBackButtonActiveState(param1: Boolean = false): void
        {
            var bitmap: BitmapDataAsset;

            if (this._viewControllerId == HabboHelpViewEnum.HHVE_HELP_FRONTPAGE)
            {
                return;
            }

            if (this._backButtons.length < 2)
            {
                bitmap = (this._assetLibrary.getAssetByName("back_png") as BitmapDataAsset);
                this._backButtons.push(bitmap.content as BitmapData);
                
                bitmap = (this._assetLibrary.getAssetByName("back_hi_png") as BitmapDataAsset);
                this._backButtons.push(bitmap.content as BitmapData);
            }

            var wrapper: IBitmapWrapperWindow = this._goBackUI.findChildByName("back_image") as IBitmapWrapperWindow;
            
            if (wrapper == null)
            {
                return;
            }

            wrapper.bitmap = new BitmapData(wrapper.width, wrapper.height, true);
            
            if (param1)
            {
                wrapper.bitmap.copyPixels(this._backButtons[1], this._backButtons[1].rect, new Point(0, 0));
            }
            else
            {
                wrapper.bitmap.copyPixels(this._backButtons[0], this._backButtons[0].rect, new Point(0, 0));
            }

        }

        private function addBackButtonWindow(): void
        {
            var layout: XmlAsset;
            var goBackImage: IWindow;
            var goBackText: IWindow;

            if (this._viewControllerId == HabboHelpViewEnum.HHVE_HELP_FRONTPAGE || this._previousControllers.length == 0)
            {
                return;
            }

            if (this._goBackUI == null)
            {
                layout = XmlAsset(this._assetLibrary.getAssetByName("help_back_button_xml"));
                
                if (layout == null)
                {
                    return;
                }

                this._goBackUI = (this._windowManager.buildFromXML(XML(layout.content)) as IWindowContainer);
                goBackImage = this._goBackUI.findChildByName("back_image");
                
                if (goBackImage != null)
                {
                    goBackImage.setParamFlag(WindowParam.var_593);
                    goBackImage.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onBack);
                    goBackImage.addEventListener(WindowMouseEvent.var_626, this.onMouseOut);
                    goBackImage.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onMouseOver);
                }

                goBackText = this._goBackUI.findChildByName("back_text");
                
                if (goBackText != null)
                {
                    goBackText.setParamFlag(WindowParam.var_593);
                    goBackText.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onBack);
                }

            }

            var contentList: IItemListWindow = this._window.findChildByName("content_list") as IItemListWindow;
            
            if (contentList == null || this._goBackUI == null)
            {
                return;
            }

            if (contentList.getListItemIndex(this._goBackUI as IWindow) > -1)
            {
                return;
            }

            contentList.addListItem(this._goBackUI as IWindow);
            this.setBackButtonActiveState(false);
        }

    }
}
