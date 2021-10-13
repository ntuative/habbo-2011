package com.sulake.habbo.widget.infostand
{
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IBorderWindow;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.tracking.HabboTracking;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindowContainer;
    import flash.geom.Point;
    import com.sulake.habbo.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetUserActionMessage;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.core.window.components.IButtonWindow;

    public class InfoStandPetView 
    {

        private const var_4789:int = 152;
        private const var_4790:int = 16;
        private const var_4791:int = 4;
        private const var_4792:uint = 0xDADADA;
        private const var_4793:uint = 0x3A3A3A;
        private const var_4794:uint = 2085362;
        private const var_4795:uint = 39616;
        private const var_4796:uint = 10513106;
        private const var_4797:uint = 8734654;
        private const var_4798:uint = 9094430;
        private const var_4799:uint = 0x5E9D00;
        private const var_4800:String = "happiness";
        private const var_4801:String = "experience";
        private const var_4802:String = "energy";

        private var _catalog:IHabboCatalog;
        private var _habboTracking:IHabboTracking;
        private var _widget:InfostandWidget;
        private var _window:IItemListWindow;
        private var var_4785:IBorderWindow;
        private var _buttons:IItemListWindow;
        private var var_4783:IItemListWindow;
        private var var_4787:PetCommandTool;
        private var _petData:Map;
        private var var_4788:int;

        public function InfoStandPetView(param1:InfostandWidget, param2:String, param3:IHabboCatalog)
        {
            this._widget = param1;
            this._catalog = param3;
            this._habboTracking = HabboTracking.getInstance();
            this.createWindow(param2);
            this._petData = new Map();
        }

        public function dispose():void
        {
            this._widget = null;
            if (this._window)
            {
                this._window.dispose();
            };
            this._window = null;
            if (this.var_4787)
            {
                this.var_4787.dispose();
            };
            this.var_4787 = null;
        }

        public function get window():IItemListWindow
        {
            return (this._window);
        }

        private function updateWindow():void
        {
            if ((((this.var_4783 == null) || (this.var_4785 == null)) || (this._buttons == null)))
            {
                return;
            };
            this._buttons.width = this._buttons.scrollableRegion.width;
            this._buttons.visible = (this._buttons.width > 0);
            this.var_4783.height = this.var_4783.scrollableRegion.height;
            this.var_4785.height = (this.var_4783.height + 20);
            this._window.width = Math.max(this.var_4785.width, this._buttons.width);
            this._window.height = this._window.scrollableRegion.height;
            if (this.var_4785.width < this._buttons.width)
            {
                this.var_4785.x = (this._window.width - this.var_4785.width);
                this._buttons.x = 0;
            }
            else
            {
                this._buttons.x = (this._window.width - this._buttons.width);
                this.var_4785.x = 0;
            };
            this._widget.refreshContainer();
        }

        public function update(param1:InfoStandPetData):void
        {
            this.name = param1.name;
            this.image = param1.image;
            this.ownerName = param1.ownerName;
            this.raceText = this._widget.localizations.getKey(this.getRaceLocalizationKey(param1.type, param1.race));
            this.petRespect = param1.petRespect;
            this.ageText = param1.age;
            this.setLevelText(param1.level, param1.levelMax);
            this.updateStateElement(this.var_4800, param1.nutrition, param1.nutritionMax, this.var_4795, this.var_4794);
            this.updateStateElement(this.var_4801, param1.experience, param1.experienceMax, this.var_4797, this.var_4796);
            this.updateStateElement(this.var_4802, param1.energy, param1.energyMax, this.var_4799, this.var_4798);
            this.showButton("pick", param1.isOwnPet);
            this.showButton("train", param1.isOwnPet);
            this.showButton("kick", param1.canOwnerBeKicked);
            this.updateRespectButton();
            this.updateWindow();
            this.var_4788 = param1.id;
            this._petData.remove(param1.id);
            this._petData.add(param1.id, param1);
            if ((((this.var_4787) && (this.var_4787.isVisible())) && (param1.isOwnPet)))
            {
                this.var_4787.showCommandToolForPet(param1.id, param1.name, param1.image);
            };
        }

        public function getCurrentPetId():int
        {
            return (this.var_4788);
        }

        public function updateEnabledTrainingCommands(param1:int, param2:CommandConfiguration):void
        {
            if (this.var_4787 == null)
            {
                return;
            };
            this.var_4787.setEnabledCommands(param1, param2);
        }

        private function getRaceLocalizationKey(param1:int, param2:int):String
        {
            return ((("pet.breed." + param1) + ".") + param2);
        }

        private function createPercentageBar(param1:int, param2:int, param3:uint, param4:uint):BitmapData
        {
            param2 = Math.max(param2, 1);
            param1 = Math.max(param1, 0);
            if (param1 > param2)
            {
                param1 = param2;
            };
            var _loc5_:Number = (param1 / param2);
            var _loc6_:int = 1;
            var _loc7_:BitmapData = new BitmapData(this.var_4789, this.var_4790, false);
            _loc7_.fillRect(new Rectangle(0, 0, _loc7_.width, _loc7_.height), this.var_4792);
            var _loc8_:Rectangle = new Rectangle(_loc6_, _loc6_, (_loc7_.width - (_loc6_ * 2)), (_loc7_.height - (_loc6_ * 2)));
            _loc7_.fillRect(_loc8_, this.var_4793);
            var _loc9_:Rectangle = new Rectangle(_loc6_, (_loc6_ + this.var_4791), (_loc7_.width - (_loc6_ * 2)), ((_loc7_.height - (_loc6_ * 2)) - this.var_4791));
            _loc9_.width = (_loc5_ * _loc9_.width);
            _loc7_.fillRect(_loc9_, param3);
            var _loc10_:Rectangle = new Rectangle(_loc6_, _loc6_, (_loc7_.width - (_loc6_ * 2)), this.var_4791);
            _loc10_.width = (_loc5_ * _loc10_.width);
            _loc7_.fillRect(_loc10_, param4);
            return (_loc7_);
        }

        private function openTrainView():void
        {
            if (this.var_4787 == null)
            {
                this.var_4787 = new PetCommandTool(this._widget);
            };
            var _loc1_:InfoStandPetData = (this._petData.getValue(this.var_4788) as InfoStandPetData);
            if (_loc1_ != null)
            {
                this.var_4787.showWindow(true);
                this.var_4787.showCommandToolForPet(_loc1_.id, _loc1_.name, _loc1_.image);
            };
        }

        private function createWindow(param1:String):void
        {
            var _loc4_:int;
            var _loc5_:IWindow;
            var _loc11_:IWindow;
            var _loc12_:IRegionWindow;
            var _loc13_:BitmapDataAsset;
            var _loc14_:BitmapData;
            var _loc15_:BitmapDataAsset;
            var _loc16_:BitmapData;
            var _loc17_:BitmapDataAsset;
            var _loc18_:BitmapData;
            var _loc19_:BitmapDataAsset;
            var _loc20_:BitmapData;
            var _loc2_:XmlAsset = (this._widget.assets.getAssetByName("pet_view") as XmlAsset);
            this._window = (this._widget.windowManager.buildFromXML((_loc2_.content as XML)) as IItemListWindow);
            if (this._window == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
            this.var_4785 = (this._window.getListItemByName("info_border") as IBorderWindow);
            if (this.var_4785 != null)
            {
                this.var_4783 = (this.var_4785.findChildByName("infostand_element_list") as IItemListWindow);
            };
            this._window.name = param1;
            this._widget.mainContainer.addChild(this._window);
            var _loc3_:IWindow = this.var_4785.findChildByTag("close");
            if (_loc3_ != null)
            {
                _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClose);
            };
            this._buttons = (this._window.getListItemByName("button_list") as IItemListWindow);
            if (this._buttons == null)
            {
                return;
            };
            _loc4_ = 0;
            while (_loc4_ < this._buttons.numListItems)
            {
                _loc12_ = (this._buttons.getListItemAt(_loc4_) as IRegionWindow);
                if (_loc12_ != null)
                {
                    _loc5_ = _loc12_.getChildAt(0);
                    _loc5_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClicked);
                };
                _loc4_++;
            };
            var _loc6_:IBitmapWrapperWindow = (this.var_4785.findChildByName("petrespect_icon") as IBitmapWrapperWindow);
            if (_loc6_ != null)
            {
                _loc13_ = (this._widget.assets.getAssetByName("icon_petrespect") as BitmapDataAsset);
                _loc14_ = (_loc13_.content as BitmapData);
                _loc6_.bitmap = _loc14_.clone();
            };
            var _loc7_:IBitmapWrapperWindow = (this.var_4785.findChildByName("status_happiness_icon") as IBitmapWrapperWindow);
            if (_loc7_ != null)
            {
                _loc15_ = (this._widget.assets.getAssetByName("icon_pet_happiness") as BitmapDataAsset);
                _loc16_ = (_loc15_.content as BitmapData);
                _loc7_.bitmap = _loc16_.clone();
            };
            var _loc8_:IBitmapWrapperWindow = (this.var_4785.findChildByName("status_experience_icon") as IBitmapWrapperWindow);
            if (_loc8_ != null)
            {
                _loc17_ = (this._widget.assets.getAssetByName("icon_pet_experience") as BitmapDataAsset);
                _loc18_ = (_loc17_.content as BitmapData);
                _loc8_.bitmap = _loc18_.clone();
            };
            var _loc9_:IBitmapWrapperWindow = (this.var_4785.findChildByName("status_energy_icon") as IBitmapWrapperWindow);
            if (_loc9_ != null)
            {
                _loc19_ = (this._widget.assets.getAssetByName("icon_pet_energy") as BitmapDataAsset);
                _loc20_ = (_loc19_.content as BitmapData);
                _loc9_.bitmap = _loc20_.clone();
            };
            var _loc10_:Array = [];
            this._buttons.groupListItemsWithTag("CMD_BUTTON", _loc10_, true);
            for each (_loc11_ in _loc10_)
            {
                if (_loc11_.parent)
                {
                    _loc11_.parent.width = _loc11_.width;
                };
                _loc11_.addEventListener(WindowEvent.var_573, this.onButtonResized);
            };
        }

        private function set name(param1:String):void
        {
            if (this.var_4783 == null)
            {
                return;
            };
            var _loc2_:ITextWindow = (this.var_4783.getListItemByName("name_text") as ITextWindow);
            if (_loc2_ == null)
            {
                return;
            };
            _loc2_.text = param1;
            _loc2_.visible = true;
        }

        private function set image(param1:BitmapData):void
        {
            if (this.var_4783 == null)
            {
                return;
            };
            if (param1 == null)
            {
                return;
            };
            var _loc2_:IWindowContainer = (this.var_4783.getListItemByName("image_container") as IWindowContainer);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:IBitmapWrapperWindow = (_loc2_.findChildByName("avatar_image") as IBitmapWrapperWindow);
            if (_loc3_ == null)
            {
                return;
            };
            var _loc4_:BitmapData = new BitmapData(_loc3_.width, _loc3_.height, true, 0);
            var _loc5_:Point = new Point(0, 0);
            _loc5_.x = Math.round(((_loc3_.width - param1.width) / 2));
            _loc5_.y = Math.round(((_loc3_.height - param1.height) / 2));
            _loc4_.copyPixels(param1, param1.rect, _loc5_);
            _loc3_.bitmap = _loc4_;
            _loc3_.invalidate();
            this.updateWindow();
        }

        private function setLevelText(param1:int, param2:int):void
        {
            if (this.var_4783 == null)
            {
                return;
            };
            var _loc3_:IWindowContainer = (this.var_4783.getListItemByName("level_container") as IWindowContainer);
            if (_loc3_ == null)
            {
                return;
            };
            var _loc4_:ITextWindow = (_loc3_.findChildByName("level_text") as ITextWindow);
            if (_loc4_ == null)
            {
                return;
            };
            this._widget.localizations.registerParameter("pet.level", "level", param1.toString());
            this._widget.localizations.registerParameter("pet.level", "maxlevel", param2.toString());
            this.updateWindow();
        }

        private function set ownerName(param1:String):void
        {
            this._widget.localizations.registerParameter("infostand.text.petowner", "name", param1);
            this.updateWindow();
        }

        private function set raceText(param1:String):void
        {
            if (this.var_4783 == null)
            {
                return;
            };
            var _loc2_:ITextWindow = (this.var_4783.getListItemByName("race_text") as ITextWindow);
            if (_loc2_ == null)
            {
                return;
            };
            _loc2_.text = param1;
            this.updateWindow();
        }

        private function set ageText(param1:int):void
        {
            if (this.var_4783 == null)
            {
                return;
            };
            var _loc2_:ITextWindow = (this.var_4783.getListItemByName("age_text") as ITextWindow);
            if (_loc2_ == null)
            {
                return;
            };
            this._widget.localizations.registerParameter("pet.age", "age", param1.toString());
            this.updateWindow();
        }

        private function set petRespect(param1:int):void
        {
            this._widget.localizations.registerParameter("infostand.text.petrespect", "count", param1.toString());
            if (this.var_4783 == null)
            {
                return;
            };
            var _loc2_:IWindowContainer = (this.var_4783.getListItemByName("petrespect_container") as IWindowContainer);
            var _loc3_:ITextWindow = (_loc2_.findChildByName("petrespect_text") as ITextWindow);
            var _loc4_:IBitmapWrapperWindow = (_loc2_.findChildByName("petrespect_icon") as IBitmapWrapperWindow);
            _loc4_.x = ((_loc3_.x + _loc3_.width) + 2);
            this.updateWindow();
        }

        private function updateStateElement(param1:String, param2:int, param3:int, param4:uint, param5:uint):void
        {
            var _loc9_:BitmapData;
            if (this.var_4783 == null)
            {
                return;
            };
            var _loc6_:IWindowContainer = (this.var_4783.getListItemByName("status_container") as IWindowContainer);
            if (_loc6_ == null)
            {
                return;
            };
            var _loc7_:ITextWindow = (_loc6_.findChildByName((("status_" + param1) + "_value_text")) as ITextWindow);
            if (_loc7_ != null)
            {
                _loc7_.text = ((param2 + "/") + param3);
            };
            var _loc8_:IBitmapWrapperWindow = (_loc6_.findChildByName((("status_" + param1) + "_bitmap")) as IBitmapWrapperWindow);
            if (_loc8_ != null)
            {
                _loc9_ = this.createPercentageBar(param2, param3, param4, param5);
                if (_loc9_ != null)
                {
                    _loc8_.bitmap = _loc9_;
                    _loc8_.width = _loc9_.width;
                    _loc8_.height = _loc9_.height;
                    _loc8_.invalidate();
                };
            };
            this.updateWindow();
        }

        protected function onButtonClicked(param1:WindowMouseEvent):void
        {
            var _loc2_:RoomWidgetMessage;
            var _loc3_:String;
            var _loc5_:int;
            var _loc4_:IWindow = (param1.target as IWindow);
            switch (_loc4_.name)
            {
                case "btn_pick":
                    _loc3_ = RoomWidgetUserActionMessage.var_1837;
                    if (((this.var_4787) && (this.var_4787.getPetId() == this.var_4788)))
                    {
                        this.var_4787.showWindow(false);
                    };
                    break;
                case "btn_train":
                    this.openTrainView();
                    break;
                case "btn_buy_food":
                    if (this._catalog)
                    {
                        this._catalog.openCatalogPage(CatalogPageName.var_918, true);
                        if (((this._habboTracking) && (!(this._habboTracking.disposed))))
                        {
                            this._habboTracking.track("infostandBuyPetFoodButton", "click");
                        };
                    };
                    break;
                case "btn_petrespect":
                    this._widget.userData.petRespectLeft--;
                    this.updateRespectButton();
                    _loc3_ = RoomWidgetUserActionMessage.var_1838;
                    break;
                case "btn_kick":
                    _loc2_ = new RoomWidgetUserActionMessage(RoomWidgetUserActionMessage.var_1839, this._widget.petData.ownerId);
                    this._widget.messageListener.processWidgetMessage(_loc2_);
                    return;
            };
            if (_loc3_ != null)
            {
                _loc5_ = this._widget.petData.id;
                _loc2_ = new RoomWidgetUserActionMessage(_loc3_, _loc5_);
                this._widget.messageListener.processWidgetMessage(_loc2_);
            };
            this.updateWindow();
        }

        private function onClose(param1:WindowMouseEvent):void
        {
            this._widget.close();
        }

        private function updateRespectButton():void
        {
            if (this._buttons == null)
            {
                return;
            };
            var _loc1_:IRegionWindow = (this._buttons.getListItemByName("petrespect") as IRegionWindow);
            if (_loc1_ == null)
            {
                return;
            };
            var _loc2_:IWindow = (_loc1_.findChildByName("btn_petrespect") as IButtonWindow);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:int = this._widget.userData.petRespectLeft;
            this._widget.localizations.registerParameter("infostand.button.petrespect", "count", _loc3_.toString());
            _loc1_.visible = (_loc3_ > 0);
            this._buttons.arrangeListItems();
        }

        protected function showButton(param1:String, param2:Boolean):void
        {
            if (this._buttons == null)
            {
                return;
            };
            var _loc3_:IWindow = this._buttons.getListItemByName(param1);
            if (_loc3_ != null)
            {
                _loc3_.visible = param2;
                this._buttons.arrangeListItems();
            };
        }

        protected function onButtonResized(param1:WindowEvent):void
        {
            var _loc2_:IWindow = param1.window.parent;
            if (((_loc2_) && (_loc2_.tags.indexOf("CMD_BUTTON_REGION") > -1)))
            {
                _loc2_.width = param1.window.width;
            };
        }

    }
}