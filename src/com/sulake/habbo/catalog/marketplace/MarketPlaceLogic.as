package com.sulake.habbo.catalog.marketplace
{

    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.utils.Map;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceConfigurationMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOffer;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOffersEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketPlaceOffersParser;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOwnOffersEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketPlaceOwnOffersParser;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceBuyOfferResultEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceBuyOfferResultParser;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceCancelOfferResultEvent;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceCancelOfferResultParser;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.catalog.enum.ProductTypeEnum;

    public class MarketPlaceLogic implements IMarketPlace
    {

        private static const var_778: String = "poster";

        public const var_775: int = 1;
        public const var_777: int = 2;
        public const var_2637: int = 3;

        private var _catalog: IHabboCatalog;
        private var _windowManager: IHabboWindowManager;
        private var _roomEngine: IRoomEngine;
        private var _visualization: IMarketPlaceVisualization;
        private var _dialog: MarketplaceConfirmationDialog;
        private var _latestOffers: Map;
        private var _latestOwnOffers: Map;
        private var _creditsWaiting: int;
        private var _averagePricePeriod: int = -1;
        private var _itemStats: MarketplaceItemStats;
        private var var_2643: int;
        private var var_2644: int;
        private var var_2645: int = 0;
        private var var_2646: int = 0;
        private var var_2647: String = "";
        private var var_2648: int = -1;
        private var _disposed: Boolean = false;

        public function MarketPlaceLogic(catalog: IHabboCatalog, windowManager: IHabboWindowManager, roomEngine: IRoomEngine)
        {
            this._catalog = catalog;
            this._windowManager = windowManager;
            this._roomEngine = roomEngine;
            this.getConfiguration();
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function dispose(): void
        {
            if (this.disposed)
            {
                return;
            }


            this._catalog = null;
            this._windowManager = null;

            if (this._latestOffers != null)
            {
                this.disposeOffers(this._latestOffers);
                this._latestOffers = null;
            }


            if (this._latestOwnOffers != null)
            {
                this.disposeOffers(this._latestOwnOffers);
                this._latestOwnOffers = null;
            }


            this._disposed = true;
        }

        public function get windowManager(): IHabboWindowManager
        {
            return this._windowManager;
        }

        public function get localization(): ICoreLocalizationManager
        {
            return this._catalog.localization;
        }

        public function registerVisualization(visualization: IMarketPlaceVisualization = null): void
        {
            if (visualization == null)
            {
                return;
            }


            this._visualization = visualization;
        }

        private function getConfiguration(): void
        {
            if (!this._catalog || !this._catalog.connection)
            {
                return;
            }


            this._catalog.connection.send(new GetMarketplaceConfigurationMessageComposer());
        }

        private function showConfirmation(param1: int, param2: MarketPlaceOfferData): void
        {
            if (!this._dialog)
            {
                this._dialog = new MarketplaceConfirmationDialog(this, this._catalog, this._roomEngine);
            }


            this._dialog.showConfirmation(param1, param2);
        }

        public function requestOffersByName(param1: String): void
        {
            if (this._catalog)
            {
                this._catalog.getPublicMarketPlaceOffers(-1, -1, param1, -1);
            }

        }

        public function requestOffersByPrice(param1: int): void
        {
            if (this._catalog)
            {
                this._catalog.getPublicMarketPlaceOffers(param1, -1, "", -1);
            }

        }

        public function requestOffers(param1: int, param2: int, param3: String, param4: int): void
        {
            this.var_2645 = param1;
            this.var_2646 = param2;
            this.var_2647 = param3;
            this.var_2648 = param4;

            if (this._catalog)
            {
                this._catalog.getPublicMarketPlaceOffers(param1, param2, param3, param4);
            }

        }

        public function refreshOffers(): void
        {
            this.requestOffers(this.var_2645, this.var_2646, this.var_2647, this.var_2648);
        }

        public function requestOwnItems(): void
        {
            if (this._catalog)
            {
                this._catalog.getOwnMarketPlaceOffers();
            }

        }

        public function requestItemStats(param1: int, param2: int): void
        {
            if (this._catalog)
            {
                this.var_2644 = param2;
                this.var_2643 = param1;
                this._catalog.getMarketplaceItemStats(param1, param2);
            }

        }

        public function buyOffer(param1: int): void
        {
            if (!this._latestOffers || !this._catalog || !this._catalog.getPurse())
            {
                return;
            }

            var _loc2_: MarketPlaceOfferData = this._latestOffers.getValue(param1) as MarketPlaceOfferData;
            if (!_loc2_)
            {
                return;
            }

            if (this._catalog.getPurse().credits < _loc2_.price)
            {
                this._catalog.showNotEnoughCreditsAlert();
                return;
            }

            this.showConfirmation(this.var_775, _loc2_);
        }

        public function redeemExpiredOffer(param1: int): void
        {
            if (this._catalog)
            {
                this._catalog.redeemExpiredMarketPlaceOffer(param1);
            }

        }

        public function redeemSoldOffers(): void
        {
            var key: int;
            var offerData: MarketPlaceOfferData;

            if (this.disposed)
            {
                return;
            }


            if (this._latestOwnOffers == null)
            {
                return;
            }


            var ownOfferKeys: Array = this._latestOwnOffers.getKeys();

            for each (key in ownOfferKeys)
            {
                offerData = this._latestOwnOffers.getValue(key);

                if (offerData.status == MarketPlaceOfferState.var_776)
                {
                    this._latestOwnOffers.remove(key);
                    offerData.dispose();
                }

            }


            if (this._catalog)
            {
                this._catalog.redeemSoldMarketPlaceOffers();
            }


            if (this._visualization != null)
            {
                this._visualization.listUpdatedNotify();
            }

        }

        private function disposeOffers(offers: Map): void
        {
            var offerData: MarketPlaceOfferData;

            if (offers != null)
            {
                for each (offerData in offers)
                {
                    if (offerData != null)
                    {
                        offerData.dispose();
                    }

                }


                offers.dispose();
            }

        }

        public function onOffers(event: IMessageEvent): void
        {
            var offer: MarketPlaceOffer;
            var offerData: MarketPlaceOfferData;
            var offersEvent: MarketPlaceOffersEvent = event as MarketPlaceOffersEvent;

            if (offersEvent == null)
            {
                return;
            }


            var parser: MarketPlaceOffersParser = offersEvent.getParser() as MarketPlaceOffersParser;

            if (parser == null)
            {
                return;
            }


            this.disposeOffers(this._latestOffers);
            this._latestOffers = new Map();

            for each (offer in parser.offers)
            {
                offerData = new MarketPlaceOfferData(offer.offerId, offer.furniId, offer.furniType, offer.stuffData, offer.price, offer.status, offer.averagePrice, offer.offerCount);
                offerData.timeLeftMinutes = offer.timeLeftMinutes;
                this._latestOffers.add(offer.offerId, offerData);
            }


            if (this._visualization != null)
            {
                this._visualization.listUpdatedNotify();
            }

        }

        public function onOwnOffers(event: IMessageEvent): void
        {
            var offer: MarketPlaceOffer;
            var offerData: MarketPlaceOfferData;
            var offersEvent: MarketPlaceOwnOffersEvent = event as MarketPlaceOwnOffersEvent;

            if (offersEvent == null)
            {
                return;
            }


            var parser: MarketPlaceOwnOffersParser = offersEvent.getParser() as MarketPlaceOwnOffersParser;

            if (parser == null)
            {
                return;
            }


            this.disposeOffers(this._latestOwnOffers);

            this._latestOwnOffers = new Map();
            this._creditsWaiting = parser.creditsWaiting;

            for each (offer in parser.offers)
            {
                offerData = new MarketPlaceOfferData(offer.offerId, offer.furniId, offer.furniType, offer.stuffData, offer.price, offer.status, offer.averagePrice);
                offerData.timeLeftMinutes = offer.timeLeftMinutes;
                this._latestOwnOffers.add(offer.offerId, offerData);
            }


            if (this._visualization != null)
            {
                this._visualization.listUpdatedNotify();
            }

        }

        public function onBuyResult(event: IMessageEvent): void
        {
            var item: MarketPlaceOfferData;
            var updateItem: MarketPlaceOfferData;
            var buyEvent: MarketplaceBuyOfferResultEvent = event as MarketplaceBuyOfferResultEvent;

            if (event == null)
            {
                return;
            }


            var parser: MarketplaceBuyOfferResultParser = buyEvent.getParser() as MarketplaceBuyOfferResultParser;

            if (parser == null)
            {
                return;
            }


            if (parser.result == 1)
            {
                this.refreshOffers();
            }
            else
            {
                if (parser.result == 2)
                {
                    item = this._latestOffers.remove(parser.requestedOfferId);

                    if (item != null)
                    {
                        item.dispose();
                    }


                    if (this._visualization != null)
                    {
                        this._visualization.listUpdatedNotify();
                    }


                    if (this._windowManager != null)
                    {
                        this._windowManager.alert("${catalog.marketplace.not_available_title}", "${catalog.marketplace.not_available_header}", 0, function (param1: IAlertDialog, param2: WindowEvent): void
                        {
                            event.dispose();
                        });
                    }

                }
                else
                {
                    if (parser.result == 3)
                    {
                        updateItem = (this._latestOffers.getValue(parser.requestedOfferId) as MarketPlaceOfferData);

                        if (updateItem)
                        {
                            updateItem.offerId = parser.offerId;
                            updateItem.price = parser.newPrice;
                            updateItem.offerCount--;
                            this._latestOffers.add(parser.offerId, updateItem);
                        }


                        this._latestOffers.remove(parser.requestedOfferId);

                        this.showConfirmation(this.var_777, updateItem);

                        if (this._visualization != null)
                        {
                            this._visualization.listUpdatedNotify();
                        }

                    }
                    else
                    {
                        if (parser.result == 4)
                        {
                            if (this._windowManager != null)
                            {
                                this._windowManager.alert("${catalog.alert.notenough.title}", "${catalog.alert.notenough.credits.description}", 0, function (param1: IAlertDialog, param2: WindowEvent): void
                                {
                                    param1.dispose();
                                });
                            }

                        }

                    }

                }

            }

        }

        public function onCancelResult(event: IMessageEvent): void
        {
            var item: MarketPlaceOfferData;
            var cancelEvent: MarketplaceCancelOfferResultEvent = event as MarketplaceCancelOfferResultEvent;

            if (event == null)
            {
                return;
            }


            var parser: MarketplaceCancelOfferResultParser = cancelEvent.getParser() as MarketplaceCancelOfferResultParser;

            if (parser == null)
            {
                return;
            }


            if (parser.result == 1)
            {
                item = this._latestOwnOffers.remove(parser.offerId);

                if (item != null)
                {
                    item.dispose();
                }


                if (this._visualization != null)
                {
                    this._visualization.listUpdatedNotify();
                }

            }
            else
            {
                if (parser.result == 0)
                {
                    if (this._windowManager != null)
                    {
                        this._windowManager.alert("${catalog.marketplace.operation_failed.topic}", "{{catalog.marketplace.cancel_failed}", 0, function (param1: IAlertDialog, param2: WindowEvent): void
                        {
                            param1.dispose();
                        });
                    }

                }

            }

        }

        public function latestOffers(): Map
        {
            return this._latestOffers;
        }

        public function latestOwnOffers(): Map
        {
            return this._latestOwnOffers;
        }

        public function set itemStats(itemStates: MarketplaceItemStats): void
        {
            if (itemStates.furniCategoryId != this.var_2643 || itemStates.furniTypeId != this.var_2644)
            {
                return;
            }


            this._itemStats = itemStates;

            if (this._visualization != null)
            {
                this._visualization.updateStats();
            }

        }

        public function get itemStats(): MarketplaceItemStats
        {
            return this._itemStats;
        }

        public function get creditsWaiting(): int
        {
            return this._creditsWaiting;
        }

        public function get averagePricePeriod(): int
        {
            return this._averagePricePeriod;
        }

        public function set averagePricePeriod(param1: int): void
        {
            this._averagePricePeriod = param1;
        }

        private function isPosterItem(offerData: IMarketPlaceOfferData): Boolean
        {
            var furnitureData: IFurnitureData;
            var name: String;
            var isPoster: Boolean;

            if (offerData.furniType == 2 && offerData.stuffData != null)
            {
                furnitureData = this._catalog.getFurnitureData(offerData.furniId, ProductTypeEnum.var_113);
                if (furnitureData)
                {
                    name = furnitureData.name;
                    if (name != null && name == var_778)
                    {
                        isPoster = true;
                    }

                }

            }

            return isPoster;
        }

        public function getNameLocalizationKey(offerData: IMarketPlaceOfferData): String
        {
            var localizationKey: String = "";

            if (offerData != null)
            {
                if (this.isPosterItem(offerData))
                {
                    localizationKey = "poster_" + offerData.stuffData + "_name";
                }
                else
                {
                    localizationKey = "roomItem.name." + offerData.furniId;
                }

            }


            return localizationKey;
        }

        public function getDescriptionLocalizationKey(offerData: IMarketPlaceOfferData): String
        {
            var localizationKey: String = "";

            if (offerData != null)
            {
                if (this.isPosterItem(offerData))
                {
                    localizationKey = "poster_" + offerData.stuffData + "_desc";
                }
                else
                {
                    localizationKey = "roomItem.desc." + offerData.furniId;
                }

            }

            return localizationKey;
        }

    }
}
