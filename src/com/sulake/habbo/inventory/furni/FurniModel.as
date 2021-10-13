package com.sulake.habbo.inventory.furni
{
    import com.sulake.habbo.inventory.IInventoryModel;
    import com.sulake.habbo.inventory.HabboInventory;
    import com.sulake.core.utils.Map;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import flash.utils.Timer;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import flash.events.TimerEvent;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.inventory.marketplace.MarketplaceModel;
    import com.sulake.habbo.inventory.items.IItem;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniData;
    import com.sulake.habbo.inventory.events.HabboInventoryItemAddedEvent;
    import com.sulake.habbo.inventory.enum.InventoryCategory;
    import com.sulake.habbo.inventory.items.FloorItem;
    import com.sulake.habbo.inventory.items.WallItem;
    import flash.display.BitmapData;
    import com.sulake.habbo.inventory.enum.FurniCategory;
    import com.sulake.habbo.inventory.items.GroupItem;
    import flash.events.Event;
    import com.sulake.habbo.inventory.events.HabboInventoryTrackingEvent;
    import com.sulake.habbo.inventory.trading.TradingModel;
    import com.sulake.habbo.inventory.recycler.RecyclerModel;
    import com.sulake.habbo.inventory.enum.InventorySubCategory;
    import com.sulake.habbo.communication.messages.outgoing.inventory.furni.RequestRoomPropertySet;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.communication.messages.outgoing.inventory.furni.RequestFurniInventoryComposer;
    import __AS3__.vec.*;

    public class FurniModel implements IInventoryModel 
    {

        public static const var_1222:String = "S";
        public static const var_1223:String = "I";
        public static const var_1235:String = "pets";
        private static const var_1236:int = 100;

        private var _controller:HabboInventory;
        private var _view:FurniView;
        private var var_2678:Map;
        private var _assets:IAssetLibrary;
        private var _windowManager:IHabboWindowManager;
        private var _roomEngine:IRoomEngine;
        private var _communication:IHabboCommunicationManager;
        private var _soundManager:IHabboSoundManager;
        private var _disposed:Boolean = false;
        private var var_3549:int = -1;
        private var var_2736:Timer;
        private var var_3550:XML;
        private var var_3551:IWindowContainer;
        private var var_2864:Boolean;
        private var var_3548:Timer;
        private var var_3552:Boolean;
        private var _catalog:IHabboCatalog;
        private var var_3553:Vector.<Array>;
        private var var_3554:Vector.<Array>;

        public function FurniModel(param1:HabboInventory, param2:MarketplaceModel, param3:IHabboWindowManager, param4:IHabboCommunicationManager, param5:IAssetLibrary, param6:IRoomEngine, param7:IHabboCatalog, param8:IHabboSoundManager)
        {
            this._controller = param1;
            this._communication = param4;
            this._windowManager = param3;
            this._assets = param5;
            this._roomEngine = param6;
            this._roomEngine.events.addEventListener(RoomEngineObjectEvent.var_141, this.onObjectPlaced);
            this._catalog = param7;
            this._soundManager = param8;
            this.var_3548 = new Timer(var_1236, 1);
            this.var_3548.addEventListener(TimerEvent.TIMER_COMPLETE, this.onImageUpdateTimerEvent);
            var _loc9_:IAsset = this._assets.getAssetByName("inventory_thumb_xml");
            var _loc10_:XmlAsset = XmlAsset(_loc9_);
            this.var_3550 = XML(_loc10_.content);
            this.clearFurniList();
            this._view = new FurniView(this, param2, this._windowManager, this._assets, this._roomEngine, this._soundManager);
            this._view.switchCategory(var_1222);
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
                if (this.var_2678 != null)
                {
                    this.var_2678.dispose();
                    this.var_2678 = null;
                };
                if (this._view != null)
                {
                    this._view.dispose();
                    this._view = null;
                };
                if (this._roomEngine != null)
                {
                    if (this._roomEngine.events != null)
                    {
                        this._roomEngine.events.removeEventListener(RoomEngineObjectEvent.var_141, this.onObjectPlaced);
                    };
                    this._roomEngine = null;
                };
                this._communication = null;
                this._assets = null;
                this._windowManager = null;
                if (this.var_3548 != null)
                {
                    this.var_3548.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onImageUpdateTimerEvent);
                    this.var_3548.stop();
                    this.var_3548 = null;
                };
                if (this.var_2736 != null)
                {
                    this.var_2736.removeEventListener(TimerEvent.TIMER_COMPLETE, this.initTimeout);
                    this.var_2736.stop();
                    this.var_2736 = null;
                };
                if (this.var_3551 != null)
                {
                    this.var_3551.dispose();
                    this.var_3551 = null;
                };
                this._disposed = true;
            };
        }

        public function insertFurniList(param1:String, param2:Array, param3:int, param4:int):void
        {
            var _loc5_:IItem;
            var _loc6_:FurniData;
            var _loc15_:Vector.<Array>;
            var _loc16_:Array;
            var _loc17_:Array;
            var _loc18_:int;
            var _loc19_:HabboInventoryItemAddedEvent;
            if (((param3 >= param4) && (param3 > 1)))
            {
                if (param1 == var_1222)
                {
                    if (this.var_3553 == null)
                    {
                        this.var_3553 = new Vector.<Array>(param3, true);
                    };
                    _loc15_ = this.var_3553;
                }
                else
                {
                    if (this.var_3554 == null)
                    {
                        this.var_3554 = new Vector.<Array>(param3, true);
                    };
                    _loc15_ = this.var_3554;
                };
                _loc15_[(param4 - 1)] = param2;
                for each (_loc16_ in _loc15_)
                {
                    if (_loc16_ == null)
                    {
                        return;
                    };
                };
                param2 = new Array();
                for each (_loc17_ in _loc15_)
                {
                    param2 = param2.concat(_loc17_);
                };
                _loc15_ = null;
            };
            this._controller.setInventoryCategoryInit(InventoryCategory.var_133);
            var _loc7_:Array = new Array();
            var _loc8_:Array = new Array();
            var _loc9_:Array = new Array();
            var _loc10_:Array = new Array();
            this.getAllStripIds(param1, _loc7_);
            var _loc11_:int;
            while (_loc11_ < param2.length)
            {
                _loc18_ = FurniData(param2[_loc11_]).stripId;
                if (_loc7_.indexOf(_loc18_) == -1)
                {
                    _loc9_.push(_loc18_);
                };
                _loc8_.push(_loc18_);
                _loc11_++;
            };
            _loc11_ = 0;
            while (_loc11_ < _loc7_.length)
            {
                if (_loc8_.indexOf(_loc7_[_loc11_]) == -1)
                {
                    _loc10_.push(_loc7_[_loc11_]);
                };
                _loc11_++;
            };
            this._view.setGridLock(param1, true);
            var _loc12_:* = (_loc7_.length == 0);
            var _loc13_:int;
            while (_loc13_ < param2.length)
            {
                _loc6_ = FurniData(param2[_loc13_]);
                if (_loc9_.indexOf(_loc6_.stripId) > -1)
                {
                    if (_loc6_.itemType == var_1222)
                    {
                        _loc5_ = new FloorItem(_loc6_.stripId, _loc6_.classId, _loc6_.objId, _loc6_.category, _loc6_.isGroupable, _loc6_.isTradeable, _loc6_.isRecyclable, _loc6_.isSellable, _loc6_.stuffData, _loc6_.extra, _loc6_.expiryTime, 0, 0, 0, _loc6_.slotId, _loc6_.songId);
                    }
                    else
                    {
                        if (_loc6_.itemType == var_1223)
                        {
                            _loc5_ = new WallItem(_loc6_.stripId, _loc6_.classId, _loc6_.objId, _loc6_.category, _loc6_.isGroupable, _loc6_.isTradeable, _loc6_.isRecyclable, _loc6_.isSellable, _loc6_.stuffData, _loc6_.extra);
                        }
                        else
                        {
                            throw (new Error((('Unknown inventory item category: "' + _loc6_.itemType) + '"')));
                        };
                    };
                    if (_loc12_)
                    {
                        this.addFurniAsLast(_loc5_, true);
                    }
                    else
                    {
                        this.addFurniAt(_loc5_, true, 0);
                    };
                };
                _loc13_++;
            };
            var _loc14_:int;
            while (_loc14_ < _loc10_.length)
            {
                this.removeFurni(_loc10_[_loc14_]);
                _loc14_++;
            };
            this._view.setGridLock(param1, false);
            this.updateItemLocks();
            if (this.getSelectedItemIndex(FurniModel.var_1222) == -1)
            {
                this.toggleItemSelection(FurniModel.var_1222, 0);
            };
            if (this.getSelectedItemIndex(FurniModel.var_1223) == -1)
            {
                this.toggleItemSelection(FurniModel.var_1223, 0);
            };
            this.initListImages();
            this.setListInitialized();
            for each (_loc6_ in param2)
            {
                if (_loc9_.indexOf(_loc6_.stripId) > -1)
                {
                    _loc19_ = new HabboInventoryItemAddedEvent(_loc6_.classId, _loc6_.stripId, _loc6_.category);
                    this._controller.events.dispatchEvent(_loc19_);
                };
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

        public function createNewGroupItemTemplate(param1:int, param2:String, param3:int, param4:String=null, param5:Number=NaN, param6:Boolean=false):GroupItem
        {
            var _loc7_:BitmapData;
            var _loc8_:IAsset;
            var _loc9_:BitmapData;
            if (param3 == FurniCategory.var_115)
            {
                _loc8_ = this._assets.getAssetByName("icon_wallpaper_png");
                if (_loc8_ != null)
                {
                    _loc7_ = (_loc8_.content as BitmapData);
                };
            }
            else
            {
                if (param3 == FurniCategory.var_117)
                {
                    _loc8_ = this._assets.getAssetByName("icon_floor_png");
                    if (_loc8_ != null)
                    {
                        _loc7_ = (_loc8_.content as BitmapData);
                    };
                }
                else
                {
                    if (param3 == FurniCategory.var_116)
                    {
                        _loc8_ = this._assets.getAssetByName("icon_landscape_png");
                        if (_loc8_ != null)
                        {
                            _loc7_ = (_loc8_.content as BitmapData);
                        };
                    };
                };
            };
            var _loc10_:IAsset = this._assets.getAssetByName("thumb_icon_recycle_png");
            if (_loc10_ != null)
            {
                _loc9_ = (_loc10_.content as BitmapData);
            };
            if (this.var_3551 == null)
            {
                this.var_3551 = (this._windowManager.buildFromXML(this.var_3550) as IWindowContainer);
            };
            var _loc11_:IWindowContainer = (this.var_3551.clone() as IWindowContainer);
            return (new GroupItem(param1, param2, param3, _loc11_, this._roomEngine, _loc9_.clone(), this._controller.recyclerModel.running, param4, param5, _loc7_, param6));
        }

        public function initListImages():void
        {
            var _loc1_:Array;
            var _loc2_:String;
            var _loc3_:GroupItem;
            var _loc6_:int;
            var _loc4_:Array = [var_1222, var_1223];
            var _loc5_:int;
            while (_loc5_ < _loc4_.length)
            {
                _loc2_ = _loc4_[_loc5_];
                _loc1_ = this.getCategoryContent(_loc2_);
                if (_loc1_ != null)
                {
                    _loc6_ = 0;
                    while (_loc6_ < _loc1_.length)
                    {
                        _loc3_ = (_loc1_[_loc6_] as GroupItem);
                        if (!_loc3_.isImageInited)
                        {
                            _loc3_.initImage(false);
                            if (!_loc3_.isImageFinished)
                            {
                                this.var_3548.reset();
                                this.var_3548.start();
                                return;
                            };
                        };
                        _loc6_++;
                    };
                };
                _loc5_++;
            };
        }

        private function onImageUpdateTimerEvent(param1:TimerEvent):void
        {
            this.initListImages();
        }

        public function requestInitialization(param1:int=0):void
        {
            if (param1 > 0)
            {
                if (this.var_2736 != null)
                {
                    this.var_2736.removeEventListener(TimerEvent.TIMER_COMPLETE, this.initTimeout);
                    this.var_2736.stop();
                    this.var_2736 = null;
                };
                this.var_2736 = new Timer(param1, 1);
                this.var_2736.addEventListener(TimerEvent.TIMER_COMPLETE, this.initTimeout);
                this.var_2736.start();
            }
            else
            {
                this.requestNewList();
            };
        }

        public function categorySwitch(param1:String):void
        {
            if (((param1 == InventoryCategory.var_133) && (this._controller.isVisible)))
            {
                switch (this._view.visibleCategoryId)
                {
                    case var_1222:
                        this._controller.events.dispatchEvent(new Event(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_FURNI));
                        return;
                    case var_1223:
                        this._controller.events.dispatchEvent(new Event(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_POSTERS));
                        return;
                    case var_1235:
                        this._controller.toggleInventoryPage(InventoryCategory.var_134);
                        return;
                };
            };
        }

        public function furniCategorySwitch():void
        {
            if (this._controller.isVisible)
            {
                switch (this._view.visibleCategoryId)
                {
                    case var_1222:
                        this._controller.events.dispatchEvent(new Event(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_FURNI));
                        return;
                    case var_1223:
                        this._controller.events.dispatchEvent(new Event(HabboInventoryTrackingEvent.HABBO_INVENTORY_TRACKING_EVENT_POSTERS));
                        return;
                    case var_1235:
                        this._controller.toggleInventoryPage(InventoryCategory.var_134);
                        return;
                };
            };
        }

        public function switchCategory(param1:String):void
        {
            this._view.switchCategory(param1);
        }

        private function initTimeout(param1:TimerEvent):void
        {
            if (this.var_2736 != null)
            {
                this.var_2736.removeEventListener(TimerEvent.TIMER_COMPLETE, this.initTimeout);
                this.var_2736.stop();
                this.var_2736 = null;
            };
            this.requestNewList();
        }

        public function getWindowContainer():IWindowContainer
        {
            this._controller.checkCategoryInitilization(InventoryCategory.var_254);
            return (this._view.getWindowContainer());
        }

        public function closingInventoryView():void
        {
        }

        public function updateItemLocks():void
        {
            var _loc4_:Array;
            var _loc5_:String;
            var _loc6_:GroupItem;
            var _loc9_:int;
            var _loc1_:Array = new Array();
            var _loc2_:TradingModel = this._controller.tradingModel;
            if (_loc2_ != null)
            {
                _loc1_ = _loc1_.concat(_loc2_.getOwnItemIdsInTrade());
            };
            var _loc3_:RecyclerModel = this._controller.recyclerModel;
            if (_loc3_ != null)
            {
                _loc1_ = _loc1_.concat(_loc3_.getOwnItemsInRecycler());
            };
            if (_loc1_.length == 0)
            {
                this.removeAllLocks();
                return;
            };
            var _loc7_:Array = [var_1222, var_1223];
            var _loc8_:int;
            while (_loc8_ < _loc7_.length)
            {
                _loc5_ = _loc7_[_loc8_];
                _loc4_ = this.getCategoryContent(_loc5_);
                if (_loc4_ != null)
                {
                    _loc9_ = 0;
                    while (_loc9_ < _loc4_.length)
                    {
                        _loc6_ = (_loc4_[_loc9_] as GroupItem);
                        _loc6_.addLocksFromData(_loc1_);
                        _loc9_++;
                    };
                };
                _loc8_++;
            };
            this._view.updateActionView();
        }

        public function addLockTo(param1:int):void
        {
            var _loc2_:Array;
            var _loc3_:String;
            var _loc4_:GroupItem;
            var _loc7_:int;
            var _loc5_:Array = [var_1222, var_1223];
            var _loc6_:int;
            while (_loc6_ < _loc5_.length)
            {
                _loc3_ = _loc5_[_loc6_];
                _loc2_ = this.getCategoryContent(_loc3_);
                if (_loc2_ != null)
                {
                    _loc7_ = 0;
                    while (_loc7_ < _loc2_.length)
                    {
                        _loc4_ = (_loc2_[_loc7_] as GroupItem);
                        _loc4_.addLockTo(param1);
                        _loc7_++;
                    };
                };
                _loc6_++;
            };
            this._view.updateActionView();
        }

        public function removeLockFrom(param1:int):void
        {
            var _loc2_:Array;
            var _loc3_:String;
            var _loc4_:GroupItem;
            var _loc7_:int;
            var _loc5_:Array = [var_1222, var_1223];
            var _loc6_:int;
            while (_loc6_ < _loc5_.length)
            {
                _loc3_ = _loc5_[_loc6_];
                _loc2_ = this.getCategoryContent(_loc3_);
                if (_loc2_ != null)
                {
                    _loc7_ = 0;
                    while (_loc7_ < _loc2_.length)
                    {
                        _loc4_ = (_loc2_[_loc7_] as GroupItem);
                        if (_loc4_)
                        {
                            _loc4_.removeLockFrom(param1);
                        };
                        _loc7_++;
                    };
                };
                _loc6_++;
            };
            this._view.updateActionView();
        }

        public function showRecyclable(param1:Boolean):void
        {
            var _loc2_:Array;
            var _loc3_:String;
            var _loc4_:GroupItem;
            var _loc7_:int;
            var _loc5_:Array = [var_1222, var_1223];
            var _loc6_:int;
            while (_loc6_ < _loc5_.length)
            {
                _loc3_ = _loc5_[_loc6_];
                _loc2_ = this.getCategoryContent(_loc3_);
                if (_loc2_ != null)
                {
                    _loc7_ = 0;
                    while (_loc7_ < _loc2_.length)
                    {
                        _loc4_ = (_loc2_[_loc7_] as GroupItem);
                        _loc4_.showRecyclable = param1;
                        _loc7_++;
                    };
                };
                _loc6_++;
            };
            this._view.updateActionView();
        }

        public function clearFurniList():void
        {
            this.var_2678 = new Map();
            this.var_2678.add(var_1222, new Array());
            this.var_2678.add(var_1223, new Array());
            if (this._view != null)
            {
                this._view.clearViews();
            };
        }

        public function addFurniAsLast(param1:IItem, param2:Boolean=false):void
        {
            this.addFurniAt(param1, param2);
        }

        public function addFurniAt(param1:IItem, param2:Boolean=false, param3:int=-1):void
        {
            var _loc4_:String;
            var _loc5_:GroupItem;
            var _loc7_:GroupItem;
            var _loc8_:int;
            if ((param1 is FloorItem))
            {
                _loc4_ = var_1222;
            }
            else
            {
                if ((param1 is WallItem))
                {
                    _loc4_ = var_1223;
                }
                else
                {
                    return;
                };
            };
            var _loc6_:Array = this.getCategoryContent(_loc4_);
            if (!param1.groupable)
            {
                for each (_loc7_ in _loc6_)
                {
                    if (_loc7_.type == param1.type)
                    {
                        if (_loc7_.getItem(param1.id) != null)
                        {
                            return;
                        };
                        break;
                    };
                };
                _loc5_ = this.createNewGroupItemTemplate(param1.type, _loc4_, param1.category, param1.stuffData, param1.extra, param2);
                _loc5_.push(param1);
                if (param3 == -1)
                {
                    _loc6_.push(_loc5_);
                }
                else
                {
                    _loc6_.splice(param3, 0, _loc5_);
                };
                if (this._view != null)
                {
                    if (param3 == -1)
                    {
                        this._view.addItemToBottom(_loc4_, _loc5_);
                    }
                    else
                    {
                        this._view.addItemAt(_loc4_, _loc5_, param3);
                    };
                };
            }
            else
            {
                _loc8_ = 0;
                while (_loc8_ < _loc6_.length)
                {
                    _loc7_ = (_loc6_[_loc8_] as GroupItem);
                    if (_loc7_.type == param1.type)
                    {
                        if (param1.category == FurniCategory.var_598)
                        {
                            if (_loc7_.stuffData == param1.stuffData)
                            {
                                _loc5_ = _loc7_;
                                break;
                            };
                        }
                        else
                        {
                            _loc5_ = _loc7_;
                            break;
                        };
                    };
                    _loc8_++;
                };
                if (_loc5_)
                {
                    _loc5_.push(param1);
                }
                else
                {
                    _loc5_ = this.createNewGroupItemTemplate(param1.type, _loc4_, param1.category, param1.stuffData, param1.extra, param2);
                    _loc5_.push(param1);
                    if (this._view != null)
                    {
                        if (param3 == -1)
                        {
                            _loc6_.push(_loc5_);
                            this._view.addItemToBottom(_loc4_, _loc5_);
                        }
                        else
                        {
                            _loc6_.unshift(_loc5_);
                            this._view.addItemAt(_loc4_, _loc5_, param3);
                        };
                    };
                };
            };
            this._view.setViewToState();
            if (_loc5_.isSelected)
            {
                this._view.updateActionView();
            };
        }

        public function removeFurni(param1:int):void
        {
            var _loc2_:Array;
            var _loc3_:String;
            var _loc4_:GroupItem;
            var _loc7_:int;
            var _loc8_:IItem;
            var _loc5_:Array = [var_1222, var_1223];
            var _loc6_:int;
            while (_loc6_ < _loc5_.length)
            {
                _loc3_ = _loc5_[_loc6_];
                _loc2_ = this.getCategoryContent(_loc3_);
                if (_loc2_ != null)
                {
                    _loc7_ = 0;
                    while (_loc7_ < _loc2_.length)
                    {
                        _loc4_ = (_loc2_[_loc7_] as GroupItem);
                        _loc8_ = _loc4_.remove(param1);
                        if (_loc8_)
                        {
                            if (this.var_3549 == _loc8_.ref)
                            {
                                this.cancelFurniInMover();
                                if (!this.requestSelectedFurniPlacement())
                                {
                                    this._controller.showView();
                                };
                            };
                            if (_loc4_.getTotalCount() <= 0)
                            {
                                this._view.removeItem(_loc3_, _loc7_);
                                _loc2_.splice(_loc7_, 1);
                                if (_loc4_.isSelected)
                                {
                                    this.toggleItemSelection(_loc3_, 0);
                                };
                            }
                            else
                            {
                                this._view.updateActionView();
                            };
                            this._view.setViewToState();
                            return;
                        };
                        _loc7_++;
                    };
                };
                _loc6_++;
            };
        }

        public function updatePostItCount(param1:int, param2:int):void
        {
            var _loc5_:GroupItem;
            var _loc6_:WallItem;
            var _loc3_:Array = this.getCategoryContent(var_1223);
            if (_loc3_ == null)
            {
                return;
            };
            var _loc4_:int;
            while (_loc4_ < _loc3_.length)
            {
                _loc5_ = (_loc3_[_loc4_] as GroupItem);
                _loc6_ = (_loc5_.getItem(param1) as WallItem);
                if (_loc6_ != null)
                {
                    _loc6_.stuffData = String(param2);
                    _loc5_.replaceItem(param1, _loc6_);
                };
                _loc4_++;
            };
        }

        public function toggleItemSelection(param1:String, param2:int):void
        {
            var _loc4_:GroupItem;
            var _loc5_:int;
            var _loc3_:Array = this.getCategoryContent(param1);
            if (((_loc3_ == null) || (_loc3_.length == 0)))
            {
                return;
            };
            if (((param2 > -1) && (_loc3_.length > param2)))
            {
                _loc4_ = (_loc3_[param2] as GroupItem);
                _loc4_.isSelected = true;
                this._view.updateItem(param1, _loc4_, param2);
            };
            if (((_loc4_) && (_loc4_.isSelected)))
            {
                _loc5_ = 0;
                while (_loc5_ < _loc3_.length)
                {
                    if (_loc5_ != param2)
                    {
                        _loc4_ = (_loc3_[_loc5_] as GroupItem);
                        if (((_loc4_) && (_loc4_.isSelected)))
                        {
                            _loc4_.isSelected = false;
                        };
                    };
                    _loc5_++;
                };
            };
            this._view.updateActionView();
        }

        public function displayItemInfo(param1:GroupItem):void
        {
            if (((this._view) && (!(this._view.disposed))))
            {
                this._view.displayItemInfo(param1);
            };
        }

        public function getSelectedItemIndex(param1:String=null):int
        {
            var _loc3_:GroupItem;
            if (param1 == null)
            {
                if (this._view == null)
                {
                    return (-1);
                };
            };
            if (param1 == null)
            {
                param1 = this._view.visibleCategoryId;
            };
            var _loc2_:Array = this.getCategoryContent(param1);
            if (_loc2_ == null)
            {
                return (-1);
            };
            var _loc4_:int;
            while (_loc4_ < _loc2_.length)
            {
                _loc3_ = (_loc2_[_loc4_] as GroupItem);
                if (_loc3_.isSelected)
                {
                    return (_loc4_);
                };
                _loc4_++;
            };
            return (-1);
        }

        public function getGroupItemInIndex(param1:int, param2:String=null):GroupItem
        {
            if (param2 == null)
            {
                param2 = this._view.visibleCategoryId;
            };
            var _loc3_:Array = this.getCategoryContent(param2);
            if (_loc3_ == null)
            {
                return (null);
            };
            if (param1 >= _loc3_.length)
            {
                return (null);
            };
            return (_loc3_[param1] as GroupItem);
        }

        public function getGroupItemByType(param1:int):GroupItem
        {
            var _loc2_:Array;
            var _loc3_:String;
            var _loc4_:GroupItem;
            var _loc7_:int;
            var _loc5_:Array = [var_1222, var_1223];
            var _loc6_:int;
            while (_loc6_ < _loc5_.length)
            {
                _loc3_ = _loc5_[_loc6_];
                _loc2_ = this.getCategoryContent(_loc3_);
                if (_loc2_ != null)
                {
                    _loc7_ = 0;
                    while (_loc7_ < _loc2_.length)
                    {
                        _loc4_ = (_loc2_[_loc7_] as GroupItem);
                        if (_loc4_.type == param1)
                        {
                            return (_loc4_);
                        };
                        _loc7_++;
                    };
                };
                _loc6_++;
            };
            return (null);
        }

        public function get isTradingOpen():Boolean
        {
            return (this._controller.getSubCategoryViewId() == InventorySubCategory.var_251);
        }

        public function canUserOfferToTrade():Boolean
        {
            return (this._controller.canUserOfferToTrade());
        }

        public function removeAllLocks():void
        {
            var _loc1_:Array;
            var _loc2_:String;
            var _loc3_:GroupItem;
            var _loc6_:int;
            var _loc4_:Array = [var_1222, var_1223];
            var _loc5_:int;
            while (_loc5_ < _loc4_.length)
            {
                _loc2_ = _loc4_[_loc5_];
                _loc1_ = this.getCategoryContent(_loc2_);
                if (_loc1_ != null)
                {
                    _loc6_ = 0;
                    while (_loc6_ < _loc1_.length)
                    {
                        _loc3_ = (_loc1_[_loc6_] as GroupItem);
                        if (_loc3_ != null)
                        {
                            _loc3_.removeAllLocks();
                        };
                        _loc6_++;
                    };
                };
                _loc5_++;
            };
            if (this._view != null)
            {
                this._view.updateActionView();
            };
        }

        public function cancelFurniInMover():void
        {
            if (this.var_3549 > -1)
            {
                this._roomEngine.cancelRoomObjectInsert();
                this.var_2864 = false;
                this.var_3549 = -1;
            };
        }

        public function requestSelectedFurniPlacement(param1:Boolean=false):Boolean
        {
            var _loc2_:GroupItem = this.getGroupItemInIndex(this.getSelectedItemIndex(), this._view.visibleCategoryId);
            if (_loc2_ == null)
            {
                return (false);
            };
            if (_loc2_.getUnlockedCount() == 0)
            {
                return (false);
            };
            var _loc3_:IItem = _loc2_.peek();
            if (_loc3_ == null)
            {
                return (false);
            };
            if ((((_loc3_.category == FurniCategory.var_117) || (_loc3_.category == FurniCategory.var_115)) || (_loc3_.category == FurniCategory.var_116)))
            {
                if (param1)
                {
                    return (false);
                };
                this._communication.getHabboMainConnection(null).send(new RequestRoomPropertySet(_loc3_.id));
            }
            else
            {
                this.requestSelectedFurniToMover(_loc3_);
            };
            this._view.updateActionView();
            return (true);
        }

        private function requestSelectedFurniToMover(param1:IItem):void
        {
            var _loc2_:int;
            var _loc3_:Boolean;
            if ((param1 is FloorItem))
            {
                _loc2_ = RoomObjectCategoryEnum.var_72;
            }
            else
            {
                _loc2_ = RoomObjectCategoryEnum.var_73;
            };
            if (param1.category == FurniCategory.var_598)
            {
                _loc3_ = this._roomEngine.var_485(param1.id, _loc2_, param1.type, param1.stuffData);
            }
            else
            {
                _loc3_ = this._roomEngine.var_485(param1.id, _loc2_, param1.type, param1.extra.toString());
            };
            if (_loc3_)
            {
                this.var_3549 = param1.ref;
                if (!this._controller.recyclerModel.running)
                {
                    this.requestClose();
                };
                this.var_2864 = true;
            };
            this._view.updateActionView();
        }

        public function requestSelectedFurniToTrading():void
        {
            var _loc1_:GroupItem = this.getGroupItemInIndex(this.getSelectedItemIndex(), this._view.visibleCategoryId);
            if (_loc1_ == null)
            {
                return;
            };
            var _loc2_:IItem = _loc1_.getOneForTrade();
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:TradingModel = this._controller.tradingModel;
            if (_loc3_ != null)
            {
                _loc3_.requestAddItemToTrading(_loc2_.id, _loc2_.type, _loc2_.category, _loc2_.groupable, _loc2_.stuffData);
            };
            this._view.updateActionView();
        }

        public function requestSelectedFurniSelling():void
        {
            var _loc1_:GroupItem = this.getGroupItemInIndex(this.getSelectedItemIndex(), this._view.visibleCategoryId);
            if (_loc1_ == null)
            {
                return;
            };
            var _loc2_:IItem = _loc1_.getOneForTrade();
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:MarketplaceModel = this._controller.marketplaceModel;
            if (_loc3_ == null)
            {
                return;
            };
            _loc3_.startOfferMaking(_loc2_);
        }

        public function requestSelectedFurniToRecycler():IItem
        {
            var _loc1_:GroupItem = this.getGroupItemInIndex(this.getSelectedItemIndex(), this._view.visibleCategoryId);
            if (_loc1_ == null)
            {
                return (null);
            };
            var _loc2_:IItem = _loc1_.getOneForRecycle();
            if (_loc2_ == null)
            {
                return (null);
            };
            this._view.updateActionView();
            return (_loc2_);
        }

        public function requestCurrentActionOnSelection():void
        {
            if (this.isTradingOpen)
            {
                this.requestSelectedFurniToTrading();
            }
            else
            {
                this.requestSelectedFurniPlacement(false);
            };
        }

        public function onObjectPlaced(param1:Event):void
        {
            if (((this.var_2864) && (param1.type == RoomEngineObjectEvent.var_141)))
            {
                this.var_2864 = false;
            };
        }

        public function requestClose():void
        {
            this._controller.closeView();
        }

        public function requestNewList():void
        {
            var _loc1_:IConnection = this._communication.getHabboMainConnection(null);
            if (_loc1_ == null)
            {
                return;
            };
            _loc1_.send(new RequestFurniInventoryComposer());
        }

        public function requestCatalogOpen():void
        {
            this._catalog.openCatalog();
        }

        public function getCategoryContent(param1:String):Array
        {
            return (this.var_2678.getValue(param1));
        }

        public function subCategorySwitch(param1:String):void
        {
            switch (param1)
            {
                case InventorySubCategory.var_251:
                    this.cancelFurniInMover();
                    if (this._view != null)
                    {
                        this._view.updateActionView();
                    };
                    return;
                case InventorySubCategory.var_1231:
                    this.removeAllLocks();
                    if (this._view != null)
                    {
                        this._view.updateActionView();
                    };
                    return;
            };
        }

        public function getAllStripIds(param1:String, param2:Array):void
        {
            var _loc4_:int;
            var _loc5_:GroupItem;
            var _loc6_:int;
            var _loc7_:int;
            var _loc3_:Array = (this.var_2678.getValue(param1) as Array);
            if (_loc3_ != null)
            {
                _loc4_ = 0;
                while (_loc4_ < _loc3_.length)
                {
                    _loc5_ = GroupItem(_loc3_[_loc4_]);
                    _loc6_ = _loc5_.getTotalCount();
                    if (_loc5_.category == FurniCategory.var_597)
                    {
                        _loc6_ = 1;
                    };
                    _loc7_ = 0;
                    while (_loc7_ < _loc6_)
                    {
                        param2.push(GroupItem(_loc3_[_loc4_]).getAt(_loc7_).id);
                        _loc7_++;
                    };
                    _loc4_++;
                };
            };
        }

        public function updateView():void
        {
            if (this._view != null)
            {
                this._view.updateActionView();
            };
        }

        public function get isPrivateRoom():Boolean
        {
            if (((!(this._controller)) || (!(this._controller.roomSession))))
            {
                return (false);
            };
            return (this._controller.roomSession.isPrivateRoom);
        }

    }
}