package com.sulake.habbo.catalog.viewer
{
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.window.IWindowContainer;

    public interface IProductContainer 
    {

        function dispose():void;
        function initProductIcon(param1:IRoomEngine):void;
        function activate():void;
        function deActivate():void;
        function get products():Array;
        function get firstProduct():IProduct;
        function set view(param1:IWindowContainer):void;
        function get view():IWindowContainer;
        function set grid(param1:IItemGrid):void;

    }
}