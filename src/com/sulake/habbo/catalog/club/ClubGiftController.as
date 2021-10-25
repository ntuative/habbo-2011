package com.sulake.habbo.catalog.club
{

    import com.sulake.habbo.catalog.viewer.widgets.ClubGiftWidget;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetClubGiftInfo;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.SelectClubGiftComposer;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.catalog.purse.IPurse;

    public class ClubGiftController
    {

        private var _widget: ClubGiftWidget;
        private var _daysUntilNextGift: int;
        private var _giftsAvailable: int;
        private var _offers: Array;
        private var _giftData: Map;
        private var _catalog: HabboCatalog;
        private var _dialog: ClubGiftConfirmationDialog;

        public function ClubGiftController(param1: HabboCatalog)
        {
            this._catalog = param1;
        }

        public function dispose(): void
        {
            this._catalog = null;

            if (this._dialog)
            {
                this._dialog.dispose();
                this._dialog = null;
            }

        }

        public function set widget(widget: ClubGiftWidget): void
        {
            this._widget = widget;

            this._catalog.connection.send(new GetClubGiftInfo());
        }

        public function get daysUntilNextGift(): int
        {
            return this._daysUntilNextGift;
        }

        public function get giftsAvailable(): int
        {
            return this._giftsAvailable;
        }

        public function setInfo(param1: int, param2: int, param3: Array, param4: Map): void
        {
            this._daysUntilNextGift = param1;
            this._giftsAvailable = param2;
            this._offers = param3;
            this._giftData = param4;
            this._widget.update();
        }

        public function selectGift(param1: Offer): void
        {
            this.closeConfirmation();

            this._dialog = new ClubGiftConfirmationDialog(this, param1);
        }

        public function confirmSelection(selection: String): void
        {
            if (!selection || !this._catalog || !this._catalog.connection)
            {
                return;
            }

            this._catalog.connection.send(new SelectClubGiftComposer(selection));
            this._giftsAvailable--;
            this._widget.update();
            this.closeConfirmation();
        }

        public function closeConfirmation(): void
        {
            if (this._dialog)
            {
                this._dialog.dispose();
                this._dialog = null;
            }

        }

        public function getOffers(): Array
        {
            return this._offers;
        }

        public function getGiftData(): Map
        {
            return this._giftData;
        }

        public function get hasClub(): Boolean
        {
            if (!this._catalog || !this._catalog.getPurse())
            {
                return false;
            }

            return this._catalog.getPurse().clubDays > 0;
        }

        public function get windowManager(): IHabboWindowManager
        {
            if (!this._catalog)
            {
                return null;
            }

            return this._catalog.windowManager;
        }

        public function get localization(): ICoreLocalizationManager
        {
            if (!this._catalog)
            {
                return null;
            }

            return this._catalog.localization;
        }

        public function get assets(): IAssetLibrary
        {
            if (!this._catalog)
            {
                return null;
            }

            return this._catalog.assets;
        }

        public function get roomEngine(): IRoomEngine
        {
            if (!this._catalog)
            {
                return null;
            }

            return this._catalog.roomEngine;
        }

        public function getProductData(param1: String): IProductData
        {
            if (!this._catalog)
            {
                return null;
            }

            return this._catalog.getProductData(param1);
        }

        public function get purse(): IPurse
        {
            if (!this._catalog)
            {
                return null;
            }

            return this._catalog.getPurse();
        }

        public function get catalog(): HabboCatalog
        {
            return this._catalog;
        }

    }
}
