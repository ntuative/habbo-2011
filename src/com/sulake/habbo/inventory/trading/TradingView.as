package com.sulake.habbo.inventory.trading
{

    import com.sulake.habbo.inventory.IInventoryView;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.inventory.ItemPopupCtrl;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.core.window.IWindowContainer;

    import flash.utils.Timer;

    import com.sulake.habbo.inventory.items.GroupItem;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.sound.events.SongInfoReceivedEvent;

    import flash.events.TimerEvent;

    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.ITextWindow;

    import flash.display.BitmapData;

    import com.sulake.core.utils.Map;

    import flash.geom.Point;

    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.inventory.items.FloorItem;
    import com.sulake.habbo.inventory.items.WallItem;
    import com.sulake.habbo.inventory.items.IItem;
    import com.sulake.habbo.inventory.enum.FurniCategory;
    import com.sulake.habbo.sound.ISongInfo;

    public class TradingView implements IInventoryView, IGetImageListener
    {

        private static const TRADING_BORDER_ACCEPTS: uint = 4284532064;
        private static const TRADING_BORDER_PENDING: uint = 2577770;
        
        public static const TRADING_NOTIFICATION_OTHER_NOT_OFFERING: int = 0;
        public static const TRADING_NOTIFICATION_CLOSED: int = 1;
        public static const TRADING_NOTIFICATION_ALREADY_OPEN: int = 2;

        private var _model: TradingModel;
        private var _windowManager: IHabboWindowManager;
        private var _localization: IHabboLocalizationManager;
        private var _roomEngine: IRoomEngine;
        private var _assetLibrary: IAssetLibrary;
        private var _popup: ItemPopupCtrl;
        private var _soundManager: IHabboSoundManager;
        private var _disposed: Boolean = false;
        private var _visible: Boolean;
        private var _tradingContainer: IWindowContainer;
        private var _minimizedTradingContainer: IWindowContainer;
        private var _timer: Timer;
        private var _selectedItem: GroupItem;
        private var _minimized: Boolean;
        private var _unknown1: Array = [];

        public function TradingView(param1: TradingModel, param2: IHabboWindowManager, param3: IAssetLibrary, param4: IRoomEngine, param5: IHabboLocalizationManager, param6: IHabboSoundManager)
        {
            this._model = param1;
            this._windowManager = param2;
            this._localization = param5;
            this._assetLibrary = param3;
            this._roomEngine = param4;
            this._soundManager = param6;
            this._visible = false;
            var _loc7_: IAsset = this._assetLibrary.getAssetByName("item_popup_xml");
            var _loc8_: XmlAsset = XmlAsset(_loc7_);
            var _loc9_: IWindowContainer = this._windowManager.buildFromXML(_loc8_.content as XML) as IWindowContainer;
            _loc9_.visible = false;
            this._popup = new ItemPopupCtrl(_loc9_, this._assetLibrary);
            this._soundManager.events.addEventListener(SongInfoReceivedEvent.var_937, this.onSongInfoReceivedEvent);
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get visible(): Boolean
        {
            return this._visible;
        }

        public function dispose(): void
        {
            if (!this._disposed)
            {
                if (this._tradingContainer && !this._tradingContainer.disposed)
                {
                    this._tradingContainer.dispose();
                    this._tradingContainer = null;
                }

                if (this._timer)
                {
                    this._timer.removeEventListener(TimerEvent.TIMER, this.timerEventHandler);
                    this._timer.stop();
                    this._timer = null;
                }

                if (this._popup != null)
                {
                    this._popup.dispose();
                    this._popup = null;
                }

                if (this._soundManager)
                {
                    if (this._soundManager.events != null)
                    {
                        this._soundManager.events.removeEventListener(SongInfoReceivedEvent.var_937, this.onSongInfoReceivedEvent);
                    }

                    this._soundManager = null;
                }

                this._unknown1 = null;
                this._model = null;
                this._windowManager = null;
                this._roomEngine = null;
                this._localization = null;
                this._assetLibrary = null;
                this._selectedItem = null;
                this._visible = false;
                this._disposed = true;
            }

        }

        public function setup(param1: int, param2: Boolean, param3: int, param4: Boolean): void
        {
            this.setMinimized(false);
            this.hideOwnUserNotification();
            this.hideOtherUserNotification();
            if (!param2 && !param4)
            {
                this.showInfoMessage("${inventory.trading.warning.both_accounts_disabled}");
                this.showOwnUserNotification("");
                this.showOtherUserNotification("");
            }
            else
            {
                if (!param2)
                {
                    this.showOwnUserNotification("${inventory.trading.warning.own_account_disabled}");
                }

                if (!param4)
                {
                    this.showOtherUserNotification("${inventory.trading.warning.others_account_disabled}");
                }

            }

        }

        public function getWindowContainer(): IWindowContainer
        {
            if (this._tradingContainer == null)
            {
                this._tradingContainer = this.createNormalWindow();
            }

            if (this._minimizedTradingContainer == null)
            {
                this._minimizedTradingContainer = this.createMinimizedWindow();
            }

            if (!this._minimized)
            {
                return this._tradingContainer;
            }

            return this._minimizedTradingContainer;
        }

        private function createNormalWindow(): IWindowContainer
        {
            var _loc3_: IItemGridWindow;
            var _loc4_: IWindow;
            var _loc5_: IWindowContainer;
            var _loc6_: uint;
            var _loc1_: XML = XmlAsset(this._assetLibrary.getAssetByName("inventory_trading_xml")).content as XML;
            var _loc2_: IWindowContainer = this._windowManager.buildFromXML(_loc1_) as IWindowContainer;
            _loc3_ = (_loc2_.findChildByTag("OWN_USER_GRID") as IItemGridWindow);
            _loc6_ = 0;
            while (_loc6_ < _loc3_.numGridItems)
            {
                _loc4_ = _loc3_.getGridItemAt(_loc6_);
                _loc4_.id = _loc6_;
                _loc4_.procedure = this.ownThumbEventProc;
                _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.ownThumbEventProc);
                _loc4_.addEventListener(WindowMouseEvent.var_626, this.ownThumbEventProc);
                _loc6_++;
            }

            _loc3_ = (_loc2_.findChildByTag("OTHER_USER_GRID") as IItemGridWindow);
            _loc6_ = 0;
            while (_loc6_ < _loc3_.numGridItems)
            {
                _loc4_ = _loc3_.getGridItemAt(_loc6_);
                _loc4_.id = _loc6_;
                _loc4_.procedure = this.othersThumbEventProc;
                _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.othersThumbEventProc);
                _loc4_.addEventListener(WindowMouseEvent.var_626, this.othersThumbEventProc);
                _loc6_++;
            }

            _loc2_.procedure = this.windowEventProc;
            return _loc2_;
        }

        private function createMinimizedWindow(): IWindowContainer
        {
            var _loc1_: XML = XmlAsset(this._assetLibrary.getAssetByName("inventory_trading_minimized_xml")).content as XML;
            var _loc2_: IWindowContainer = this._windowManager.buildFromXML(_loc1_) as IWindowContainer;
            _loc2_.procedure = this.windowMininizedEventProc;
            return _loc2_;
        }

        public function setMinimized(param1: Boolean = false): void
        {
            this._minimized = param1;
        }

        protected function getOwnUsersItemGrid(): IItemGridWindow
        {
            return this._tradingContainer.findChildByTag("OWN_USER_GRID") as IItemGridWindow;
        }

        protected function getOtherUsersItemGrid(): IItemGridWindow
        {
            return this._tradingContainer.findChildByTag("OTHER_USER_GRID") as IItemGridWindow;
        }

        public function updateItemList(param1: int): void
        {
            var _loc3_: GroupItem;
            var _loc4_: IWindowContainer;
            var _loc5_: IBitmapWrapperWindow;
            var _loc6_: ITextWindow;
            var _loc7_: BitmapData;
            var _loc8_: BitmapData;
            var _loc2_: uint;
            var _loc9_: * = param1 == this._model.otherUserId;
            var _loc10_: Map = _loc9_ ? this._model.otherUserItems : this._model.ownUserItems;
            var _loc11_: IItemGridWindow = _loc9_ ? this.getOtherUsersItemGrid() : this.getOwnUsersItemGrid();
            while (_loc2_ < _loc10_.length)
            {
                _loc3_ = (_loc10_.getWithIndex(_loc2_) as GroupItem);
                _loc4_ = (_loc11_.getGridItemAt(_loc2_) as IWindowContainer);
                if (_loc4_)
                {
                    _loc4_.id = _loc2_;
                    while (_loc4_.numChildren > 0)
                    {
                        _loc4_.removeChildAt(0);
                    }

                    _loc4_.addChild(_loc3_.window);
                    _loc3_.window.id = _loc2_;
                }

                _loc2_++;
            }

            while (_loc2_ < _loc11_.numGridItems)
            {
                _loc4_ = (_loc11_.getGridItemAt(_loc2_) as IWindowContainer);
                if (_loc4_)
                {
                    _loc4_.id = _loc2_;
                    _loc4_.removeChildAt(0);
                    _loc4_.invalidate();
                }

                _loc2_++;
            }

            this.updateActionState();
        }

        public function clearItemLists(): void
        {
            var _loc1_: IItemGridWindow;
            var _loc2_: IWindowContainer;
            var _loc3_: uint;
            _loc1_ = this.getOwnUsersItemGrid();
            _loc3_ = 0;
            while (_loc3_ < _loc1_.numGridItems)
            {
                _loc2_ = (_loc1_.getGridItemAt(_loc3_) as IWindowContainer);
                if (_loc2_)
                {
                    _loc2_.id = _loc3_;
                    _loc2_.removeChildAt(0);
                }

                _loc3_++;
            }

            _loc1_ = this.getOtherUsersItemGrid();
            _loc3_ = 0;
            while (_loc3_ < _loc1_.numGridItems)
            {
                _loc2_ = (_loc1_.getGridItemAt(_loc3_) as IWindowContainer);
                if (_loc2_)
                {
                    _loc2_.id = _loc3_;
                    _loc2_.removeChildAt(0);
                }

                _loc3_++;
            }

        }

        public function updateUserInterface(): void
        {
            var _loc1_: IWindow;
            var _loc2_: ITextWindow;
            var _loc3_: IBitmapWrapperWindow;
            if (this._tradingContainer)
            {
                this.updateActionState();
                _loc2_ = (this._tradingContainer.findChildByTag("OTHER_USER_NAME") as ITextWindow);
                if (_loc2_)
                {
                    _loc2_.text = this._model.otherUserName;
                }

                _loc1_ = this._tradingContainer.findChildByTag("OWN_USER_BORDER");
                if (_loc1_)
                {
                    _loc1_.color = this._model.ownUserAccepts ? TRADING_BORDER_ACCEPTS : TRADING_BORDER_PENDING;
                }

                _loc3_ = (this._tradingContainer.findChildByTag("OWN_USER_LOCK") as IBitmapWrapperWindow);
                if (_loc3_)
                {
                    if (_loc3_.bitmap == null)
                    {
                        _loc3_.bitmap = new BitmapData(_loc3_.width, _loc3_.height, true);
                    }

                    _loc3_.bitmap.fillRect(_loc3_.bitmap.rect, 0xFFFFFF);
                    _loc3_.bitmap.copyPixels(this._assetLibrary.getAssetByName(this._model.ownUserAccepts
                                                                                       ? "trading_locked_icon_png"
                                                                                       : "trading_unlocked_icon_png").content as BitmapData, _loc3_.bitmap.rect, new Point());
                    _loc3_.invalidate();
                }

                _loc1_ = this._tradingContainer.findChildByTag("OTHER_USER_BORDER");
                if (_loc1_)
                {
                    _loc1_.color = this._model.otherUserAccepts ? TRADING_BORDER_ACCEPTS : TRADING_BORDER_PENDING;
                }

                _loc3_ = (this._tradingContainer.findChildByTag("OTHER_USER_LOCK") as IBitmapWrapperWindow);
                if (_loc3_)
                {
                    if (_loc3_.bitmap == null)
                    {
                        _loc3_.bitmap = new BitmapData(_loc3_.width, _loc3_.height, true);
                    }

                    _loc3_.bitmap.fillRect(_loc3_.bitmap.rect, 0xFFFFFF);
                    _loc3_.bitmap.copyPixels(this._assetLibrary.getAssetByName(this._model.otherUserAccepts
                                                                                       ? "trading_locked_icon_png"
                                                                                       : "trading_unlocked_icon_png").content as BitmapData, _loc3_.bitmap.rect, new Point());
                    _loc3_.invalidate();
                }

            }

        }

        public function updateActionState(): void
        {
            var _loc1_: IWindow;
            if (this._tradingContainer)
            {
                _loc1_ = this._tradingContainer.findChildByName("button_accept");
                if (!_loc1_)
                {
                    return;
                }

                switch (this._model.state)
                {
                    case TradingModel.TRADING_STATE_INIT:
                        if (this._model.otherUserItems.length > 0 || this._model.ownUserItems.length > 0)
                        {
                            _loc1_.enable();
                        }
                        else
                        {
                            _loc1_.disable();
                        }

                        _loc1_.caption = "${inventory.trading.accept}";
                        return;
                    case TradingModel.TRADING_STATE_MODIFY:
                        if (this._model.otherUserItems.length > 0 || this._model.ownUserItems.length > 0)
                        {
                            _loc1_.enable();
                        }
                        else
                        {
                            _loc1_.disable();
                        }

                        _loc1_.caption = this._model.ownUserAccepts
                                ? "${inventory.trading.modify}"
                                : "${inventory.trading.accept}";
                        this.showInfoMessage("${inventory.trading.info.add}");
                        return;
                    case TradingModel.TRADING_STATE_COUNTDOWN:
                        _loc1_.disable();
                        _loc1_.caption = "${inventory.trading.countdown}";
                        this.showInfoMessage("${inventory.trading.info.confirm}");
                        return;
                    case TradingModel.TRADING_STATE_CONFIRM:
                        _loc1_.enable();
                        _loc1_.caption = "${inventory.trading.confirm}";
                        this.showInfoMessage("${inventory.trading.info.confirm}");
                        return;
                    case TradingModel.TRADING_STATE_WAITING:
                        _loc1_.disable();
                        this.showInfoMessage("${inventory.trading.info.waiting}");
                        return;
                    case TradingModel.TRADING_STATE_ACCEPTED:
                        _loc1_.disable();
                        _loc1_.caption = "${inventory.trading.accept}";
                        this.showInfoMessage("${inventory.trading.info.confirm}");
                        return;
                    case TradingModel.TRADING_STATE_CANCELLED:
                        return;
                    default:
                        throw new Error("Unknown trading progress state: \"" + this._model.state + "\"");
                }

            }

        }

        public function showInfoMessage(param1: String): void
        {
            var _loc2_: ITextWindow = this._tradingContainer.findChildByName("help_text") as ITextWindow;
            _loc2_.text = param1;
            _loc2_.visible = true;
        }

        public function showOwnUserNotification(param1: String): void
        {
            var _loc2_: ITextWindow = this._tradingContainer.findChildByName("info_text_0") as ITextWindow;
            _loc2_.text = param1;
            _loc2_.visible = true;
            var _loc3_: IItemGridWindow = this._tradingContainer.findChildByName("item_grid_0") as IItemGridWindow;
            if (_loc3_)
            {
                _loc3_.visible = false;
            }

        }

        public function hideOwnUserNotification(): void
        {
            var _loc1_: ITextWindow = this._tradingContainer.findChildByName("info_text_0") as ITextWindow;
            _loc1_.visible = false;
            var _loc2_: IItemGridWindow = this._tradingContainer.findChildByName("item_grid_0") as IItemGridWindow;
            if (_loc2_)
            {
                _loc2_.visible = true;
            }

        }

        public function showOtherUserNotification(param1: String): void
        {
            var _loc2_: ITextWindow = this._tradingContainer.findChildByName("info_text_1") as ITextWindow;
            _loc2_.text = param1;
            _loc2_.visible = true;
            var _loc3_: IItemGridWindow = this._tradingContainer.findChildByName("item_grid_1") as IItemGridWindow;
            if (_loc3_)
            {
                _loc3_.visible = false;
            }

        }

        public function hideOtherUserNotification(): void
        {
            var _loc1_: ITextWindow = this._tradingContainer.findChildByName("info_text_1") as ITextWindow;
            _loc1_.visible = false;
            var _loc2_: IItemGridWindow = this._tradingContainer.findChildByName("item_grid_1") as IItemGridWindow;
            if (_loc2_)
            {
                _loc2_.visible = true;
            }

        }

        public function alertPopup(param1: int): void
        {
            switch (param1)
            {
                case TRADING_NOTIFICATION_OTHER_NOT_OFFERING:
                    this._windowManager.alert("${inventory.trading.notification.title}", "${inventory.trading.warning.other_not_offering}", 0, this.onTradingAlert);
                    return;
                case TRADING_NOTIFICATION_CLOSED:
                    this._windowManager.alert("${inventory.trading.notification.title}", "${inventory.trading.info.closed}", 0, this.onTradingAlert);
                    return;
                case TRADING_NOTIFICATION_ALREADY_OPEN:
                    this._windowManager.alert("${inventory.trading.notification.title}", "${inventory.trading.info.already_open}", 0, this.onTradingAlert);
                    return;
            }

        }

        public function showAlertNotification(title: String, description: String, callback: Function): void
        {
            this._windowManager.alert(title, description, 0, callback != null
                    ? callback
                    : function (param1: IAlertDialog, param2: WindowEvent): void
                    {
                        param1.dispose();
                    });
        }

        public function startConfirmCountdown(): void
        {
            if (this._timer == null)
            {
                this._timer = new Timer(1000, 3);
                this._timer.addEventListener(TimerEvent.TIMER, this.timerEventHandler);
            }

            this._timer.reset();
            this._timer.repeatCount = 3;
            this._timer.start();
            this._windowManager.registerLocalizationParameter("inventory.trading.countdown", "counter", "3");
            this.updateUserInterface();
        }

        public function cancelConfirmCountdown(): void
        {
            if (this._timer != null)
            {
                this._timer.reset();
            }

        }

        private function timerEventHandler(param1: TimerEvent): void
        {
            this._windowManager.registerLocalizationParameter("inventory.trading.countdown", "counter", String(3 - this._timer.currentCount));
            if (this._timer.currentCount == 3)
            {
                this._model.confirmCountdownReady();
                this._timer.reset();
            }

        }

        protected function resolveItemThumbnail(param1: GroupItem): BitmapData
        {
            var _loc3_: ImageResult;
            var _loc2_: BitmapData = param1.iconImage;
            if (_loc2_ == null)
            {
                if (param1.peek() is FloorItem)
                {
                    _loc3_ = this._roomEngine.getFurnitureIcon(param1.type, this);
                }
                else
                {
                    if (param1.peek() is WallItem)
                    {
                        _loc3_ = this._roomEngine.getWallItemIcon(param1.type, this, param1.stuffData);
                    }

                }

                if (_loc3_.id > 0)
                {
                    param1.iconCallbackId = _loc3_.id;
                }

                _loc2_ = _loc3_.data;
                param1.iconImage = _loc2_;
            }

            return _loc2_;
        }

        public function imageReady(param1: int, param2: BitmapData): void
        {
            var _loc3_: uint;
            var _loc4_: GroupItem;
            var _loc5_: Map;
            var _loc6_: Boolean;
            _loc5_ = this._model.ownUserItems;
            _loc6_ = false;
            _loc3_ = 0;
            while (_loc3_ < _loc5_.length)
            {
                _loc4_ = (_loc5_.getWithIndex(_loc3_) as GroupItem);
                if (_loc4_.iconCallbackId == param1)
                {
                    _loc4_.iconImage = param2;
                    _loc6_ = true;
                }

                _loc3_++;
            }

            if (_loc6_)
            {
                this.updateItemList(this._model.ownUserId);
            }

            _loc5_ = this._model.otherUserItems;
            _loc6_ = false;
            _loc3_ = 0;
            while (_loc3_ < _loc5_.length)
            {
                _loc4_ = (_loc5_[_loc3_] as GroupItem);
                if (_loc4_.iconCallbackId == param1)
                {
                    _loc4_.iconImage = param2;
                    _loc6_ = true;
                }

                _loc3_++;
            }

            if (_loc6_)
            {
                this.updateItemList(this._model.otherUserId);
            }

        }

        protected function createThumbnailContainer(): IWindowContainer
        {
            var _loc1_: XML = XmlAsset(this._assetLibrary.getAssetByName("inventory_thumb_xml")).content as XML;
            return this._windowManager.buildFromXML(_loc1_) as IWindowContainer;
        }

        protected function selectOwnTradeItem(param1: uint): void
        {
            var _loc2_: GroupItem;
            if (this._model == null || this._model.ownUserItems == null)
            {
                return;
            }

            if (param1 < this._model.ownUserItems.length)
            {
                _loc2_ = (this._model.ownUserItems.getWithIndex(param1) as GroupItem);
                this.setSelection(_loc2_);
                if (_loc2_)
                {
                    this._model.getFurniInventoryModel().displayItemInfo(_loc2_);
                }

            }

        }

        protected function selectOthersTradeItem(param1: uint): void
        {
            var _loc2_: GroupItem;
            if (this._model == null || this._model.otherUserItems == null)
            {
                return;
            }

            if (param1 < this._model.otherUserItems.length)
            {
                _loc2_ = (this._model.otherUserItems.getWithIndex(param1) as GroupItem);
                this.setSelection(_loc2_);
                if (_loc2_)
                {
                    this._model.getFurniInventoryModel().displayItemInfo(_loc2_);
                }

            }

        }

        public function setSelection(param1: GroupItem): void
        {
            this.removeSelection();
            if (param1)
            {
                this._selectedItem = param1;
                this._selectedItem.isSelected = true;
            }

        }

        public function removeSelection(): void
        {
            if (this._selectedItem)
            {
                this._selectedItem.isSelected = false;
                this._selectedItem = null;
            }

        }

        public function updateItemImage(param1: int, param2: BitmapData): void
        {
        }

        private function windowMininizedEventProc(param1: WindowEvent, param2: IWindow): void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                switch (param2.name)
                {
                    case "button_continue":
                        this._model.requestFurniViewOpen();
                        return;
                    case "button_cancel":
                        this._model.requestCancelTrading();
                        return;
                }

            }

        }

        private function windowEventProc(param1: WindowEvent, param2: IWindow): void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                switch (param2.name)
                {
                    case "button_accept":
                        switch (this._model.state)
                        {
                            case TradingModel.TRADING_STATE_MODIFY:
                                if (this._model.otherUserItems.length == 0 && !this._model.ownUserAccepts)
                                {
                                    this.alertPopup(TRADING_NOTIFICATION_OTHER_NOT_OFFERING);
                                }

                                if (this._model.ownUserAccepts)
                                {
                                    this._model.requestUnacceptTrading();
                                }
                                else
                                {
                                    this._model.requestAcceptTrading();
                                }

                                break;
                            case TradingModel.TRADING_STATE_CONFIRM:
                                param2.disable();
                                this._model.requestConfirmAcceptTrading();
                                break;
                        }

                        return;
                    case "button_cancel":
                        switch (this._model.state)
                        {
                            case TradingModel.TRADING_STATE_MODIFY:
                                this._model.requestCancelTrading();
                                break;
                            case TradingModel.TRADING_STATE_CONFIRM:
                                this._model.requestConfirmDeclineTrading();
                                break;
                        }

                        return;
                }

            }

        }

        private function ownThumbEventProc(param1: WindowEvent, param2: IWindow): void
        {
            this.thumbEventProc(param1, param2, true);
        }

        private function othersThumbEventProc(param1: WindowEvent, param2: IWindow): void
        {
            this.thumbEventProc(param1, param2, false);
        }

        private function thumbEventProc(param1: WindowEvent, param2: IWindow, param3: Boolean): void
        {
            var _loc4_: GroupItem;
            var _loc5_: IItem;
            var _loc6_: BitmapData;
            var _loc7_: String;
            var _loc8_: FloorItem;
            var _loc9_: Date;
            if (param3 && param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                this._model.requestRemoveItemFromTrading(param2.id);
            }

            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
            {
                if (param3)
                {
                    _loc4_ = this._model.ownUserItems.getWithIndex(param2.id);
                }
                else
                {
                    _loc4_ = this._model.otherUserItems.getWithIndex(param2.id);
                }

                if (_loc4_ == null)
                {
                    return;
                }

                _loc5_ = _loc4_.peek();
                if (_loc5_ == null)
                {
                    return;
                }

                _loc6_ = this._model.getItemImage(_loc5_);
                _loc7_ = "${roomItem.name." + _loc5_.type + "}";
                if (_loc5_.category == FurniCategory.var_598)
                {
                    _loc7_ = "${poster_" + _loc5_.stuffData + "_name}";
                }

                if (_loc5_.category == FurniCategory.var_602)
                {
                    _loc8_ = (_loc5_ as FloorItem);
                    _loc9_ = new Date(_loc8_.creationYear, _loc8_.creationMonth, _loc8_.creationDay);
                    _loc7_ = this._localization.getKey("roomItem.name." + _loc5_.type) + " " + _loc9_.toLocaleDateString();
                }

                if (_loc5_.category == FurniCategory.var_600)
                {
                    _loc7_ = this.getTraxSongFurniName(_loc4_, _loc7_, true, param2.id, param3);
                }

                this._popup.updateContent(param2 as IWindowContainer, _loc7_, _loc6_, ItemPopupCtrl.var_1791);
                this._popup.show();
            }
            else
            {
                if (param1.type == WindowMouseEvent.var_626)
                {
                    this._popup.hideDelayed();
                }

            }

        }

        public function onTradingAlert(param1: IAlertDialog, param2: WindowEvent): void
        {
            if (param2.type == WindowEvent.var_138)
            {
                param1.dispose();
            }

        }

        private function getTraxSongFurniName(param1: GroupItem, param2: String, param3: Boolean, param4: uint = 1, param5: Boolean = false): String
        {
            var _loc6_: IItem = param1.peek();
            var _loc7_: ISongInfo = this._soundManager.musicController.getSongInfo(_loc6_.extra);
            if (_loc7_ != null)
            {
                this._localization.registerParameter("songdisc.info", "name", _loc7_.name);
                this._localization.registerParameter("songdisc.info", "author", _loc7_.creator);
                param2 = this._localization.getKey("songdisc.info");
            }
            else
            {
                if (param3)
                {
                    if (this._unknown1.length > 0)
                    {
                        this._unknown1.pop();
                        this._unknown1.pop();
                        this._unknown1.pop();
                    }

                    this._unknown1.push(param4);
                    this._unknown1.push(param1);
                    this._unknown1.push(param5);
                    this._soundManager.musicController.requestSongInfoWithoutSamples(_loc6_.extra);
                }

            }

            return param2;
        }

        private function onSongInfoReceivedEvent(param1: SongInfoReceivedEvent): void
        {
            var _loc2_: Boolean;
            var _loc3_: GroupItem;
            var _loc4_: uint;
            var _loc5_: IItem;
            var _loc6_: String;
            var _loc7_: BitmapData;
            var _loc8_: IWindow;
            if (this._unknown1.length > 0)
            {
                _loc2_ = this._unknown1.pop();
                _loc3_ = this._unknown1.pop();
                _loc4_ = this._unknown1.pop();
                _loc5_ = _loc3_.peek();
                if (_loc5_.extra == param1.id)
                {
                    if (_loc2_ && this._model.ownUserItems.getWithIndex(_loc4_) == _loc3_ || !_loc2_ && this._model.otherUserItems.getWithIndex(_loc4_) == _loc3_)
                    {
                        _loc6_ = this.getTraxSongFurniName(_loc3_, "", false);
                        _loc7_ = this._model.getItemImage(_loc5_);
                        _loc8_ = _loc2_
                                ? this.getOwnUsersItemGrid().getGridItemAt(_loc4_)
                                : this.getOtherUsersItemGrid().getGridItemAt(_loc4_);
                        this._popup.updateContent(_loc8_ as IWindowContainer, _loc6_, _loc7_, ItemPopupCtrl.var_1791);
                    }

                }
                else
                {
                    this._unknown1.push(_loc4_);
                    this._unknown1.push(_loc3_);
                    this._unknown1.push(_loc2_);
                }

            }

        }

    }
}
