package com.sulake.habbo.inventory.trading
{

    import com.sulake.habbo.inventory.IInventoryModel;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.inventory.HabboInventory;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.inventory.enum.InventoryCategory;

    import flash.events.Event;

    import com.sulake.habbo.inventory.events.HabboInventoryTrackingEvent;
    import com.sulake.habbo.inventory.enum.InventorySubCategory;
    import com.sulake.habbo.inventory.furni.FurniModel;
    import com.sulake.habbo.inventory.items.GroupItem;
    import com.sulake.habbo.inventory.items.IItem;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.inventory.items.FloorItem;
    import com.sulake.room.utils.Vector3d;

    import flash.display.BitmapData;

    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCloseEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingAlreadyOpenEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingAcceptEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingConfirmationEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCompletedEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingNotOpenEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingOtherNotAllowedEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingYouAreNotAllowedEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.OpenTradingComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.AddItemToTradeComposer;
    import com.sulake.habbo.inventory.enum.FurniCategory;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.RemoveItemFromTradeComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.AcceptTradingComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.UnacceptTradingComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.ConfirmAcceptTradingComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.ConfirmDeclineTradingComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.CloseTradingComposer;

    public class TradingModel implements IInventoryModel, IGetImageListener
    {

        public static const TRADING_MAX_ITEMS: uint = 9;
        public static const TRADING_STATE_INIT: uint = 0;
        public static const TRADING_STATE_MODIFY: uint = 1;
        public static const TRADING_STATE_COUNTDOWN: uint = 2;
        public static const TRADING_STATE_CONFIRM: uint = 3;
        public static const TRADING_STATE_WAITING: uint = 4;
        public static const TRADING_STATE_ACCEPTED: uint = 5;
        public static const TRADING_STATE_CANCELLED: uint = 6;

        private var _inventory: HabboInventory;
        private var _assetLibrary: IAssetLibrary;
        private var _roomEngine: IRoomEngine;
        private var _communication: IHabboCommunicationManager;
        private var _localization: IHabboLocalizationManager;
        private var _soundManager: IHabboSoundManager;
        private var _view: TradingView;
        private var _disposed: Boolean = false;
        private var _isTrading: Boolean = false;
        private var _state: uint = 0;
        private var _ownUserId: int = -1;
        private var _ownUserName: String = "";
        private var _ownUserItems: Map;
        private var _ownUserAccepts: Boolean = false;
        private var _ownUserCanTrade: Boolean = false;
        private var _otherUserId: int = -1;
        private var _otherUserName: String = "";
        private var _otherUserItems: Map;
        private var _otherUserAccepts: Boolean = false;
        private var _otherUserCanTrade: Boolean = false;

        public function TradingModel(inventory: HabboInventory, windowManager: IHabboWindowManager, communication: IHabboCommunicationManager, assetLibrary: IAssetLibrary, roomEngine: IRoomEngine, localization: IHabboLocalizationManager, soundManager: IHabboSoundManager)
        {
            this._inventory = inventory;
            this._communication = communication;
            this._assetLibrary = assetLibrary;
            this._roomEngine = roomEngine;
            this._localization = localization;
            this._soundManager = soundManager;

            this._view = new TradingView(this, windowManager, assetLibrary, roomEngine, localization, soundManager);
        }

        public function get running(): Boolean
        {
            return this._state != TRADING_STATE_INIT;
        }

        public function get state(): uint
        {
            return this._state;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get ownUserId(): int
        {
            return this._ownUserId;
        }

        public function get ownUserName(): String
        {
            return this._ownUserName;
        }

        public function get ownUserItems(): Map
        {
            return this._ownUserItems;
        }

        public function get ownUserAccepts(): Boolean
        {
            return this._ownUserAccepts;
        }

        public function get ownUserCanTrade(): Boolean
        {
            return this._ownUserCanTrade;
        }

        public function get otherUserId(): int
        {
            return this._otherUserId;
        }

        public function get otherUserName(): String
        {
            return this._otherUserName;
        }

        public function get otherUserItems(): Map
        {
            return this._otherUserItems;
        }

        public function get otherUserAccepts(): Boolean
        {
            return this._otherUserAccepts;
        }

        public function get otherUserCanTrade(): Boolean
        {
            return this._otherUserCanTrade;
        }

        public function dispose(): void
        {
            if (!this._disposed)
            {
                if (this._view && !this._view.disposed)
                {
                    this._view.dispose();
                    this._view = null;
                }

                this._inventory = null;
                this._communication = null;
                this._assetLibrary = null;
                this._roomEngine = null;
                this._localization = null;
                this._disposed = true;
            }

        }

        public function startTrading(ownUserId: int, ownerUserName: String, ownUserCanTrade: Boolean, otherUserId: int, otherUserName: String, otherUserCanTrade: Boolean): void
        {
            this._ownUserId = ownUserId;
            this._ownUserName = ownerUserName;
            this._ownUserItems = new Map();
            this._ownUserAccepts = false;
            this._ownUserCanTrade = ownUserCanTrade;
            this._otherUserId = otherUserId;
            this._otherUserName = otherUserName;
            this._otherUserItems = new Map();
            this._otherUserAccepts = false;
            this._otherUserCanTrade = otherUserCanTrade;
            this._isTrading = true;
            this.state = TRADING_STATE_MODIFY;
            this._view.setup(ownUserId, ownUserCanTrade, otherUserId, otherUserCanTrade);
            this._view.updateItemList(this._ownUserId);
            this._view.updateItemList(this._otherUserId);
            this._view.updateUserInterface();
            this._view.clearItemLists();
            this._inventory.toggleInventoryPage(InventoryCategory.FURNI);
            this._inventory.events.dispatchEvent(new Event(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_TRADING));
        }

        public function close(): void
        {
            if (this._isTrading)
            {
                if (this._state != TRADING_STATE_INIT && this._state != TRADING_STATE_ACCEPTED)
                {
                    this.requestCancelTrading();
                    this.state = TradingModel.TRADING_STATE_CANCELLED;
                }

                this.state = TRADING_STATE_INIT;
                this._inventory.toggleInventorySubPage(InventorySubCategory.EMPTY);
                this._isTrading = false;
            }

            this._view.setMinimized(false);
        }

        public function categorySwitch(id: String): void
        {
            this._view.setMinimized(id != InventoryCategory.FURNI);
            this._inventory.updateSubView();
        }

        public function set state(value: uint): void
        {
            Logger.log("OLD STATE: " + this._state + " NEW STATE: " + value + " OWN: " + this._ownUserAccepts + " OTHER: " + this._otherUserAccepts);
            var updated: Boolean;

            if (this._state == value)
            {
                return;
            }

            switch (this._state)
            {
                case TRADING_STATE_INIT:
                    if (value == TRADING_STATE_MODIFY || value == TRADING_STATE_ACCEPTED)
                    {
                        this._state = value;
                        updated = true;
                    }

                    break;

                case TRADING_STATE_MODIFY:

                    if (value == TRADING_STATE_COUNTDOWN)
                    {
                        this._state = value;
                        updated = true;
                        this.startConfirmCountdown();
                    }
                    else if (value == TRADING_STATE_CANCELLED)
                    {
                        this._state = value;
                        this._view.setMinimized(false);
                        updated = true;
                    }

                    break;

                case TRADING_STATE_COUNTDOWN:
                    if (value == TRADING_STATE_CONFIRM)
                    {
                        this._state = value;
                        updated = true;
                    }
                    else if (value == TRADING_STATE_CANCELLED)
                    {
                        this._state = value;
                        this._view.setMinimized(false);
                        updated = true;
                    }
                    else if (value == TRADING_STATE_MODIFY)
                    {
                        this._state = value;
                        updated = true;
                        this.cancelConfirmCountdown();
                    }

                    break;

                case TRADING_STATE_CONFIRM:
                    if (value == TRADING_STATE_WAITING)
                    {
                        this._state = value;
                        updated = true;
                    }
                    else if (value == TRADING_STATE_ACCEPTED)
                    {
                        this._state = value;
                        updated = true;
                        this.close();
                    }
                    else if (value == TRADING_STATE_CANCELLED)
                    {
                        this._state = value;
                        this._view.setMinimized(false);
                        updated = true;
                        this.close();
                    }

                    break;

                case TRADING_STATE_WAITING:
                    if (value == TRADING_STATE_ACCEPTED)
                    {
                        this._state = value;
                        this._view.setMinimized(false);
                        updated = true;
                        this.close();
                    }
                    else if (value == TRADING_STATE_CANCELLED)
                    {
                        this._state = value;
                        this._view.setMinimized(false);
                        updated = true;
                        this.close();
                    }

                    break;

                case TRADING_STATE_ACCEPTED:
                    if (value == TRADING_STATE_INIT)
                    {
                        this._state = value;
                        updated = true;
                    }

                    break;

                case TRADING_STATE_CANCELLED:
                    if (value == TRADING_STATE_INIT)
                    {
                        this._state = value;
                        updated = true;
                    }
                    else if (value == TRADING_STATE_MODIFY)
                    {
                        this._state = value;
                        updated = true;
                    }

                    break;
                default:
                    throw new Error("Unknown trading progress state: \"" + this._state + "\"");
            }

            if (updated)
            {
                this._view.updateUserInterface();
            }
            else
            {
                throw new Error("Error assigning trading process status!");
            }

        }

        public function getFurniInventoryModel(): FurniModel
        {
            return this._inventory.furniModel;
        }

        public function updateItemGroupMaps(param1: int, param2: Map, param3: int, param4: Map): void
        {
            if (this._inventory == null)
            {
                return;
            }

            if (this._ownUserItems != null)
            {
                this._ownUserItems.dispose();
            }

            if (this._otherUserItems != null)
            {
                this._otherUserItems.dispose();
            }

            if (param1 == this._ownUserId)
            {
                this._ownUserItems = param2;
                this._otherUserItems = param4;
            }
            else
            {
                this._ownUserItems = param4;
                this._otherUserItems = param2;
            }

            this._ownUserAccepts = false;
            this._otherUserAccepts = false;
            this._view.updateItemList(this._ownUserId);
            this._view.updateItemList(this._otherUserId);
            this._view.updateUserInterface();

            var model: FurniModel = this._inventory.furniModel;

            if (model != null)
            {
                model.updateItemLocks();
            }

        }

        public function getOwnItemIdsInTrade(): Array
        {
            var groupItem: GroupItem;
            var item: IItem;
            var j: int;
            var ownItems: Array = [];

            if (this._ownUserItems == null || this._ownUserItems.disposed)
            {
                return ownItems;
            }

            var i: int;

            while (i < this._ownUserItems.length)
            {
                groupItem = (this._ownUserItems.getWithIndex(i) as GroupItem);

                if (groupItem != null)
                {
                    j = 0;

                    while (j < groupItem.getTotalCount())
                    {
                        item = groupItem.getAt(j);

                        if (item != null)
                        {
                            ownItems.push(item.ref);
                        }

                        j++;
                    }

                }

                i++;
            }

            return ownItems;
        }

        public function getWindowContainer(): IWindowContainer
        {
            return this._view.getWindowContainer();
        }

        public function requestInitialization(param1: int = 0): void
        {
        }

        public function subCategorySwitch(param1: String): void
        {
            if (this._isTrading)
            {
                if (this._state != TRADING_STATE_INIT)
                {
                    this.requestCancelTrading();
                }

            }

        }

        public function closingInventoryView(): void
        {
            if (this._isTrading)
            {
                this.close();
            }

        }

        public function startConfirmCountdown(): void
        {
            this._view.startConfirmCountdown();
        }

        public function cancelConfirmCountdown(): void
        {
            this._view.cancelConfirmCountdown();
        }

        public function confirmCountdownReady(): void
        {
            if (this._state == TRADING_STATE_COUNTDOWN)
            {
                this.state = TRADING_STATE_CONFIRM;
            }

        }

        public function getItemImage(item: IItem): BitmapData
        {
            var result: ImageResult;

            if (item is FloorItem)
            {
                result = this._roomEngine.getFurnitureImage(item.type, new Vector3d(180, 0, 0), 64, this, 0, String(item.extra));
            }
            else
            {
                result = this._roomEngine.getWallItemImage(item.type, new Vector3d(180, 0, 0), 64, this, 0, item.stuffData);
            }

            return result.data as BitmapData;
        }

        public function imageReady(param1: int, param2: BitmapData): void
        {
            this._view.updateItemImage(param1, param2);
        }

        public function handleMessageEvent(event: IMessageEvent): void
        {
            var tradingCloseEvent: TradingCloseEvent;

            if (event is TradingAlreadyOpenEvent)
            {
                Logger.log("TRADING::TradingAlreadyOpenEvent");
                this._view.alertPopup(TradingView.TRADING_NOTIFICATION_ALREADY_OPEN);
            }
            else
            {
                if (event is TradingAcceptEvent)
                {
                    Logger.log("TRADING::TradingAcceptEvent");
                    if (TradingAcceptEvent(event).userID == this._ownUserId)
                    {
                        this._ownUserAccepts = TradingAcceptEvent(event).userAccepts != 0;
                    }
                    else
                    {
                        this._otherUserAccepts = TradingAcceptEvent(event).userAccepts != 0;
                    }

                    this._view.updateUserInterface();
                }
                else
                {
                    if (event is TradingConfirmationEvent)
                    {
                        Logger.log("TRADING::TradingConfirmationEvent");
                        this.state = TRADING_STATE_COUNTDOWN;
                    }
                    else
                    {
                        if (event is TradingCompletedEvent)
                        {
                            Logger.log("TRADING::TradingCompletedEvent");
                            this.state = TRADING_STATE_ACCEPTED;
                        }
                        else
                        {
                            if (event is TradingCloseEvent)
                            {
                                Logger.log("TRADING::TradingCloseEvent");
                                if (!this._isTrading)
                                {
                                    Logger.log("Received TradingCloseEvent, but trading already stopped!!!");
                                    return;
                                }

                                tradingCloseEvent = (event as TradingCloseEvent);

                                if (tradingCloseEvent.userID != this._ownUserId)
                                {
                                    this._view.alertPopup(TradingView.TRADING_NOTIFICATION_CLOSED);
                                }

                                this.close();
                            }
                            else
                            {
                                if (event is TradingNotOpenEvent)
                                {
                                    Logger.log("TRADING::TradingNotOpenEvent");
                                }
                                else
                                {
                                    if (event is TradingOtherNotAllowedEvent)
                                    {
                                        this._view.showOtherUserNotification("${inventory.trading.warning.others_account_disabled}");
                                    }
                                    else
                                    {
                                        if (event is TradingYouAreNotAllowedEvent)
                                        {
                                            this._view.showOwnUserNotification("${inventory.trading.warning.own_account_disabled}");
                                        }
                                        else
                                        {
                                            Logger.log("TRADING/Unknown message event: " + event);
                                        }

                                    }

                                }

                            }

                        }

                    }

                }

            }

        }

        public function requestFurniViewOpen(): void
        {
            this._inventory.toggleInventoryPage(InventoryCategory.FURNI);
        }

        public function requestOpenTrading(param1: int): void
        {
            this._communication.getHabboMainConnection(null).send(new OpenTradingComposer(param1));
        }

        public function requestAddItemToTrading(param1: int, param2: int, param3: int, param4: Boolean, param5: String = ""): Boolean
        {
            var _loc6_: String;

            if (this._ownUserAccepts)
            {
                return false;
            }

            if (this._ownUserItems == null)
            {
                return false;
            }

            if (this._ownUserItems.length < TRADING_MAX_ITEMS)
            {
                this._communication.getHabboMainConnection(null).send(new AddItemToTradeComposer(param1));
            }
            else
            {
                if (!param4)
                {
                    return false;
                }

                _loc6_ = String(param2);

                if (param3 == FurniCategory.var_598)
                {
                    _loc6_ = String(param2) + "poster" + param5;
                }

                if (this._ownUserItems.getValue(_loc6_) != null)
                {
                    this._communication.getHabboMainConnection(null).send(new AddItemToTradeComposer(param1));
                }
                else
                {
                    return false;
                }

            }

            return true;
        }

        public function requestRemoveItemFromTrading(param1: int): void
        {
            var _loc3_: IItem;
            if (this._ownUserAccepts)
            {
                return;
            }

            var _loc2_: GroupItem = this.ownUserItems.getWithIndex(param1);
            if (_loc2_)
            {
                _loc3_ = _loc2_.peek();
                if (_loc3_)
                {
                    this._communication.getHabboMainConnection(null).send(new RemoveItemFromTradeComposer(_loc3_.id));
                }

            }

        }

        public function requestAcceptTrading(): void
        {
            this._communication.getHabboMainConnection(null).send(new AcceptTradingComposer());
        }

        public function requestUnacceptTrading(): void
        {
            this._communication.getHabboMainConnection(null).send(new UnacceptTradingComposer());
        }

        public function requestConfirmAcceptTrading(): void
        {
            this.state = TRADING_STATE_WAITING;
            this._communication.getHabboMainConnection(null).send(new ConfirmAcceptTradingComposer());
        }

        public function requestConfirmDeclineTrading(): void
        {
            this._communication.getHabboMainConnection(null).send(new ConfirmDeclineTradingComposer());
        }

        public function requestCancelTrading(): void
        {
            this._communication.getHabboMainConnection(null).send(new CloseTradingComposer());
        }

    }
}
