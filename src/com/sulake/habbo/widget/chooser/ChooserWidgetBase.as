package com.sulake.habbo.widget.chooser
{
    import com.sulake.habbo.widget.RoomWidgetBase;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.widget.messages.RoomWidgetRoomObjectMessage;

    public class ChooserWidgetBase extends RoomWidgetBase 
    {

        public function ChooserWidgetBase(param1:IHabboWindowManager, param2:IAssetLibrary=null, param3:IHabboLocalizationManager=null)
        {
            super(param1, param2, param3);
        }

        public function choose(param1:int, param2:int):void
        {
            var _loc3_:RoomWidgetRoomObjectMessage = new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.var_1265, param1, param2);
            messageListener.processWidgetMessage(_loc3_);
        }

    }
}