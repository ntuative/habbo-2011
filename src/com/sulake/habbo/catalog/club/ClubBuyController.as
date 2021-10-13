package com.sulake.habbo.catalog.club
{
    import com.sulake.habbo.catalog.viewer.widgets.ClubBuyCatalogWidget;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubOfferData;
    import com.sulake.habbo.communication.messages.parser.catalog.HabboClubOffersMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.HabboClubOffersMessageEvent;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.catalog.purse.IPurse;

    public class ClubBuyController 
    {

        private var _visualization:ClubBuyCatalogWidget;
        private var _catalog:HabboCatalog;
        private var _offers:Array;
        private var var_2609:ClubBuyConfirmationDialog;
        private var _disposed:Boolean = false;

        public function ClubBuyController(param1:HabboCatalog)
        {
            this._catalog = param1;
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                if (this._visualization != null)
                {
                    this._visualization.dispose();
                    this._visualization = null;
                };
                this.reset();
                this.closeConfirmation();
                this._disposed = true;
            };
        }

        public function reset():void
        {
            var _loc1_:ClubBuyOfferData;
            for each (_loc1_ in this._offers)
            {
                _loc1_.dispose();
            };
            this._offers = [];
        }

        public function onOffers(param1:HabboClubOffersMessageEvent):void
        {
            var _loc4_:ClubBuyOfferData;
            var _loc5_:ClubOfferData;
            var _loc6_:ClubBuyOfferData;
            var _loc7_:ClubBuyOfferData;
            if (this._disposed)
            {
                return;
            };
            var _loc2_:HabboClubOffersMessageParser = param1.getParser();
            this.reset();
            this._visualization.reset();
            this._visualization.initClubType(this.getClubType());
            this._offers = [];
            var _loc3_:int;
            for each (_loc5_ in _loc2_.offers)
            {
                _loc7_ = new ClubBuyOfferData(_loc5_.offerId, _loc5_.productCode, _loc5_.price, _loc5_.upgrade, _loc5_.vip, _loc5_.periods, _loc5_.daysLeftAfterPurchase, _loc5_.year, _loc5_.month, _loc5_.day);
                this._offers.push(_loc7_);
                if (_loc5_.vip)
                {
                    _loc3_++;
                    _loc4_ = _loc7_;
                };
            };
            if (_loc3_ == 1)
            {
                _loc4_.upgradeHcPeriodToVip = true;
            };
            this._offers.sort(this.orderByPrecedence);
            for each (_loc6_ in this._offers)
            {
                this._visualization.showOffer(_loc6_);
            };
        }

        public function registerVisualization(param1:ClubBuyCatalogWidget):void
        {
            this._visualization = param1;
        }

        public function requestOffers():void
        {
            this._catalog.getHabboClubOffers();
        }

        public function showConfirmation(param1:ClubBuyOfferData, param2:int):void
        {
            this.closeConfirmation();
            this.var_2609 = new ClubBuyConfirmationDialog(this, param1, param2);
        }

        public function confirmSelection(param1:ClubBuyOfferData, param2:int):void
        {
            if (((!(this._catalog)) || (!(this._catalog.connection))))
            {
                return;
            };
            this._catalog.purchaseProduct(param2, param1.offerId);
            this.closeConfirmation();
        }

        public function closeConfirmation():void
        {
            if (this.var_2609)
            {
                this.var_2609.dispose();
                this.var_2609 = null;
            };
        }

        public function getClubType():int
        {
            var _loc1_:int = HabboClubLevelEnum.var_255;
            if (this._catalog.getPurse().hasClubLeft)
            {
                _loc1_ = ((this._catalog.getPurse().isVIP) ? HabboClubLevelEnum.var_122 : HabboClubLevelEnum.var_256);
            };
            return (_loc1_);
        }

        public function get hasClub():Boolean
        {
            if (((!(this._catalog)) || (!(this._catalog.getPurse()))))
            {
                return (false);
            };
            return (this._catalog.getPurse().clubDays > 0);
        }

        public function get windowManager():IHabboWindowManager
        {
            if (!this._catalog)
            {
                return (null);
            };
            return (this._catalog.windowManager);
        }

        public function get localization():ICoreLocalizationManager
        {
            if (!this._catalog)
            {
                return (null);
            };
            return (this._catalog.localization);
        }

        public function get assets():IAssetLibrary
        {
            if (!this._catalog)
            {
                return (null);
            };
            return (this._catalog.assets);
        }

        public function get roomEngine():IRoomEngine
        {
            if (!this._catalog)
            {
                return (null);
            };
            return (this._catalog.roomEngine);
        }

        public function getProductData(param1:String):IProductData
        {
            if (!this._catalog)
            {
                return (null);
            };
            return (this._catalog.getProductData(param1));
        }

        public function getPurse():IPurse
        {
            if (!this._catalog)
            {
                return (null);
            };
            return (this._catalog.getPurse());
        }

        private function orderByPrecedence(param1:ClubBuyOfferData, param2:ClubBuyOfferData):Number
        {
            var _loc3_:Number = param1.periods;
            var _loc4_:Number = param2.periods;
            if (_loc3_ < _loc4_)
            {
                return (-1);
            };
            if (_loc3_ > _loc4_)
            {
                return (1);
            };
            return (0);
        }

    }
}