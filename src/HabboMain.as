package 
{
    import flash.display.Sprite;
    import com.sulake.core.runtime.ICore;
    import flash.display.DisplayObjectContainer;
    import com.sulake.habbo.tracking.HabboTracking;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import com.sulake.core.Core;
    import flash.external.ExternalInterface;
    import com.sulake.core.runtime.Component;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.runtime.events.LibraryProgressEvent;

    public class HabboMain extends Sprite 
    {

        private static const var_38:Number = 0.71;

        private var var_2288:ICore;
        private var var_5077:Boolean = false;
        private var var_4:DisplayObjectContainer;
        private var var_4613:HabboTracking;

        public function HabboMain(param1:DisplayObjectContainer)
        {
            this.var_4 = param1;
            this.var_4.addEventListener(Event.COMPLETE, this.onCompleteEvent);
            this.var_4.addEventListener(ProgressEvent.PROGRESS, this.onProgressEvent);
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            Logger.log(("Core version: " + Core.version));
        }

        private function dispose():void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            if (this.var_4)
            {
                this.var_4.removeEventListener(Event.COMPLETE, this.onCompleteEvent);
                this.var_4.removeEventListener(ProgressEvent.PROGRESS, this.onProgressEvent);
                this.var_4 = null;
            };
            if (parent)
            {
                parent.removeChild(this);
            };
        }

        private function initializeCore():void
        {
            try
            {
                this.var_2288.initialize();
                if (ExternalInterface.available)
                {
                    ExternalInterface.addCallback("unloading", this.unloading);
                };
            }
            catch(error:Error)
            {
                Habbo.trackLoginStep(Habbo.var_9);
                Core.crash(("Failed to initialize the core: " + error.message), Core.var_33, error);
            };
        }

        public function unloading():void
        {
            if (((this.var_2288) && (!(this.var_2288.disposed))))
            {
                this.var_2288.events.dispatchEvent(new Event(Event.UNLOAD));
            };
        }

        protected function onAddedToStage(event:Event=null):void
        {
            try
            {
                this.prepareCore();
            }
            catch(error:Error)
            {
                Habbo.trackLoginStep(Habbo.var_9);
                Habbo.reportCrash(("Failed to prepare the core: " + error.message), Core.var_33, error);
                Core.dispose();
            };
        }

        private function prepareCore():void
        {
            Habbo.trackLoginStep(Habbo.var_8);
            this.var_2288 = Core.instantiate(stage, Core.var_34);
            this.var_2288.events.addEventListener(Component.COMPONENT_EVENT_ERROR, this.onCoreError);
            this.var_2288.prepareComponent(CoreCommunicationFrameworkLib);
            this.var_2288.prepareComponent(HabboRoomObjectLogicLib);
            this.var_2288.prepareComponent(HabboRoomObjectVisualizationLib);
            this.var_2288.prepareComponent(RoomManagerLib);
            this.var_2288.prepareComponent(RoomSpriteRendererLib);
            this.var_2288.prepareComponent(HabboRoomSessionManagerLib);
            this.var_2288.prepareComponent(HabboAvatarRenderLib);
            this.var_2288.prepareComponent(HabboRoomWidgetLib);
            this.var_2288.prepareComponent(HabboSessionDataManagerLib);
            this.var_2288.prepareComponent(HabboTrackingLib);
            this.var_2288.prepareComponent(HabboConfigurationCom);
            this.var_2288.prepareComponent(HabboLocalizationCom);
            this.var_2288.prepareComponent(HabboWindowManagerCom);
            this.var_2288.prepareComponent(HabboCommunicationCom);
            this.var_2288.prepareComponent(HabboCommunicationDemoCom);
            this.var_2288.prepareComponent(HabboNavigatorCom);
            this.var_2288.prepareComponent(HabboFriendListCom);
            this.var_2288.prepareComponent(HabboMessengerCom);
            this.var_2288.prepareComponent(HabboInventoryCom);
            this.var_2288.prepareComponent(HabboToolbarCom);
            this.var_2288.prepareComponent(HabboCatalogCom);
            this.var_2288.prepareComponent(HabboRoomEngineCom);
            this.var_2288.prepareComponent(HabboRoomUICom);
            this.var_2288.prepareComponent(HabboAvatarEditorCom);
            this.var_2288.prepareComponent(HabboNotificationsCom);
            this.var_2288.prepareComponent(HabboHelpCom);
            this.var_2288.prepareComponent(HabboAdManagerCom);
            this.var_2288.prepareComponent(HabboModerationCom);
            this.var_2288.prepareComponent(HabboUserDefinedRoomEventsCom);
            this.var_2288.prepareComponent(HabboSoundManagerFlash10Com);
            this.var_2288.prepareComponent(HabboQuestEngineCom);
            this.var_2288.prepareComponent(HabboFriendBarCom);
            this.var_4613 = HabboTracking.getInstance();
            var _loc1_:AssetLoaderStruct = this.var_2288.assets.loadAssetFromFile("config.xml", new URLRequest("config_habbo.xml"));
            if (_loc1_.assetLoader.ready)
            {
                this.setupCoreConfigFromLoader(_loc1_);
            }
            else
            {
                _loc1_.addEventListener(AssetLoaderEvent.var_35, this.configLoadedHandler);
                _loc1_.addEventListener(AssetLoaderEvent.var_36, this.configLoadedHandler);
            };
        }

        private function configLoadedHandler(param1:AssetLoaderEvent):void
        {
            var _loc2_:AssetLoaderStruct;
            _loc2_ = (param1.target as AssetLoaderStruct);
            _loc2_.removeEventListener(AssetLoaderEvent.var_35, this.configLoadedHandler);
            _loc2_.removeEventListener(AssetLoaderEvent.var_36, this.configLoadedHandler);
            if (param1.type == AssetLoaderEvent.var_35)
            {
                this.setupCoreConfigFromLoader(_loc2_);
            }
            else
            {
                Habbo.reportCrash((("Failed to download external configuration document " + _loc2_.assetLoader.url) + "!"), Core.var_37, null);
            };
        }

        private function setupCoreConfigFromLoader(param1:AssetLoaderStruct):void
        {
            var _loc2_:XmlAsset = (this.var_2288.assets.getAssetByName(param1.assetName) as XmlAsset);
            if (((!(_loc2_)) || (!(_loc2_.content))))
            {
                Habbo.reportCrash("Download external configuration document is null!", Core.var_37, null);
            };
            if (this.var_2288)
            {
                this.var_2288.readConfigDocument(XML(_loc2_.content), this.var_4);
            }
            else
            {
                Habbo.reportCrash("Core vanished while downloading config document!", Core.var_37, null);
            };
        }

        private function onEnterFrame(param1:Event):void
        {
            var _loc2_:Sprite;
            if (this.var_4)
            {
                _loc2_ = (this.var_4.getChildByName("background") as Sprite);
                if (_loc2_)
                {
                    _loc2_.alpha = (_loc2_.alpha - 0.01);
                    if (_loc2_.alpha <= 0)
                    {
                    };
                };
                if (this.var_5077)
                {
                    if (this.var_4.alpha <= 0)
                    {
                        this.dispose();
                        this.var_5077 = false;
                    }
                    else
                    {
                        this.var_4.alpha = (this.var_4.alpha - 0.1);
                    };
                };
            };
        }

        private function onCompleteEvent(param1:Event):void
        {
            this.updateLoadingBar(this.var_4, 1);
            this.initializeCore();
            this.var_5077 = true;
        }

        private function onProgressEvent(param1:ProgressEvent):void
        {
            var _loc2_:Number;
            var _loc3_:Sprite;
            var _loc4_:LibraryProgressEvent;
            if (this.var_4)
            {
                _loc2_ = (param1.bytesLoaded / param1.bytesTotal);
                this.updateLoadingBar(this.var_4, _loc2_);
                _loc3_ = (this.var_4.getChildByName("background") as Sprite);
                if (_loc3_)
                {
                    _loc3_.alpha = Math.min((1 - _loc2_), _loc3_.alpha);
                };
                if ((param1 is LibraryProgressEvent))
                {
                    _loc4_ = (param1 as LibraryProgressEvent);
                    if (((_loc4_.fileName == "hh_human_fx.swf") || (_loc4_.fileName == "hh_human_body.swf")))
                    {
                        if (((this.var_4613) && (!(this.var_4613.disposed))))
                        {
                            this.var_4613.track("libraryLoaded", _loc4_.fileName, _loc4_.elapsedTime);
                        };
                    };
                };
            };
        }

        private function updateLoadingBar(param1:DisplayObjectContainer, param2:Number):void
        {
            var _loc9_:int;
            var _loc10_:int;
            var _loc3_:* = 200;
            var _loc4_:int = 20;
            var _loc5_:int = 1;
            var _loc6_:int = 1;
            var _loc7_:Sprite = (param1.getChildByName(Habbo.var_19) as Sprite);
            var _loc8_:Sprite = (_loc7_.getChildByName(Habbo.var_20) as Sprite);
            var _loc11_:int = (this.var_2288.getNumberOfFilesPending() + this.var_2288.getNumberOfFilesLoaded());
            var _loc12_:Number = ((1 - var_38) + ((this.var_2288.getNumberOfFilesLoaded() / _loc11_) * var_38));
            _loc8_.x = (_loc5_ + _loc6_);
            _loc8_.y = (_loc5_ + _loc6_);
            _loc8_.graphics.clear();
            _loc9_ = ((_loc4_ - (_loc5_ * 2)) - (_loc6_ * 2));
            _loc10_ = (((_loc3_ - (_loc5_ * 2)) - (_loc6_ * 2)) * _loc12_);
            _loc8_.graphics.beginFill(12241619);
            _loc8_.graphics.drawRect(0, 0, _loc10_, (_loc9_ / 2));
            _loc8_.graphics.endFill();
            _loc8_.graphics.beginFill(9216429);
            _loc8_.graphics.drawRect(0, (_loc9_ / 2), _loc10_, ((_loc9_ / 2) + 1));
            _loc8_.graphics.endFill();
        }

        public function onCoreError(param1:Event):void
        {
            Habbo.trackLoginStep(Habbo.var_9);
        }

    }
}