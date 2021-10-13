package com.sulake.habbo.catalog
{
    import com.sulake.habbo.catalog.viewer.ICatalogPage;
    import com.sulake.habbo.catalog.viewer.IProductContainer;

    public interface IPurchasableOffer 
    {

        function get offerId():int;
        function get priceInActivityPoints():int;
        function get activityPointType():int;
        function get priceInCredits():int;
        function get page():ICatalogPage;
        function get priceType():String;
        function get productContainer():IProductContainer;
        function get localizationId():String;
        function get extraParameter():String;
        function set extraParameter(param1:String):void;

    }
}