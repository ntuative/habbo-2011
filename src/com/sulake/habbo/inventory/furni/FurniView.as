﻿package com.sulake.habbo.inventory.furni
{
    import com.sulake.habbo.inventory.IInventoryView;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.inventory.marketplace.MarketplaceModel;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.habbo.inventory.items.GroupItem;
    import com.sulake.habbo.inventory.items.IItem;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.sound.ISongInfo;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.inventory.enum.FurniCategory;
    import com.sulake.habbo.inventory.items.FloorItem;
    import com.sulake.room.utils.Vector3d;
    import flash.filters.GlowFilter;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class FurniView implements IInventoryView, IGetImageListener 
    {

        private const var_3556:int = 0;
        private const var_3557:int = 1;
        private const var_3558:int = 2;
        private const var_3559:int = 3;
        private const var_3560:int = 42;
        private const var_3561:int = 120;

        private var _windowManager:IHabboWindowManager;
        private var _assetLibrary:IAssetLibrary;
        private var _view:IWindowContainer;
        private var var_2446:FurniModel;
        private var var_2629:MarketplaceModel;
        private var _roomEngine:IRoomEngine;
        private var _soundManager:IHabboSoundManager;
        private var _disposed:Boolean = false;
        private var var_3555:Map;
        private var var_3562:String;
        private var var_3563:int = 0;
        private var var_3564:int = -1;

        public function FurniView(param1:FurniModel, param2:MarketplaceModel, param3:IHabboWindowManager, param4:IAssetLibrary, param5:IRoomEngine, param6:IHabboSoundManager)
        {
            var _loc13_:IWindowContainer;
            super();
            this.var_2446 = param1;
            this.var_2629 = param2;
            this._assetLibrary = param4;
            this._windowManager = param3;
            this._roomEngine = param5;
            this._soundManager = param6;
            this._soundManager.events.addEventListener(SongInfoReceivedEvent.var_937, this.onSongInfoReceivedEvent);
            this.var_3555 = new Map();
            this.var_3555.add(FurniModel.var_1222, new FurniGridView(this.var_2446, FurniModel.var_1222, this._windowManager, this._assetLibrary, this._roomEngine));
            this.var_3555.add(FurniModel.var_1223, new FurniGridView(this.var_2446, FurniModel.var_1223, this._windowManager, this._assetLibrary, this._roomEngine));
            var _loc7_:IAsset = this._assetLibrary.getAssetByName("inventory_furni_base_xml");
            var _loc8_:XmlAsset = XmlAsset(_loc7_);
            if (_loc8_ == null)
            {
                return;
            };
            this._view = IWindowContainer(this._windowManager.buildFromXML(XML(_loc8_.content)));
            this._view.visible = false;
            this._view.procedure = this.windowEventProc;
            this.switchCategory(FurniModel.var_1222);
            var _loc9_:IWindowContainer = (this._view.findChildByName("preview_container") as IWindowContainer);
            if (_loc9_ != null)
            {
                _loc7_ = this._assetLibrary.getAssetByName("inventory_furni_preview_xml");
                _loc8_ = XmlAsset(_loc7_);
                _loc13_ = IWindowContainer(this._windowManager.buildFromXML(XML(_loc8_.content)));
                if (_loc13_ != null)
                {
                    _loc9_.addChild(_loc13_);
                };
            };
            var _loc10_:IBitmapWrapperWindow = (this._view.findChildByName("download_image") as IBitmapWrapperWindow);
            _loc10_.bitmap = new BitmapData(_loc10_.width, _loc10_.height);
            var _loc11_:BitmapData = (this._assetLibrary.getAssetByName("download_icon_png").content as BitmapData);
            _loc10_.bitmap.copyPixels(_loc11_, _loc11_.rect, new Point(((_loc10_.width - _loc11_.width) / 2), ((_loc10_.height - _loc11_.height) / 2)), null, null, true);
            _loc10_ = (this._view.findChildByName("image") as IBitmapWrapperWindow);
            _loc10_.bitmap = new BitmapData(_loc10_.width, _loc10_.height);
            var _loc12_:BitmapData = (this._assetLibrary.getAssetByName("inventory_empty_png").content as BitmapData);
            _loc10_.bitmap.copyPixels(_loc12_, _loc12_.rect, new Point(((_loc10_.width - _loc12_.width) / 2), ((_loc10_.height - _loc12_.height) / 2)), null, null, true);
            this.setViewToState();
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this.var_2446 = null;
                this.var_2629 = null;
                this._view = null;
                this._windowManager = null;
                this._roomEngine = null;
                if (this._soundManager)
                {
                    if (this._soundManager.events != null)
                    {
                        this._soundManager.events.removeEventListener(SongInfoReceivedEvent.var_937, this.onSongInfoReceivedEvent);
                    };
                    this._soundManager = null;
                };
                this._disposed = true;
            };
        }

        public function getWindowContainer():IWindowContainer
        {
            var _loc2_:IWindow;
            if (this._view == null)
            {
                return (null);
            };
            if (this._view.disposed)
            {
                return (null);
            };
            var _loc1_:Boolean = this.var_2446.isTradingOpen;
            _loc2_ = this._view.findChildByName("placeinroom_btn");
            if (_loc2_ != null)
            {
                _loc2_.visible = (!(_loc1_));
            };
            _loc2_ = this._view.findChildByName("offertotrade_btn");
            if (_loc2_ != null)
            {
                _loc2_.visible = _loc1_;
            };
            return (this._view);
        }

        public function get visibleCategoryId():String
        {
            return (this.var_3562);
        }

        public function switchCategory(param1:String):void
        {
            if (this._view == null)
            {
                return;
            };
            if (this._view.disposed)
            {
                return;
            };
            if (this.var_3562 == param1)
            {
                return;
            };
            var _loc2_:ISelectorWindow = (this._view.findChildByName("category_selector") as ISelectorWindow);
            switch (param1)
            {
                case FurniModel.var_1223:
                    _loc2_.setSelected(_loc2_.getSelectableByName("tab_wall"));
                    this.var_3562 = FurniModel.var_1223;
                    break;
                case FurniModel.var_1222:
                    _loc2_.setSelected(_loc2_.getSelectableByName("tab_floor"));
                    this.var_3562 = FurniModel.var_1222;
                    break;
                case FurniModel.var_1235:
                    _loc2_.setSelected(_loc2_.getSelectableByName("tab_pets"));
                    this.var_3562 = FurniModel.var_1235;
                    break;
                default:
                    throw (new Error((('Unknown item category: "' + param1) + '"')));
            };
            this.var_2446.furniCategorySwitch();
            this.showCategoryGrid(this.var_3562);
            this.setViewToState();
        }

        private function showCategoryGrid(param1:String=null):void
        {
            var _loc4_:IWindowContainer;
            if (param1 == null)
            {
                param1 = this.var_3562;
            };
            var _loc2_:IWindowContainer = (this._view.findChildByName("grid_container") as IWindowContainer);
            _loc2_.removeChildAt(0);
            var _loc3_:FurniGridView = this.var_3555.getValue(this.var_3562);
            if (_loc3_)
            {
                _loc4_ = _loc3_.window;
                if (_loc4_ == null)
                {
                    return;
                };
                _loc2_.addChild(_loc4_);
                _loc2_.invalidate();
                this.updateActionView();
            };
        }

        public function setViewToState():void
        {
            var _loc2_:int;
            var _loc1_:Array = this.var_2446.getCategoryContent(this.var_3562);
            if (!this.var_2446.isListInited())
            {
                _loc2_ = this.var_3557;
            }
            else
            {
                if (((!(_loc1_)) || (_loc1_.length == 0)))
                {
                    _loc2_ = this.var_3558;
                }
                else
                {
                    _loc2_ = this.var_3559;
                };
            };
            if (this.var_3563 == _loc2_)
            {
                return;
            };
            this.var_3563 = _loc2_;
            var _loc3_:IWindowContainer = (this._view.findChildByName("loading_container") as IWindowContainer);
            var _loc4_:IWindowContainer = (this._view.findChildByName("empty_container") as IWindowContainer);
            var _loc5_:IWindowContainer = (this._view.findChildByName("furni_container") as IWindowContainer);
            switch (_loc2_)
            {
                case this.var_3557:
                    _loc3_.visible = true;
                    _loc4_.visible = false;
                    _loc5_.visible = false;
                    return;
                case this.var_3558:
                    _loc3_.visible = false;
                    _loc4_.visible = true;
                    _loc5_.visible = false;
                    return;
                case this.var_3559:
                    _loc3_.visible = false;
                    _loc4_.visible = false;
                    _loc5_.visible = true;
                    this.showCategoryGrid();
                    return;
            };
        }

        public function clearViews():void
        {
            var _loc2_:String;
            var _loc3_:FurniGridView;
            var _loc1_:Array = [FurniModel.var_1222, FurniModel.var_1223];
            var _loc4_:int;
            while (_loc4_ < _loc1_.length)
            {
                _loc2_ = _loc1_[_loc4_];
                _loc3_ = this.var_3555.getValue(_loc2_);
                if (_loc3_ != null)
                {
                    _loc3_.clearGrid();
                };
                _loc4_++;
            };
            this.updateActionView();
        }

        public function updateItem(param1:String, param2:GroupItem, param3:int):void
        {
            if (param2 == null)
            {
                return;
            };
            var _loc4_:FurniGridView = this.var_3555.getValue(param1);
            if (_loc4_ == null)
            {
                return;
            };
            _loc4_.updateItem(param3, param2.window);
            this.updateActionView();
        }

        public function addItemToBottom(param1:String, param2:GroupItem):void
        {
            if (param2 == null)
            {
                return;
            };
            var _loc3_:FurniGridView = this.var_3555.getValue(param1);
            if (_loc3_ == null)
            {
                return;
            };
            _loc3_.addItemToBottom(param2.window);
        }

        public function addItemAt(param1:String, param2:GroupItem, param3:int):void
        {
            if (param2 == null)
            {
                return;
            };
            var _loc4_:FurniGridView = this.var_3555.getValue(param1);
            if (_loc4_ == null)
            {
                return;
            };
            _loc4_.addItemAt(param2.window, param3);
        }

        public function removeItem(param1:String, param2:int):void
        {
            var _loc3_:FurniGridView = this.var_3555.getValue(param1);
            if (_loc3_ == null)
            {
                return;
            };
            var _loc4_:IWindow = _loc3_.removeItem(param2);
            if (_loc4_)
            {
                _loc4_.dispose();
            };
            this.updateActionView();
        }

        public function setGridLock(param1:String, param2:Boolean):void
        {
            var _loc3_:FurniGridView = this.var_3555.getValue(param1);
            if (_loc3_ == null)
            {
                return;
            };
            _loc3_.setLock(param2);
        }

        public function updateActionView():void
        {
            var _loc2_:BitmapData;
            var _loc4_:GroupItem;
            var _loc5_:IItem;
            var _loc6_:IBitmapWrapperWindow;
            var _loc7_:ITextWindow;
            var _loc8_:IRegionWindow;
            var _loc9_:String;
            var _loc10_:String;
            var _loc11_:IButtonWindow;
            var _loc15_:IAsset;
            var _loc16_:String;
            var _loc17_:String;
            var _loc18_:String;
            var _loc19_:BitmapData;
            var _loc20_:IAsset;
            var _loc21_:int;
            var _loc22_:ImageResult;
            var _loc23_:uint;
            var _loc24_:int;
            var _loc25_:ISongInfo;
            if (this._view == null)
            {
                return;
            };
            if (this._view.disposed)
            {
                return;
            };
            var _loc1_:Boolean;
            var _loc3_:int = this.var_2446.getSelectedItemIndex();
            _loc4_ = this.var_2446.getGroupItemInIndex(_loc3_, this.var_3562);
            if ((((_loc3_ > -1) && (!(_loc4_ == null))) && (!(_loc4_.peek() == null))))
            {
                _loc5_ = _loc4_.peek();
                _loc1_ = true;
                _loc16_ = this._roomEngine.getRoomStringValue(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory, RoomObjectVariableEnum.var_467);
                _loc17_ = this._roomEngine.getRoomStringValue(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory, RoomObjectVariableEnum.var_465);
                _loc18_ = this._roomEngine.getRoomStringValue(this._roomEngine.activeRoomId, this._roomEngine.activeRoomCategory, RoomObjectVariableEnum.var_469);
                _loc16_ = (((_loc16_) && (_loc16_.length > 0)) ? _loc16_ : "101");
                _loc17_ = (((_loc17_) && (_loc17_.length > 0)) ? _loc17_ : "101");
                _loc18_ = (((_loc18_) && (_loc18_.length > 0)) ? _loc18_ : "1.1");
                if (_loc5_.category == FurniCategory.var_115)
                {
                    _loc22_ = this._roomEngine.getRoomImage(_loc17_, _loc5_.stuffData, _loc18_, 64, this);
                    if (_loc22_ != null)
                    {
                        _loc2_ = _loc22_.data;
                    };
                    this.setPreviewImage(_loc2_);
                    _loc9_ = "${inventory.furni.item.wallpaper.name}";
                    _loc10_ = "${inventory.furni.item.wallpaper.desc}";
                }
                else
                {
                    if (_loc5_.category == FurniCategory.var_117)
                    {
                        _loc22_ = this._roomEngine.getRoomImage(_loc5_.stuffData, _loc16_, _loc18_, 64, this);
                        if (_loc22_ != null)
                        {
                            _loc2_ = _loc22_.data;
                        };
                        this.setPreviewImage(_loc2_);
                        _loc9_ = "${inventory.furni.item.floor.name}";
                        _loc10_ = "${inventory.furni.item.floor.desc}";
                    }
                    else
                    {
                        if (_loc5_.category == FurniCategory.var_116)
                        {
                            _loc15_ = this._assetLibrary.getAssetByName("icon_landscape_png");
                            if (_loc15_ != null)
                            {
                                this.setPreviewImage((_loc15_.content as BitmapData));
                            };
                            _loc9_ = "${inventory.furni.item.landscape.name}";
                            _loc10_ = "${inventory.furni.item.landscape.desc}";
                        }
                        else
                        {
                            if (_loc5_.category == FurniCategory.var_598)
                            {
                                _loc9_ = (("${poster_" + _loc5_.stuffData) + "_name}");
                                _loc10_ = (("${poster_" + _loc5_.stuffData) + "_desc}");
                            };
                            _loc23_ = 0xFFFFFFFF;
                            if ((_loc5_ is FloorItem))
                            {
                                _loc22_ = this._roomEngine.getFurnitureImage(_loc4_.type, new Vector3d(180, 0, 0), 64, this, _loc23_, String(_loc4_.extra));
                            }
                            else
                            {
                                _loc22_ = this._roomEngine.getWallItemImage(_loc4_.type, new Vector3d(180, 0, 0), 64, this, _loc23_, _loc4_.stuffData);
                            };
                            if (_loc22_ != null)
                            {
                                _loc2_ = _loc22_.data;
                            };
                            this.setPreviewImage(_loc2_);
                            _loc4_.previewCallbackId = _loc22_.id;
                        };
                    };
                };
                _loc6_ = (this._view.findChildByName("tradeable_icon") as IBitmapWrapperWindow);
                _loc7_ = (this._view.findChildByName("tradeable_number") as ITextWindow);
                _loc8_ = (this._view.findChildByName("tradeable_info_region") as IRegionWindow);
                if ((((!(_loc6_ == null)) && (!(_loc7_ == null))) && (!(_loc8_ == null))))
                {
                    _loc21_ = _loc4_.getTradeableCount();
                    if (_loc21_ == 0)
                    {
                        _loc20_ = this._assetLibrary.getAssetByName("no_trade_icon_png");
                        _loc19_ = (_loc20_.content as BitmapData);
                        _loc7_.visible = false;
                        _loc8_.toolTipCaption = "${inventory.furni.preview.not_tradeable}";
                        _loc7_.filters = [];
                    }
                    else
                    {
                        _loc20_ = this._assetLibrary.getAssetByName("trade_icon_png");
                        _loc19_ = (_loc20_.content as BitmapData);
                        _loc7_.visible = true;
                        _loc7_.text = String(_loc21_);
                        _loc8_.toolTipCaption = "${inventory.furni.preview.tradeable_amount}";
                        _loc7_.filters = [new GlowFilter(0xFFFFFF, 1, 3, 3, 300)];
                    };
                    _loc6_.bitmap = new BitmapData(_loc6_.width, _loc6_.height, true, 0xFFFFFF);
                    if (_loc19_ != null)
                    {
                        _loc6_.bitmap.copyPixels(_loc19_, _loc19_.rect, new Point(0, 0), null, null, true);
                    };
                    _loc6_.invalidate();
                };
                _loc6_ = (this._view.findChildByName("recyclable_icon") as IBitmapWrapperWindow);
                _loc7_ = (this._view.findChildByName("recyclable_number") as ITextWindow);
                _loc8_ = (this._view.findChildByName("recyclable_info_region") as IRegionWindow);
                if ((((!(_loc6_ == null)) && (!(_loc7_ == null))) && (!(_loc8_ == null))))
                {
                    _loc21_ = _loc4_.getRecyclableCount();
                    if (_loc21_ == 0)
                    {
                        _loc20_ = this._assetLibrary.getAssetByName("no_recycle_icon_png");
                        _loc19_ = (_loc20_.content as BitmapData);
                        _loc7_.visible = false;
                        _loc8_.toolTipCaption = "${inventory.furni.preview.not_recyclable}";
                        _loc7_.filters = [];
                    }
                    else
                    {
                        _loc20_ = this._assetLibrary.getAssetByName("recycle_icon_png");
                        _loc19_ = (_loc20_.content as BitmapData);
                        _loc7_.visible = true;
                        _loc7_.text = String(_loc21_);
                        _loc8_.toolTipCaption = "${inventory.furni.preview.recyclable_amount}";
                        _loc7_.filters = [new GlowFilter(0xFFFFFF, 1, 3, 3, 300)];
                    };
                    _loc6_.bitmap = new BitmapData(_loc6_.width, _loc6_.height, true, 0xFFFFFF);
                    if (_loc19_ != null)
                    {
                        _loc6_.bitmap.copyPixels(_loc19_, _loc19_.rect, new Point(0, 0), null, null, true);
                    };
                    _loc6_.invalidate();
                };
            }
            else
            {
                this.setPreviewImage(null);
                _loc6_ = (this._view.findChildByName("tradeable_icon") as IBitmapWrapperWindow);
                _loc7_ = (this._view.findChildByName("tradeable_number") as ITextWindow);
                _loc8_ = (this._view.findChildByName("tradeable_info_region") as IRegionWindow);
                if ((((_loc6_) && (_loc7_)) && (_loc8_)))
                {
                    _loc6_.bitmap = null;
                    _loc7_.visible = false;
                };
                _loc6_ = (this._view.findChildByName("recyclable_icon") as IBitmapWrapperWindow);
                _loc7_ = (this._view.findChildByName("recyclable_number") as ITextWindow);
                _loc8_ = (this._view.findChildByName("recyclable_info_region") as IRegionWindow);
                if ((((_loc6_) && (_loc7_)) && (_loc8_)))
                {
                    _loc6_.bitmap = null;
                    _loc7_.visible = false;
                };
            };
            var _loc12_:Boolean = this.var_2446.isTradingOpen;
            _loc11_ = (this._view.findChildByName("placeinroom_btn") as IButtonWindow);
            if (_loc11_)
            {
                if (((_loc1_) && (this.var_2446.isPrivateRoom)))
                {
                    _loc11_.enable();
                }
                else
                {
                    _loc11_.disable();
                };
                _loc11_.visible = (!(_loc12_));
            };
            _loc11_ = (this._view.findChildByName("offertotrade_btn") as IButtonWindow);
            if (_loc11_)
            {
                if (((((_loc1_) && (!(_loc4_ == null))) && (!(_loc5_ == null))) && (this.var_2446.canUserOfferToTrade())))
                {
                    if (((_loc4_.getUnlockedCount()) && (_loc5_.tradeable)))
                    {
                        _loc11_.enable();
                    }
                    else
                    {
                        _loc11_.disable();
                    };
                }
                else
                {
                    _loc11_.disable();
                };
                _loc11_.visible = _loc12_;
            };
            _loc11_ = (this._view.findChildByName("sell_btn") as IButtonWindow);
            if (_loc11_)
            {
                if (((((_loc1_) && (this.var_2629)) && (this.var_2629.isEnabled)) && (_loc5_.sellable)))
                {
                    _loc11_.enable();
                }
                else
                {
                    _loc11_.disable();
                };
            };
            this.var_3564 = -1;
            if (_loc5_ != null)
            {
                if (_loc5_.category == FurniCategory.var_600)
                {
                    _loc24_ = _loc5_.extra;
                    _loc25_ = this._soundManager.musicController.getSongInfo(_loc24_);
                    if (_loc25_ != null)
                    {
                        _loc9_ = _loc25_.name;
                        _loc10_ = _loc25_.creator;
                    }
                    else
                    {
                        this._soundManager.musicController.requestSongInfoWithoutSamples(_loc24_);
                        this.var_3564 = _loc24_;
                    };
                };
            };
            var _loc13_:ITextWindow = (this._view.findChildByName("furni_name") as ITextWindow);
            if (_loc13_ != null)
            {
                if (_loc9_ != null)
                {
                    _loc13_.text = _loc9_;
                }
                else
                {
                    if (_loc5_ != null)
                    {
                        _loc13_.text = (("${roomItem.name." + _loc5_.type) + "}");
                    }
                    else
                    {
                        _loc13_.text = "";
                    };
                };
                Logger.log(("Name width: " + [_loc13_.width, _loc13_.textWidth, _loc13_.height, _loc13_.textHeight]));
                _loc13_.height = _loc13_.textHeight;
            };
            var _loc14_:ITextWindow = (this._view.findChildByName("furni_description") as ITextWindow);
            if (_loc14_ != null)
            {
                if (_loc10_ != null)
                {
                    _loc14_.text = _loc10_;
                }
                else
                {
                    if (_loc5_ != null)
                    {
                        _loc14_.text = (("${roomItem.desc." + _loc5_.type) + "}");
                    }
                    else
                    {
                        _loc14_.text = "";
                    };
                };
                _loc14_.height = (_loc14_.textHeight + 5);
            };
        }

        public function displayItemInfo(param1:GroupItem):void
        {
            var _loc2_:ImageResult;
            var _loc4_:IButtonWindow;
            if (this._view == null)
            {
                return;
            };
            if (this._view.disposed)
            {
                return;
            };
            var _loc3_:IItem = param1.peek();
            if ((_loc3_ is FloorItem))
            {
                _loc2_ = this._roomEngine.getFurnitureImage(param1.type, new Vector3d(2, 0, 0), 64, this, 0, String(param1.extra));
            }
            else
            {
                _loc2_ = this._roomEngine.getWallItemImage(param1.type, new Vector3d(2, 0, 0), 64, this, 0, param1.stuffData);
            };
            if (_loc2_ != null)
            {
                this.setPreviewImage(_loc2_.data);
            };
            _loc4_ = (this._view.findChildByName("placeinroom_btn") as IButtonWindow);
            if (_loc4_)
            {
                _loc4_.disable();
            };
            _loc4_ = (this._view.findChildByName("offertotrade_btn") as IButtonWindow);
            if (_loc4_)
            {
                _loc4_.disable();
            };
        }

        private function setPreviewImage(param1:BitmapData):void
        {
            var _loc2_:IBitmapWrapperWindow = (this._view.findChildByName("furni_preview_image") as IBitmapWrapperWindow);
            if (_loc2_ == null)
            {
                return;
            };
            if (param1 == null)
            {
                param1 = new BitmapData(20, 20);
            };
            var _loc3_:int = param1.height;
            if (_loc3_ > this.var_3561)
            {
                _loc3_ = this.var_3561;
            }
            else
            {
                if (_loc3_ < this.var_3560)
                {
                    _loc3_ = this.var_3560;
                }
                else
                {
                    _loc3_ = int((Math.ceil((_loc3_ / 10)) * 10));
                };
            };
            _loc2_.bitmap = new BitmapData(_loc2_.width, _loc3_, true, 0xFFFFFF);
            _loc2_.height = _loc3_;
            var _loc4_:Point = new Point(((_loc2_.width - param1.width) / 2), ((_loc3_ - param1.height) / 2));
            _loc2_.bitmap.copyPixels(param1, param1.rect, _loc4_, null, null, true);
            _loc2_.invalidate();
            var _loc5_:ITextWindow = (this._view.findChildByName("furni_description") as ITextWindow);
            if (_loc5_ != null)
            {
                _loc5_.y = ((_loc2_.y + _loc2_.height) + 5);
            };
        }

        public function imageReady(param1:int, param2:BitmapData):void
        {
            var _loc3_:GroupItem = this.var_2446.getGroupItemInIndex(this.var_2446.getSelectedItemIndex());
            if (_loc3_ == null)
            {
                return;
            };
            if (_loc3_.previewCallbackId == param1)
            {
                this.setPreviewImage(param2);
            };
        }

        private function windowEventProc(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                switch (param2.name)
                {
                    case "placeinroom_btn":
                        this.var_2446.requestSelectedFurniPlacement(false);
                        break;
                    case "offertotrade_btn":
                        this.var_2446.requestSelectedFurniToTrading();
                        break;
                    case "sell_btn":
                        this.var_2446.requestSelectedFurniSelling();
                        break;
                    case "open_catalog_btn":
                        this.var_2446.requestCatalogOpen();
                        break;
                    default:
                        this.var_2446.cancelFurniInMover();
                };
            }
            else
            {
                if (param1.type == WindowEvent.var_560)
                {
                    switch (param2.name)
                    {
                        case "tab_floor":
                            this.switchCategory(FurniModel.var_1222);
                            return;
                        case "tab_wall":
                            this.switchCategory(FurniModel.var_1223);
                            return;
                        case "tab_pets":
                            this.switchCategory(FurniModel.var_1235);
                            return;
                    };
                };
            };
        }

        private function onSongInfoReceivedEvent(param1:SongInfoReceivedEvent):void
        {
            if (param1.id == this.var_3564)
            {
                this.updateActionView();
                this.var_3564 = -1;
            };
        }

    }
}