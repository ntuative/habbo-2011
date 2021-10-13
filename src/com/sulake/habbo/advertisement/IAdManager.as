package com.sulake.habbo.advertisement
{
    import com.sulake.core.runtime.IUnknown;
    import flash.events.IEventDispatcher;

    public interface IAdManager extends IUnknown 
    {

        function get events():IEventDispatcher;
        function showInterstitial():Boolean;
        function showRoomAd():void;
        function loadRoomAdImage(param1:int, param2:int, param3:String, param4:String):void;

    }
}