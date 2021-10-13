package com.sulake.habbo.inventory
{
    import com.sulake.core.runtime.IUnknown;
    import flash.events.IEventDispatcher;

    public interface IHabboInventory extends IUnknown 
    {

        function get events():IEventDispatcher;
        function get clubDays():int;
        function get clubPeriods():int;
        function get clubPastPeriods():int;
        function get clubLevel():int;
        function get clubHasEverBeenMember():Boolean;
        function get tradingActive():Boolean;
        function get hasRoomSession():Boolean;
        function getActivatedAvatarEffects():Array;
        function getAvatarEffects():Array;
        function setEffectSelected(param1:int):void;
        function setEffectDeselected(param1:int):void;
        function deselectAllEffects():void;
        function setupTrading(param1:int, param2:String):void;
        function toggleInventoryPage(param1:String):void;
        function toggleInventorySubPage(param1:String):void;
        function setupRecycler(param1:Boolean):void;
        function requestSelectedFurniToRecycler():int;
        function returnInventoryFurniFromRecycler(param1:int):Boolean;

    }
}