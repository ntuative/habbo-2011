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

        private var _controller: HabboInventory;
        private var _view: PetsView;
        private var _assets: IAssetLibrary;
        private var _communication: IHabboCommunicationManager;
        private var _roomEngine: IRoomEngine;
        private var _catalog: IHabboCatalog;
        private var _pets: Map;
        private var _isPetPlaced: Boolean = false;
        private var _disposed: Boolean = false;
        private var _listInitialized: Boolean;

        public function PetsModel(controller: HabboInventory, windowManager: IHabboWindowManager, communication: IHabboCommunicationManager, assets: IAssetLibrary, localization: IHabboLocalizationManager, roomEngine: IRoomEngine, avatarRenderManager: IAvatarRenderManager, catalog: IHabboCatalog)
        {
            this._controller = controller;
            this._assets = assets;
            this._communication = communication;
            this._roomEngine = roomEngine;
            this._roomEngine.events.addEventListener(RoomEngineObjectEvent.REOB_OBJECT_PLACED, this.onObjectPlaced);
            this._catalog = catalog;
            this._pets = new Map();
            this._view = new PetsView(this, windowManager, assets, localization, roomEngine, avatarRenderManager);
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function dispose(): void
        {
            if (!this._disposed)
            {
                this._controller = null;

                if (this._view != null)
                {
                    this._view.dispose();
                }

                this._assets = null;
                this._communication = null;
                this._disposed = true;
            }

        }

        public function isListInited(): Boolean
        {
            return this._listInitialized;
        }

        public function setListInitialized(): void
        {
            this._listInitialized = true;
            this._view.setViewToState();
        }

        public function requestPetInventory(): void
        {
            if (this._communication == null)
            {
                return;
            }

            var connection: IConnection = this._communication.getHabboMainConnection(null);
            
            if (connection == null)
            {
                return;
            }

            connection.send(new GetPetInventoryComposer());
        }

        public function requestCatalogOpen(): void
        {
            this._catalog.openCatalog();
        }

        public function get pets(): Map
        {
            return this._pets;
        }

        public function addPet(pet: PetData): void
        {
            if (this._pets.add(pet.id, pet))
            {
                this._view.addPet(pet);
            }

            this._view.setViewToState();
        }

        public function removePet(id: int): void
        {
            this._pets.remove(id);
            this._view.removePet(id);
            this._view.setViewToState();
        }

        public function requestInitialization(timeout: int = 0): void
        {
            this.requestPetInventory();
        }

        public function categorySwitch(categoryId: String): void
        {
            if (categoryId == InventoryCategory.PETS && this._controller.isVisible)
            {
                this._controller.events.dispatchEvent(new Event(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_PETS));
            }

        }

        public function switchCategory(categoryId: String): void
        {
            var model: FurniModel = this._controller.furniModel;
            
            if (model != null)
            {
                model.switchCategory(categoryId);
                this._controller.toggleInventoryPage(InventoryCategory.FURNI);
            }

        }

        public function refreshViews(): void
        {
            this._view.update();
        }

        public function getWindowContainer(): IWindowContainer
        {
            return this._view.getWindowContainer();
        }

        public function closingInventoryView(): void
        {
        }

        public function subCategorySwitch(param1: String): void
        {
        }

        public function placePetToRoom(id: int, noUpdate: Boolean = false): void
        {
            var pet: PetData = this.getPetById(id);
            
            if (pet == null)
            {
                return;
            }

            if (this._controller.roomSession.isRoomOwner)
            {
                this._isPetPlaced = this._roomEngine.initializeRoomObjectInsert(pet.id, RoomObjectCategoryEnum.var_71, RoomObjectTypeEnum.var_1234, pet.figureString);
                this._controller.closeView();

                return;
            }

            if (!this._controller.roomSession.arePetsAllowed)
            {
                return;
            }

            if (!noUpdate)
            {
                this._communication.getHabboMainConnection(null).send(new PlacePetMessageComposer(pet.id, 0, 0));
            }

        }

        public function updateView(): void
        {
            if (this._view == null)
            {
                return;
            }

            this._view.update();
        }

        private function getPetById(param1: int): PetData
        {
            var _loc2_: PetData;
            for each (_loc2_ in this._pets)
            {
                if (_loc2_.id == param1)
                {
                    return _loc2_;
                }

            }

            return null;
        }

        public function onObjectPlaced(param1: Event): void
        {
            if (param1 == null)
            {
                return;
            }

            if (this._isPetPlaced && param1.type == RoomEngineObjectEvent.REOB_OBJECT_PLACED)
            {
                this._controller.showView();
                this._isPetPlaced = false;
            }

        }

        public function get roomSession(): IRoomSession
        {
            return this._controller.roomSession;
        }

        public function updatePetsAllowed(): void
        {
            this._view.update();
        }

    }
}
