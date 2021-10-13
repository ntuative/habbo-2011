package com.sulake.habbo.widget
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDHabboInventory;
    import com.sulake.iid.IIDHabboSoundManager;
    import com.sulake.iid.IIDHabboNavigator;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.widget.roomchat.RoomChatWidget;
    import com.sulake.habbo.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.widget.chatinput.RoomChatInputWidget;
    import com.sulake.habbo.widget.chatinput.RoomChatInputWidgetOld;
    import com.sulake.habbo.widget.infostand.InfostandWidget;
    import com.sulake.habbo.widget.memenu.MeMenuWidget;
    import com.sulake.habbo.widget.furniture.placeholder.PlaceholderWidget;
    import com.sulake.habbo.widget.furniture.credit.CreditFurniWidget;
    import com.sulake.habbo.widget.furniture.stickie.StickieFurniWidget;
    import com.sulake.habbo.widget.furniture.present.PresentFurniWidget;
    import com.sulake.habbo.widget.furniture.trophy.TrophyFurniWidget;
    import com.sulake.habbo.widget.furniture.teaser.TeaserFurniWidget;
    import com.sulake.habbo.widget.furniture.ecotronbox.EcotronBoxFurniWidget;
    import com.sulake.habbo.widget.furniture.petpackage.PetPackageFurniWidget;
    import com.sulake.habbo.widget.doorbell.DoorbellWidget;
    import com.sulake.habbo.widget.loadingbar.LoadingBarWidget;
    import com.sulake.habbo.widget.roomqueue.RoomQueueWidget;
    import com.sulake.habbo.widget.poll.VoteWidget;
    import com.sulake.habbo.widget.poll.PollWidget;
    import com.sulake.habbo.widget.chooser.UserChooserWidget;
    import com.sulake.habbo.widget.chooser.FurniChooserWidget;
    import com.sulake.habbo.widget.furniture.dimmer.DimmerFurniWidget;
    import com.sulake.habbo.widget.friendrequest.FriendRequestWidget;
    import com.sulake.habbo.widget.furniture.clothingchange.ClothingChangeFurnitureWidget;
    import com.sulake.habbo.widget.notification.UserNotificationWidget;
    import com.sulake.habbo.widget.purse.PurseWidget;
    import com.sulake.habbo.widget.avatarinfo.AvatarInfoWidget;
    import com.sulake.habbo.widget.furniture.welcomegift.WelcomeGiftWidget;
    import com.sulake.habbo.widget.playlisteditor.PlayListEditorWidget;
    import com.sulake.habbo.widget.roominfo.RoomInfoWidget;

    public class RoomWidgetFactory extends Component implements IRoomWidgetFactory 
    {

        private var _windowManager:IHabboWindowManager;
        private var var_4965:IAssetLibrary;
        private var var_1364:IHabboLocalizationManager;
        private var var_2868:IHabboConfigurationManager;
        private var _catalog:IHabboCatalog;
        private var _inventory:IHabboInventory;
        private var _soundManager:IHabboSoundManager;
        private var _navigator:IHabboNavigator;
        private var var_4966:int = 0;

        public function RoomWidgetFactory(param1:IContext, param2:uint=0, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
            this.var_4965 = param1.root.assets;
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onHabboConfigurationReady);
            queueInterface(new IIDHabboCatalog(), this.onCatalogReady);
            queueInterface(new IIDHabboInventory(), this.onInventoryReady);
            queueInterface(new IIDHabboSoundManager(), this.onSoundManagerReady);
            queueInterface(new IIDHabboNavigator(), this.onNavigatorReady);
        }

        override public function dispose():void
        {
            if (this._windowManager)
            {
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            };
            if (this.var_1364)
            {
                this.var_1364.release(new IIDHabboLocalizationManager());
                this.var_1364 = null;
            };
            if (this.var_2868)
            {
                this.var_2868.release(new IIDHabboConfigurationManager());
                this.var_2868 = null;
            };
            if (this._soundManager)
            {
                this._soundManager.release(new IIDHabboSoundManager());
                this._soundManager = null;
            };
            if (this._catalog)
            {
                this._catalog.release(new IIDHabboCatalog());
                this._catalog = null;
            };
            super.dispose();
        }

        private function onWindowManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            this._windowManager = (param2 as IHabboWindowManager);
        }

        private function onLocalizationReady(param1:IID=null, param2:IUnknown=null):void
        {
            this.var_1364 = (param2 as IHabboLocalizationManager);
        }

        private function onHabboConfigurationReady(param1:IID=null, param2:IUnknown=null):void
        {
            this.var_2868 = (param2 as IHabboConfigurationManager);
        }

        private function onCatalogReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this._catalog = (param2 as IHabboCatalog);
        }

        private function onInventoryReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this._inventory = (param2 as IHabboInventory);
        }

        private function onSoundManagerReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this._soundManager = (param2 as IHabboSoundManager);
        }

        private function onNavigatorReady(param1:IID=null, param2:IUnknown=null):void
        {
            if (disposed)
            {
                return;
            };
            this._navigator = (param2 as IHabboNavigator);
        }

        public function createWidget(param1:String):IRoomWidget
        {
            var _loc2_:IRoomWidget;
            if (this._windowManager == null)
            {
                return (null);
            };
            switch (param1)
            {
                case RoomWidgetEnum.var_258:
                    _loc2_ = new RoomChatWidget(this._windowManager, assets, this.var_1364, this.var_2868, this.var_4966++, this);
                    break;
                case RoomWidgetEnum.CHAT_INPUT_WIDGET:
                    if (this.var_2868.getKey("new.chat.widget.enabled") == "1")
                    {
                        _loc2_ = new RoomChatInputWidget(this._windowManager, assets, this.var_1364, this.var_2868, this);
                    }
                    else
                    {
                        _loc2_ = new RoomChatInputWidgetOld(this._windowManager, assets, this.var_1364, this.var_2868, this);
                    };
                    break;
                case RoomWidgetEnum.var_259:
                    _loc2_ = new InfostandWidget(this._windowManager, assets, this.var_1364, this.var_2868, this._catalog);
                    break;
                case RoomWidgetEnum.var_260:
                    _loc2_ = new MeMenuWidget(this._windowManager, assets, this.var_1364, events, this.var_2868);
                    break;
                case RoomWidgetEnum.var_261:
                    _loc2_ = new PlaceholderWidget(this._windowManager, assets, this.var_1364);
                    break;
                case RoomWidgetEnum.var_262:
                    _loc2_ = new CreditFurniWidget(this._windowManager, assets, this.var_1364);
                    break;
                case RoomWidgetEnum.var_263:
                    _loc2_ = new StickieFurniWidget(this._windowManager, assets);
                    break;
                case RoomWidgetEnum.var_264:
                    _loc2_ = new PresentFurniWidget(this._windowManager, assets);
                    break;
                case RoomWidgetEnum.var_265:
                    _loc2_ = new TrophyFurniWidget(this._windowManager, assets);
                    break;
                case RoomWidgetEnum.var_266:
                    _loc2_ = new TeaserFurniWidget(this._windowManager, assets, this.var_1364, this.var_2868, this._inventory);
                    break;
                case RoomWidgetEnum.var_267:
                    _loc2_ = new EcotronBoxFurniWidget(this._windowManager, assets);
                    break;
                case RoomWidgetEnum.var_268:
                    _loc2_ = new PetPackageFurniWidget(this._windowManager, assets, this.var_1364);
                    break;
                case RoomWidgetEnum.var_269:
                    _loc2_ = new DoorbellWidget(this._windowManager, assets, this.var_1364);
                    break;
                case RoomWidgetEnum.var_270:
                    _loc2_ = new LoadingBarWidget(this._windowManager, assets, this.var_1364, this.var_2868);
                    break;
                case RoomWidgetEnum.var_271:
                    _loc2_ = new RoomQueueWidget(this._windowManager, assets, this.var_1364, this.var_2868);
                    break;
                case RoomWidgetEnum.var_272:
                    _loc2_ = new VoteWidget(this._windowManager, assets, this.var_1364, this.var_2868);
                    break;
                case RoomWidgetEnum.var_273:
                    _loc2_ = new PollWidget(this._windowManager, assets, this.var_1364);
                    break;
                case RoomWidgetEnum.var_274:
                    _loc2_ = new UserChooserWidget(this._windowManager, assets, this.var_1364);
                    break;
                case RoomWidgetEnum.var_275:
                    _loc2_ = new FurniChooserWidget(this._windowManager, assets, this.var_1364);
                    break;
                case RoomWidgetEnum.var_276:
                    _loc2_ = new DimmerFurniWidget(this._windowManager, assets, this.var_1364);
                    break;
                case RoomWidgetEnum.var_277:
                    _loc2_ = new FriendRequestWidget(this._windowManager, assets, this.var_1364, this);
                    break;
                case RoomWidgetEnum.var_278:
                    _loc2_ = new ClothingChangeFurnitureWidget(this._windowManager, assets, this.var_1364);
                    break;
                case RoomWidgetEnum.var_279:
                    _loc2_ = new RoomWidgetBase(this._windowManager);
                    break;
                case RoomWidgetEnum.var_280:
                    _loc2_ = new UserNotificationWidget(this._windowManager, assets, this.var_1364);
                    break;
                case RoomWidgetEnum.var_281:
                    _loc2_ = new PurseWidget(this._windowManager, assets, this.var_1364);
                    break;
                case RoomWidgetEnum.var_282:
                    _loc2_ = new AvatarInfoWidget(this._windowManager, assets, this.var_2868, this.var_1364, this);
                    break;
                case RoomWidgetEnum.var_283:
                    _loc2_ = new WelcomeGiftWidget(this._windowManager, assets, this.var_1364);
                    break;
                case RoomWidgetEnum.var_284:
                    _loc2_ = new PlayListEditorWidget(this._windowManager, this._soundManager, assets, this.var_1364, this.var_2868, this._catalog);
                    break;
                case RoomWidgetEnum.var_285:
                    _loc2_ = new RoomInfoWidget(this);
                    break;
            };
            return (_loc2_);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }

        public function get localizations():IHabboLocalizationManager
        {
            return (this.var_1364);
        }

        public function get config():IHabboConfigurationManager
        {
            return (this.var_2868);
        }

        public function get navigator():IHabboNavigator
        {
            return (this._navigator);
        }

    }
}