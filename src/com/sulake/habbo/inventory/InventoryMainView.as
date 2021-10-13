package com.sulake.habbo.inventory
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.toolbar.events.HabboToolbarShowMenuEvent;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import com.sulake.habbo.toolbar.events.HabboToolbarSetIconEvent;
    import com.sulake.core.window.components.ITabContextWindow;
    import com.sulake.habbo.inventory.enum.InventoryCategory;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class InventoryMainView 
    {

        private var _windowManager:IHabboWindowManager;
        private var _assetLibrary:IAssetLibrary;
        private var var_3431:IFrameWindow;
        private var var_3606:String;
        private var var_3607:IWindowContainer;
        private var var_3608:String;
        private var var_3609:IWindowContainer;
        private var _controller:HabboInventory;
        private var var_2844:IHabboToolbar;
        private var var_2464:Boolean = true;

        public function InventoryMainView(param1:HabboInventory, param2:IHabboWindowManager, param3:IAssetLibrary)
        {
            this._controller = param1;
            this._assetLibrary = param3;
            this._windowManager = param2;
            var _loc4_:IAsset = this._assetLibrary.getAssetByName("inventory_xml");
            var _loc5_:XmlAsset = XmlAsset(_loc4_);
            this.var_3431 = (this._windowManager.buildFromXML(XML(_loc5_.content)) as IFrameWindow);
            if (this.var_3431 != null)
            {
                this.var_3431.visible = false;
                this.var_3431.procedure = this.windowEventProc;
                this.setCreditBalance(0);
                this.setPixelBalance(0);
                this.setClubStatus(0, 0);
            };
        }

        public function get isVisible():Boolean
        {
            return ((this.var_3431) ? this.var_3431.visible : false);
        }

        public function dispose():void
        {
            this._controller = null;
            this.var_3431 = null;
            this.var_3607 = null;
            if (this.var_2844)
            {
                if (this.var_2844.events)
                {
                    this.var_2844.events.removeEventListener(HabboToolbarEvent.var_100, this.onHabboToolbarEvent);
                    this.var_2844.events.removeEventListener(HabboToolbarEvent.var_49, this.onHabboToolbarEvent);
                };
                this.var_2844 = null;
            };
            this._windowManager = null;
        }

        public function getWindow():IFrameWindow
        {
            return (this.var_3431);
        }

        public function getCategoryViewId():String
        {
            return (this.var_3606);
        }

        public function getSubCategoryViewId():String
        {
            return (this.var_3608);
        }

        public function hideInventory():void
        {
            this._controller.closingInventoryView();
            var _loc1_:IWindow = this.getWindow();
            if (_loc1_ == null)
            {
                return;
            };
            _loc1_.visible = false;
        }

        public function showInventory():void
        {
            var _loc1_:IWindow = this.getWindow();
            if (_loc1_ == null)
            {
                return;
            };
            _loc1_.visible = true;
            if (((!(this.var_2844 == null)) && (this.var_2464)))
            {
                this.var_2844.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.var_146, HabboToolbarIconEnum.INVENTORY, (_loc1_ as IWindowContainer)));
                this.var_2464 = false;
            };
            this._controller.inventoryViewOpened(this.var_3608);
        }

        public function toggleCategoryView(param1:String, param2:Boolean=true):void
        {
            var _loc3_:IWindow = this.getWindow();
            if (_loc3_ == null)
            {
                return;
            };
            if (_loc3_.visible)
            {
                if (this.var_3606 == param1)
                {
                    if (param2)
                    {
                        _loc3_.visible = false;
                    };
                }
                else
                {
                    this.setViewToCategory(param1);
                };
            }
            else
            {
                _loc3_.visible = true;
                _loc3_.activate();
                if (((!(param1 == this.var_3606)) || (!(this._controller.isInventoryCategoryInit(param1)))))
                {
                    this.setViewToCategory(param1);
                };
                if (((!(this.var_2844 == null)) && (this.var_2464)))
                {
                    this.var_2844.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.var_146, HabboToolbarIconEnum.INVENTORY, (_loc3_ as IWindowContainer)));
                    this.var_2464 = false;
                };
                this._controller.inventoryViewOpened(param1);
            };
        }

        public function toggleSubCategoryView(param1:String, param2:Boolean=true):void
        {
            var _loc3_:IWindow = this.getWindow();
            if (_loc3_ == null)
            {
                return;
            };
            if (_loc3_.visible)
            {
                if (this.var_3608 == param1)
                {
                    if (param2)
                    {
                        _loc3_.visible = false;
                    };
                }
                else
                {
                    this.setSubViewToCategory(param1);
                };
            }
            else
            {
                _loc3_.visible = true;
                if (param1 != this.var_3608)
                {
                    this.setSubViewToCategory(param1);
                };
                if (((!(this.var_2844 == null)) && (this.var_2464)))
                {
                    this.var_2844.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.var_146, HabboToolbarIconEnum.INVENTORY, (_loc3_ as IWindowContainer)));
                };
            };
        }

        public function updateSubCategoryView():void
        {
            if (this.var_3608 == null)
            {
                return;
            };
            this.setSubViewToCategory(this.var_3608);
        }

        public function setCreditBalance(param1:int):void
        {
            this._windowManager.registerLocalizationParameter("inventory.purse.creditbalance", "balance", String(param1));
        }

        public function setPixelBalance(param1:int):void
        {
            this._windowManager.registerLocalizationParameter("inventory.purse.pixelbalance", "balance", String(param1));
        }

        public function setClubStatus(param1:int, param2:int):void
        {
            this._windowManager.registerLocalizationParameter("inventory.purse.clubdays", "months", String(param1));
            this._windowManager.registerLocalizationParameter("inventory.purse.clubdays", "days", String(param2));
        }

        public function setToolbar(param1:IHabboToolbar):void
        {
            this.var_2844 = param1;
            this.var_2844.events.addEventListener(HabboToolbarEvent.var_100, this.onHabboToolbarEvent);
            this.var_2844.events.addEventListener(HabboToolbarEvent.var_49, this.onHabboToolbarEvent);
        }

        public function setHabboToolbarIcon():void
        {
            if (this.var_2844 != null)
            {
                this.var_2844.events.dispatchEvent(new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.var_145, HabboToolbarIconEnum.INVENTORY));
            };
        }

        private function setViewToCategory(param1:String):void
        {
            if (param1 == null)
            {
                return;
            };
            if (param1 == "")
            {
                return;
            };
            this._controller.checkCategoryInitilization(param1);
            var _loc2_:ITabContextWindow = (this.var_3431.findChildByName("contentArea") as ITabContextWindow);
            if (_loc2_ == null)
            {
                return;
            };
            _loc2_.container.removeChild(this.var_3607);
            _loc2_.invalidate();
            var _loc3_:IWindowContainer = this._controller.getCategoryWindowContainer(param1);
            if (_loc3_ == null)
            {
                return;
            };
            _loc3_.visible = true;
            _loc2_.container.addChild(_loc3_);
            this.var_3607 = _loc3_;
            this.var_3606 = param1;
            _loc2_.selector.setSelected(_loc2_.selector.getSelectableByName(param1));
        }

        private function setSubViewToCategory(param1:String):void
        {
            if (((param1 == null) || (param1 == "")))
            {
                return;
            };
            this._controller.checkCategoryInitilization(param1);
            var _loc2_:IWindowContainer = (this.var_3431.findChildByName("subContentArea") as IWindowContainer);
            while (_loc2_.numChildren > 0)
            {
                _loc2_.removeChildAt(0);
            };
            var _loc3_:IWindowContainer = this._controller.getCategorySubWindowContainer(param1);
            if (_loc3_ != null)
            {
                _loc2_.visible = true;
                _loc3_.visible = true;
                _loc2_.height = _loc3_.height;
                _loc2_.addChild(_loc3_);
            }
            else
            {
                _loc2_.visible = false;
                _loc2_.height = 0;
            };
            this.var_3431.resizeToFitContent();
            if (this.var_3431.parent != null)
            {
                if ((this.var_3431.x + this.var_3431.width) > this.var_3431.parent.width)
                {
                    this.var_3431.x = (this.var_3431.parent.width - this.var_3431.width);
                };
                if ((this.var_3431.y + this.var_3431.height) > this.var_3431.parent.height)
                {
                    this.var_3431.y = (this.var_3431.parent.height - this.var_3431.height);
                };
            };
            this.var_3609 = _loc3_;
            this.var_3608 = param1;
        }

        private function onHabboToolbarEvent(param1:HabboToolbarEvent):void
        {
            if (param1.type == HabboToolbarEvent.var_100)
            {
            };
            if (param1.iconId != HabboToolbarIconEnum.INVENTORY)
            {
                return;
            };
            if (param1.type == HabboToolbarEvent.var_49)
            {
                if (this.var_3606 == InventoryCategory.var_134)
                {
                    this.toggleCategoryView(InventoryCategory.var_134);
                }
                else
                {
                    if (this.var_3606 == InventoryCategory.var_133)
                    {
                        this.toggleCategoryView(InventoryCategory.var_133);
                    }
                    else
                    {
                        if (this._controller != null)
                        {
                            this._controller.toggleInventoryPage(InventoryCategory.var_133);
                        };
                    };
                };
            };
        }

        public function windowEventProc(param1:WindowEvent, param2:IWindow):void
        {
            var _loc3_:String;
            if (param1.type == WindowEvent.var_560)
            {
                _loc3_ = ITabContextWindow(param2).selector.getSelected().name;
                if (_loc3_ != this.var_3606)
                {
                    this._controller.toggleInventoryPage(_loc3_);
                };
            }
            else
            {
                if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
                {
                    if (param2.name == "header_button_close")
                    {
                        this.hideInventory();
                    };
                };
            };
        }

    }
}