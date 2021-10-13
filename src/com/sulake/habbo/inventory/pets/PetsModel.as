package com.sulake.habbo.inventory.pets
{
    import com.sulake.habbo.inventory.IInventoryModel;
    import com.sulake.habbo.inventory.HabboInventory;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.communication.messages.outgoing.inventory.pets.GetPetInventoryComposer;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetData;
    import com.sulake.habbo.inventory.enum.InventoryCategory;
    import flash.events.Event;
    import com.sulake.habbo.inventory.events.HabboInventoryTrackingEvent;
    import com.sulake.habbo.inventory.furni.FurniModel;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.habbo.room.object.RoomObjectTypeEnum;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.PlacePetMessageComposer;
    import com.sulake.habbo.session.IRoomSession;

    public class PetsModel implements IInventoryModel 
    {

        private var _controller:HabboInventory;
        private var _view:PetsView;
        private var _assets:IAssetLibrary;
        private var _communication:IHabboCommunicationManager;
        private var _roomEngine:IRoomEngine;
        private var _catalog:IHabboCatalog;
        private var var_3204:Map;
        private var var_3580:Boolean = false;
        private var _disposed:Boolean = false;
        private var var_3552:Boolean;

        public function PetsModel(param1:HabboInventory, param2:IHabboWindowManager, param3:IHabboCommunicationManager, param4:IAssetLibrary, param5:IHabboLocalizationManager, param6:IRoomEngine, param7:IAvatarRenderManager, param8:IHabboCatalog)
        {
            this._controller = param1;
            this._assets = param4;
            this._communication = param3;
            this._roomEngine = param6;
            this._roomEngine.events.addEventListener(RoomEngineObjectEvent.var_141, this.onObjectPlaced);
            this._catalog = param8;
            this.var_3204 = new Map();
            this._view = new PetsView(this, param2, param4, param5, param6, param7);
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

        public function isListInited():Boolean
        {
            return (this.var_3552);
        }

        public function setListInitialized():void
        {
            this.var_3552 = true;
            this._view.setViewToState();
        }

        public function requestPetInventory():void
        {
            if (this._communication == null)
            {
                return;
            };
            var _loc1_:IConnection = this._communication.getHabboMainConnection(null);
            if (_loc1_ == null)
            {
                return;
            };
            _loc1_.send(new GetPetInventoryComposer());
        }

        public function requestCatalogOpen():void
        {
            this._catalog.openCatalog();
        }

        public function get pets():Map
        {
            return (this.var_3204);
        }

        public function addPet(param1:PetData):void
        {
            if (this.var_3204.add(param1.id, param1))
            {
                this._view.addPet(param1);
            };
            this._view.setViewToState();
        }

        public function removePet(param1:int):void
        {
            this.var_3204.remove(param1);
            this._view.removePet(param1);
            this._view.setViewToState();
        }

        public function requestInitialization(param1:int=0):void
        {
            this.requestPetInventory();
        }

        public function categorySwitch(param1:String):void
        {
            if (((param1 == InventoryCategory.var_134) && (this._controller.isVisible)))
            {
                this._controller.events.dispatchEvent(new Event(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_PETS));
            };
        }

        public function switchCategory(param1:String):void
        {
            var _loc2_:FurniModel = this._controller.furniModel;
            if (_loc2_ != null)
            {
                _loc2_.switchCategory(param1);
                this._controller.toggleInventoryPage(InventoryCategory.var_133);
            };
        }

        public function refreshViews():void
        {
            this._view.update();
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

        public function placePetToRoom(param1:int, param2:Boolean=false):void
        {
            var _loc3_:PetData = this.getPetById(param1);
            if (_loc3_ == null)
            {
                return;
            };
            if (this._controller.roomSession.isRoomOwner)
            {
                this.var_3580 = this._roomEngine.var_485(_loc3_.id, RoomObjectCategoryEnum.var_71, RoomObjectTypeEnum.var_1234, _loc3_.figureString);
                this._controller.closeView();
                return;
            };
            if (!this._controller.roomSession.arePetsAllowed)
            {
                return;
            };
            if (!param2)
            {
                this._communication.getHabboMainConnection(null).send(new PlacePetMessageComposer(_loc3_.id, 0, 0));
            };
        }

        public function updateView():void
        {
            if (this._view == null)
            {
                return;
            };
            this._view.update();
        }

        private function getPetById(param1:int):PetData
        {
            var _loc2_:PetData;
            for each (_loc2_ in this.var_3204)
            {
                if (_loc2_.id == param1)
                {
                    return (_loc2_);
                };
            };
            return (null);
        }

        public function onObjectPlaced(param1:Event):void
        {
            if (param1 == null)
            {
                return;
            };
            if (((this.var_3580) && (param1.type == RoomEngineObjectEvent.var_141)))
            {
                this._controller.showView();
                this.var_3580 = false;
            };
        }

        public function get roomSession():IRoomSession
        {
            return (this._controller.roomSession);
        }

        public function updatePetsAllowed():void
        {
            this._view.update();
        }

    }
}