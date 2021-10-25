package com.sulake.habbo.inventory.marketplace
{

    import com.sulake.habbo.inventory.IInventoryModel;
    import com.sulake.habbo.inventory.HabboInventory;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.inventory.items.IItem;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.inventory.furni.FurniModel;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceCanMakeOfferComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.BuyMarketplaceTokensMessageComposer;
    import com.sulake.habbo.inventory.items.FloorItem;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.MakeOfferMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceItemStatsComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceConfigurationMessageComposer;
    import com.sulake.core.window.IWindowContainer;

    public class MarketplaceModel implements IInventoryModel
    {

        private var _controller: HabboInventory;
        private var _assets: IAssetLibrary;
        private var _windowManager: IHabboWindowManager;
        private var _roomEngine: IRoomEngine;
        private var _communication: IHabboCommunicationManager;
        private var _disposed: Boolean = false;
        private var _activeItem: IItem;
        private var _isEnabled: Boolean;
        private var _commision: int;
        private var _tokenBatchPrice: int;
        private var _tokenBatchSize: int;
        private var _offerMinPrice: int;
        private var _offerMaxPrice: int;
        private var _expirationHours: int;
        private var _averagePricePeriod: int;
        private var _isFloorItem: int;
        private var _itemType: int;
        private var _view: MarketplaceView;
        private var _locked: Boolean = false;

        public function MarketplaceModel(param1: HabboInventory, param2: IHabboWindowManager, param3: IHabboCommunicationManager, param4: IAssetLibrary, param5: IRoomEngine, param6: IHabboLocalizationManager, param7: IHabboConfigurationManager)
        {
            this._controller = param1;
            this._communication = param3;
            this._windowManager = param2;
            this._assets = param4;
            this._roomEngine = param5;
            this._view = new MarketplaceView(this, this._windowManager, this._assets, param5, param6, param7);
        }

        public function set isEnabled(param1: Boolean): void
        {
            this._isEnabled = param1;
        }

        public function set commission(param1: int): void
        {
            this._commision = param1;
        }

        public function set tokenBatchPrice(param1: int): void
        {
            this._tokenBatchPrice = param1;
        }

        public function set tokenBatchSize(param1: int): void
        {
            this._tokenBatchSize = param1;
        }

        public function set offerMinPrice(param1: int): void
        {
            this._offerMinPrice = param1;
        }

        public function set offerMaxPrice(param1: int): void
        {
            this._offerMaxPrice = param1;
        }

        public function set expirationHours(param1: int): void
        {
            this._expirationHours = param1;
        }

        public function set averagePricePeriod(param1: int): void
        {
            this._averagePricePeriod = param1;
        }

        public function get isEnabled(): Boolean
        {
            return this._isEnabled;
        }

        public function get commission(): int
        {
            return this._commision;
        }

        public function get tokenBatchPrice(): int
        {
            return this._tokenBatchPrice;
        }

        public function get tokenBatchSize(): int
        {
            return this._tokenBatchSize;
        }

        public function get offerMinPrice(): int
        {
            return this._offerMinPrice;
        }

        public function get offerMaxPrice(): int
        {
            return this._offerMaxPrice;
        }

        public function get expirationHours(): int
        {
            return this._expirationHours;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function dispose(): void
        {
            this._controller = null;
            this._communication = null;
            this._windowManager = null;
            this._assets = null;
            this._roomEngine = null;
        }

        public function releaseItem(): void
        {
            if (this._controller != null && this._controller.furniModel != null && this._activeItem != null)
            {
                this._controller.furniModel.removeLockFrom(this._activeItem.id);
                this._activeItem = null;
            }

        }

        public function startOfferMaking(param1: IItem): void
        {
            if (this._activeItem != null || param1 == null)
            {
                return;
            }

            if (this._controller == null)
            {
                return;
            }

            var _loc2_: FurniModel = this._controller.furniModel;
            if (_loc2_ == null)
            {
                return;
            }

            this._activeItem = param1;
            _loc2_.addLockTo(param1.id);
            var _loc3_: IConnection = this._communication.getHabboMainConnection(null);
            if (_loc3_ == null)
            {
                return;
            }

            _loc3_.send(new GetMarketplaceCanMakeOfferComposer());
        }

        public function buyMarketplaceTokens(): void
        {
            var _loc1_: IConnection = this._communication.getHabboMainConnection(null);
            if (_loc1_ == null)
            {
                return;
            }

            _loc1_.send(new BuyMarketplaceTokensMessageComposer());
            this._locked = true;
        }

        public function makeOffer(param1: int): void
        {
            if (this._activeItem == null)
            {
                return;
            }

            var _loc2_: IConnection = this._communication.getHabboMainConnection(null);
            if (_loc2_ == null)
            {
                return;
            }

            var _loc3_: int = (this._activeItem is FloorItem) ? 1 : 2;
            _loc2_.send(new MakeOfferMessageComposer(param1, _loc3_, this._activeItem.ref));
            this.releaseItem();
        }

        public function getItemStats(): void
        {
            if (this._activeItem == null)
            {
                return;
            }

            var _loc1_: IConnection = this._communication.getHabboMainConnection(null);
            if (_loc1_ == null)
            {
                return;
            }

            var _loc2_: int = (this._activeItem is FloorItem) ? 1 : 2;
            this._isFloorItem = _loc2_;
            this._itemType = this._activeItem.type;
            _loc1_.send(new GetMarketplaceItemStatsComposer(_loc2_, this._activeItem.type));
        }

        public function proceedOfferMaking(param1: int, param2: int): void
        {
            this._locked = false;
            switch (param1)
            {
                case 1:
                    this._view.showMakeOffer(this._activeItem);
                    return;
                case 2:
                    this._view.showAlert("$" + "{inventory.marketplace.no_trading_privilege.title}", "$" + "{inventory.marketplace.no_trading_privilege.info}");
                    return;
                case 3:
                    this._view.showAlert("$" + "{inventory.marketplace.no_trading_pass.title}", "$" + "{inventory.marketplace.no_trading_pass.info}");
                    return;
                case 4:
                    this._view.showBuyTokens(this._tokenBatchPrice, this._tokenBatchSize);
                    return;
            }

        }

        public function endOfferMaking(param1: int): void
        {
            if (!this._view)
            {
                return;
            }

            this._view.showResult(param1);
        }

        public function setAveragePrice(isFloorItem: int, itemType: int, averagePrice: int): void
        {
            if (isFloorItem != this._isFloorItem || itemType != this._itemType)
            {
                return;
            }

            if (!this._view)
            {
                return;
            }

            this._view.updateAveragePrice(averagePrice, this._averagePricePeriod);
        }

        public function onNotEnoughCredits(): void
        {
            if (this._locked)
            {
                this._locked = false;
                this.releaseItem();
            }

        }

        public function requestInitialization(param1: int = 0): void
        {
            var _loc2_: IConnection = this._communication.getHabboMainConnection(null);
            if (_loc2_ == null)
            {
                return;
            }

            _loc2_.send(new GetMarketplaceConfigurationMessageComposer());
        }

        public function getWindowContainer(): IWindowContainer
        {
            return null;
        }

        public function categorySwitch(param1: String): void
        {
        }

        public function subCategorySwitch(param1: String): void
        {
        }

        public function closingInventoryView(): void
        {
        }

    }
}
