package com.sulake.habbo.catalog.purchase
{

    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.catalog.purse.Purse;
    import com.sulake.core.localization.ILocalization;

    public class BalanceAndCost
    {

        private var _balance: String;
        private var _cost: String;

        public function BalanceAndCost(catalog: HabboCatalog, localizationManager: ICoreLocalizationManager, offer: IPurchasableOffer)
        {
            if (offer.priceInCredits > 0 && offer.priceInActivityPoints > 0)
            {
                this.setWithKey(catalog, localizationManager, offer, "catalog.purchase.confirmation.dialog.price.credits+activitypoints." + offer.activityPointType);
            }
            else if (offer.priceInCredits > 0)
            {
                this.setWithKey(catalog, localizationManager, offer, "catalog.purchase.confirmation.dialog.price.credits");
            }
            else if (offer.priceInActivityPoints > 0)
            {
                this.setWithKey(catalog, localizationManager, offer, "catalog.purchase.confirmation.dialog.price.activitypoints." + offer.activityPointType);
            }
            else
            {
                this.setWithKey(catalog, localizationManager, offer, "catalog.purchase.confirmation.dialog.price.nothing");
            }


        }

        private function setWithKey(catalog: HabboCatalog, localizationManager: ICoreLocalizationManager, offer: IPurchasableOffer, param4: String): void
        {
            var credits: String = catalog.getPurse().credits.toString();
            var pointsType: String = offer.activityPointType == Purse.ACTIVITY_POINTS_TYPE_PIXELS
                    ? "pixels"
                    : "activitypoints";
            var localization: ILocalization = localizationManager.getLocalization(param4);

            if (localization)
            {
                localizationManager.registerParameter(param4, "credits", offer.priceInCredits.toString());
                localizationManager.registerParameter(param4, pointsType, offer.priceInActivityPoints.toString());
                this._cost = localization.value;
                localizationManager.registerParameter(param4, "credits", credits);
                localizationManager.registerParameter(param4, pointsType, catalog.getPurse()
                        .getActivityPointsForType(offer.activityPointType).toString());
                this._balance = localization.value;
            }
            else
            {
                Logger.log("[CATALOG] Add pricing-model-localization for activity-point-type: " + param4);
            }

        }

        public function get balance(): String
        {
            return this._balance;
        }

        public function get cost(): String
        {
            return this._cost;
        }

    }
}
