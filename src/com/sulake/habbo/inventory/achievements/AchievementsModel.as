package com.sulake.habbo.inventory.achievements
{
    import com.sulake.habbo.inventory.IInventoryModel;
    import com.sulake.habbo.inventory.HabboInventory;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.communication.messages.outgoing.inventory.achievements.GetAchievementsComposer;
    import com.sulake.habbo.inventory.enum.InventoryCategory;
    import flash.events.Event;
    import com.sulake.habbo.inventory.events.HabboInventoryTrackingEvent;
    import com.sulake.core.window.IWindowContainer;

    public class AchievementsModel implements IInventoryModel 
    {

        private var _controller:HabboInventory;
        private var _view:AchievementsView;
        private var _assets:IAssetLibrary;
        private var _communication:IHabboCommunicationManager;
        private var _achievements:Array;
        private var _disposed:Boolean = false;

        public function AchievementsModel(param1:HabboInventory, param2:IHabboWindowManager, param3:IHabboCommunicationManager, param4:IAssetLibrary, param5:IHabboLocalizationManager, param6:ISessionDataManager)
        {
            this._controller = param1;
            this._assets = param4;
            this._communication = param3;
            this._achievements = new Array();
            this._view = new AchievementsView(this, param2, param4, param5, param6);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this._controller = null;
                if (this._view != null)
                {
                    this._view.dispose();
                };
                this._assets = null;
                this._communication = null;
                this._disposed = true;
            };
        }

        public function requestInitialization(param1:int=0):void
        {
            this._communication.getHabboMainConnection(null).send(new GetAchievementsComposer());
        }

        public function categorySwitch(param1:String):void
        {
            if (((param1 == InventoryCategory.var_253) && (this._controller.isVisible)))
            {
                this._controller.events.dispatchEvent(new Event(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_ACHIEVEMENTS));
                this._communication.getHabboMainConnection(null).send(new GetAchievementsComposer());
            };
        }

        public function setAchievements(param1:Array):void
        {
            this._achievements = param1;
            this._view.updateList();
        }

        public function getAchievements():Array
        {
            return (this._achievements);
        }

        public function getWindowContainer():IWindowContainer
        {
            return (this._view.getWindowContainer());
        }

        public function closingInventoryView():void
        {
        }

        public function subCategorySwitch(param1:String):void
        {
        }

    }
}