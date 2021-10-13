package com.sulake.habbo.friendbar.view
{
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.friendbar.view.tabs.ITab;
    import flash.display.BitmapData;

    public interface IHabboFriendBarView extends IUnknown 
    {

        function set visible(param1:Boolean):void;
        function get visible():Boolean;
        function selectTab(param1:ITab):void;
        function selectFriendEntity(param1:int):void;
        function deSelect():void;
        function getAvatarFaceBitmap(param1:String):BitmapData;

    }
}