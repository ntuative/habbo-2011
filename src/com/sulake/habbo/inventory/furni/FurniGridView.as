package com.sulake.habbo.inventory.furni
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.inventory.items.GroupItem;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class FurniGridView 
    {

        private var _windowManager:IHabboWindowManager;
        private var _assetLibrary:IAssetLibrary;
        private var _view:IWindowContainer;
        private var var_2446:FurniModel;
        private var _roomEngine:IRoomEngine;
        private var _category:String;
        private var var_2842:IItemGridWindow;
        private var var_3547:XML;
        private var var_2843:Object;

        public function FurniGridView(param1:FurniModel, param2:String, param3:IHabboWindowManager, param4:IAssetLibrary, param5:IRoomEngine)
        {
            this.var_2446 = param1;
            this._category = param2;
            this._assetLibrary = param4;
            this._windowManager = param3;
            this._roomEngine = param5;
            var _loc6_:IAsset = this._assetLibrary.getAssetByName("inventory_furni_grid_xml");
            var _loc7_:XmlAsset = XmlAsset(_loc6_);
            this._view = IWindowContainer(this._windowManager.buildFromXML(XML(_loc7_.content)));
            if (this._view != null)
            {
                this.var_2842 = (this._view.findChildByName("item_grid") as IItemGridWindow);
            };
        }

        public function get window():IWindowContainer
        {
            if (this._view == null)
            {
                return (null);
            };
            if (this._view.disposed)
            {
                return (null);
            };
            return (this._view);
        }

        public function clearGrid():void
        {
            if (this.var_2842 != null)
            {
                this.var_2842.removeGridItems();
            };
        }

        public function initFromList():void
        {
            var _loc3_:GroupItem;
            var _loc1_:Array = this.var_2446.getCategoryContent(this._category);
            var _loc2_:int;
            while (_loc2_ < _loc1_.length)
            {
                _loc3_ = (_loc1_[_loc2_] as GroupItem);
                this.var_2842.addGridItem(_loc3_.window);
                _loc2_++;
            };
        }

        public function updateItem(param1:int, param2:IWindowContainer):void
        {
            var _loc3_:IWindow = this.var_2842.getGridItemAt(param1);
            if (_loc3_)
            {
                _loc3_ = param2;
            };
        }

        public function addItemToBottom(param1:IWindowContainer):void
        {
            this.var_2842.addGridItem(param1);
            param1.procedure = this.itemEventProc;
        }

        public function addItemAt(param1:IWindowContainer, param2:int):void
        {
            this.var_2842.addGridItemAt(param1, param2);
            param1.procedure = this.itemEventProc;
        }

        public function removeItem(param1:int):IWindow
        {
            return (this.var_2842.removeGridItemAt(param1));
        }

        public function setLock(param1:Boolean):void
        {
            if (param1)
            {
                this.var_2842.autoArrangeItems = false;
                this.var_2842.lock();
            }
            else
            {
                this.var_2842.autoArrangeItems = true;
                this.var_2842.unlock();
            };
        }

        private function itemEventProc(param1:WindowEvent, param2:IWindow):void
        {
            var _loc3_:Boolean;
            if (param1.type == WindowMouseEvent.var_633)
            {
                this.var_2843 = null;
                this.var_2446.cancelFurniInMover();
            }
            else
            {
                if (param1.type == WindowMouseEvent.var_628)
                {
                    if (param2 == null)
                    {
                        return;
                    };
                    this.var_2446.toggleItemSelection(this._category, this.var_2842.getGridItemIndex(param1.window));
                    this.var_2843 = param2;
                }
                else
                {
                    if (((((param1.type == WindowMouseEvent.var_626) && (!(this.var_2843 == null))) && (this.var_2843 == param2)) && (!(this.var_2446.isTradingOpen))))
                    {
                        _loc3_ = this.var_2446.requestSelectedFurniPlacement(true);
                        if (_loc3_)
                        {
                            this.var_2843 = null;
                        };
                    }
                    else
                    {
                        if (param1.type == WindowMouseEvent.var_633)
                        {
                            (this.var_2843 == null);
                        }
                        else
                        {
                            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
                            {
                                (this.var_2843 == null);
                            }
                            else
                            {
                                if (param1.type == WindowMouseEvent.var_627)
                                {
                                    this.var_2446.requestCurrentActionOnSelection();
                                    this.var_2843 = null;
                                };
                            };
                        };
                    };
                };
            };
        }

    }
}