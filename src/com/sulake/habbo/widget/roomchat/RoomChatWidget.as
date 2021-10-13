package com.sulake.habbo.widget.roomchat
{
    import com.sulake.habbo.widget.RoomWidgetBase;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import flash.geom.Point;
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.core.window.IWindow;
    import flash.utils.getTimer;
    import com.sulake.habbo.widget.events.RoomWidgetChatUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetRoomViewUpdateEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.widget.messages.RoomWidgetRoomObjectMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetChatSelectAvatarMessage;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class RoomChatWidget extends RoomWidgetBase implements IUpdateReceiver 
    {

        private static const var_1321:int = 18;
        private static const var_1335:int = 9;
        private static const var_1332:int = 10;
        private static const var_1334:int = 25;
        private static const var_1323:int = 25;
        private static const var_1325:int = 4000;
        private static const var_1331:int = 6000;
        private static const var_1324:int = 3;
        private static const var_1330:int = 1;
        private static const var_1319:int = 8;
        private static const var_1320:int = 0;
        private static const var_1338:int = (((var_1319 + var_1320) * var_1321) + var_1321);//162
        private static const var_1333:int = 9;

        private var var_4948:int = 0;
        private var var_4949:int = 0;
        private var var_2083:IWindowContainer;
        private var var_4946:IItemListWindow;
        private var _activeContentWindow:IWindowContainer;
        private var _itemList:Array = new Array();
        private var var_4950:Array = new Array();
        private var var_4951:Array = new Array();
        private var var_4952:int;
        private var var_4953:int = 0;
        private var var_4954:Number = 1;
        private var var_4955:String;
        private var var_4956:Number = 1;
        private var var_4957:Number = 0;
        private var var_4958:Point = new Point();
        private var var_4947:RoomChatHistoryViewer;
        private var var_2571:Boolean = false;
        private var var_4959:Boolean = false;
        private var var_3479:Component = null;
        private var var_4960:int = 150;
        private var var_4945:int = 171;
        private var var_4961:int = 18;

        public function RoomChatWidget(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IHabboLocalizationManager, param4:IHabboConfigurationManager, param5:int, param6:Component)
        {
            super(param1, param2, param3);
            this.var_4952 = param5;
            this.var_2083 = (param1.createWindow("chat_container", "", HabboWindowType.var_182, HabboWindowStyle.var_525, HabboWindowParam.var_156, new Rectangle(0, 0, 200, (this.var_4945 + RoomChatHistoryPulldown.var_1322)), null, 0) as IWindowContainer);
            this.var_2083.background = true;
            this.var_2083.color = 0x1FFFFFF;
            this.var_2083.tags.push("room_widget_chat");
            this.var_4946 = (param1.createWindow("chat_contentlist", "", HabboWindowType.var_194, HabboWindowStyle.var_156, (HabboWindowParam.var_158 | HabboWindowParam.var_805), new Rectangle(0, 0, 200, this.var_4945), null, 0) as IItemListWindow);
            this.var_2083.addChild(this.var_4946);
            this._activeContentWindow = (param1.createWindow("chat_active_content", "", HabboWindowType.var_182, HabboWindowStyle.var_156, HabboWindowParam.var_158, new Rectangle(0, 0, 200, this.var_4945), null, 0) as IWindowContainer);
            this._activeContentWindow.clipping = false;
            this.var_4946.addListItem(this._activeContentWindow);
            this.var_4947 = new RoomChatHistoryViewer(this, param1, this.var_2083, param2);
            this.var_4955 = param4.getKey("site.url");
            this.var_4960 = int(param4.getKey("chat.history.item.max.count", "150"));
            var _loc7_:Boolean = ((int(param4.getKey("chat.history.disabled", "0")) == 1) ? true : false);
            if (this.var_4947 != null)
            {
                this.var_4947.disabled = _loc7_;
            };
            if (param6 != null)
            {
                this.var_3479 = param6;
                this.var_3479.registerUpdateReceiver(this, 1);
            };
        }

        override public function get mainWindow():IWindow
        {
            return (this.var_2083);
        }

        override public function dispose():void
        {
            var _loc1_:RoomChatItem;
            var _loc2_:int;
            if (disposed)
            {
                return;
            };
            while (this.var_4951.length > 0)
            {
                _loc1_ = this.var_4951.shift();
            };
            this.var_4947.dispose();
            this.var_4947 = null;
            while (this._itemList.length > 0)
            {
                _loc1_ = this._itemList.shift();
                _loc1_.dispose();
            };
            while (this.var_4950.length > 0)
            {
                _loc1_ = this.var_4950.shift();
                _loc1_.dispose();
            };
            this.var_2083.dispose();
            if (this.var_3479 != null)
            {
                this.var_3479.removeUpdateReceiver(this);
                this.var_3479 = null;
            };
            super.dispose();
        }

        public function update(param1:uint):void
        {
            var _loc2_:int;
            if (((getTimer() > this.var_4948) && (this.var_4948 > 0)))
            {
                this.var_4948 = -1;
                this.animationStart();
            };
            if (this.var_2571)
            {
                _loc2_ = int(((param1 / var_1323) * var_1324));
                if ((_loc2_ + this.var_4949) > this.var_4961)
                {
                    _loc2_ = (this.var_4961 - this.var_4949);
                };
                if (_loc2_ > 0)
                {
                    this.moveItemsUp(_loc2_);
                    this.var_4949 = (this.var_4949 + _loc2_);
                };
                if (this.var_4949 >= this.var_4961)
                {
                    this.var_4961 = var_1321;
                    this.var_4949 = 0;
                    this.animationStop();
                    this.processBuffer();
                    this.var_4948 = (getTimer() + var_1325);
                };
            };
            if (this.var_4947 != null)
            {
                this.var_4947.update(param1);
            };
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.addEventListener(RoomWidgetChatUpdateEvent.var_1326, this.onChatMessage);
            param1.addEventListener(RoomWidgetRoomViewUpdateEvent.var_1327, this.onRoomViewUpdate);
            param1.addEventListener(RoomWidgetRoomViewUpdateEvent.var_1328, this.onRoomViewUpdate);
            param1.addEventListener(RoomWidgetRoomViewUpdateEvent.var_1329, this.onRoomViewUpdate);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.removeEventListener(RoomWidgetChatUpdateEvent.var_1326, this.onChatMessage);
            param1.removeEventListener(RoomWidgetRoomViewUpdateEvent.var_1327, this.onRoomViewUpdate);
            param1.removeEventListener(RoomWidgetRoomViewUpdateEvent.var_1328, this.onRoomViewUpdate);
            param1.removeEventListener(RoomWidgetRoomViewUpdateEvent.var_1329, this.onRoomViewUpdate);
        }

        private function onChatMessage(param1:RoomWidgetChatUpdateEvent):void
        {
            var _loc2_:RoomChatItem = new RoomChatItem(this, windowManager, assets, this.getFreeItemId(), localizations, this.var_4955);
            _loc2_.define(param1);
            if (this.var_4956 != 1)
            {
                _loc2_.senderX = (_loc2_.senderX / this.var_4956);
            };
            _loc2_.senderX = (_loc2_.senderX - this.var_4958.x);
            this.setChatItemLocHorizontal(_loc2_);
            this.var_4950.push(_loc2_);
            this.processBuffer();
        }

        private function onRoomViewUpdate(param1:RoomWidgetRoomViewUpdateEvent):void
        {
            var _loc2_:Rectangle = param1.rect;
            if (param1.scale > 0)
            {
                if (this.var_4957 == 0)
                {
                    this.var_4957 = param1.scale;
                }
                else
                {
                    this.var_4956 = (param1.scale / this.var_4957);
                };
            };
            if (param1.positionDelta != null)
            {
                this.var_4958.x = (this.var_4958.x + (param1.positionDelta.x / this.var_4956));
                this.var_4958.y = (this.var_4958.y + (param1.positionDelta.y / this.var_4956));
            };
            if (param1.rect != null)
            {
                if (this.var_4947 == null)
                {
                    return;
                };
                this.var_2083.width = _loc2_.width;
                this.var_2083.height = (this.var_4945 + this.var_4947.pulldownBarHeight);
                this.var_4946.width = (this.var_2083.width - this.var_4947.scrollbarWidth);
                this.var_4946.height = this.var_4945;
                this.var_4946.x = this.var_2083.x;
                this.var_4946.y = this.var_2083.y;
                this._activeContentWindow.width = (this.var_2083.width - this.var_4947.scrollbarWidth);
                this._activeContentWindow.height = this.var_4945;
                if (this.historyViewerActive())
                {
                    this.reAlignItemsToHistoryContent();
                };
                this.var_4947.containerResized(this.var_2083.rectangle, true);
            };
            this.alignItems();
        }

        private function processBuffer():void
        {
            if (this.var_2571)
            {
                return;
            };
            if (this.var_4950.length == 0)
            {
                return;
            };
            while (((this.var_4950.length > var_1330) || ((this.historyViewerActive()) && (this.var_4950.length > 0))))
            {
                this.activateItemFromBuffer();
            };
            var _loc1_:Boolean;
            if (this._itemList.length == 0)
            {
                _loc1_ = true;
            }
            else
            {
                _loc1_ = this.checkLastItemAllowsAdding(this.var_4950[0]);
            };
            if (_loc1_)
            {
                this.activateItemFromBuffer();
                this.var_4948 = (getTimer() + var_1325);
            }
            else
            {
                if (((this._itemList.length > 0) && (this.var_4950.length > 0)))
                {
                    this.var_4961 = this.getItemSpacing(this._itemList[(this._itemList.length - 1)], this.var_4950[0]);
                }
                else
                {
                    this.var_4961 = var_1321;
                };
                this.animationStart();
            };
        }

        private function activateItemFromBuffer():void
        {
            var _loc1_:RoomChatItem;
            var _loc2_:IWindowContainer;
            var _loc3_:int;
            if (this.var_4950.length == 0)
            {
                return;
            };
            if (this.historyViewerMinimized())
            {
                this.resetArea();
                this.hideHistoryViewer();
            };
            if (!this.checkLastItemAllowsAdding(this.var_4950[0]))
            {
                this.selectItemsToMove();
                this.moveItemsUp(this.getItemSpacing(this._itemList[(this._itemList.length - 1)], this.var_4950[0]));
                if (!this.checkLastItemAllowsAdding(this.var_4950[0]))
                {
                    this._activeContentWindow.height = (this._activeContentWindow.height + var_1321);
                    if (this.var_4947 != null)
                    {
                        this.var_4947.containerResized(this.var_2083.rectangle);
                    };
                };
            };
            _loc1_ = this.var_4950.shift();
            if (_loc1_ != null)
            {
                _loc1_.renderView();
                _loc2_ = _loc1_.view;
                if (_loc2_ != null)
                {
                    this._activeContentWindow.addChild(_loc2_);
                    _loc1_.timeStamp = new Date().time;
                    this._itemList.push(_loc1_);
                    _loc3_ = 0;
                    if (this._itemList.length > 1)
                    {
                        _loc3_ = this._itemList[(this._itemList.length - 2)].screenLevel;
                        if (this.historyViewerActive())
                        {
                            _loc1_.screenLevel = (_loc3_ + 1);
                        }
                        else
                        {
                            _loc1_.screenLevel = (_loc3_ + Math.max(this.var_4954, 1));
                        };
                    }
                    else
                    {
                        _loc1_.screenLevel = 100;
                    };
                    _loc1_.aboveLevels = this.var_4954;
                    if (_loc1_.aboveLevels > ((var_1319 + var_1320) + 2))
                    {
                        _loc1_.aboveLevels = ((var_1319 + var_1320) + 2);
                    };
                    this.var_4954 = 0;
                    this.setChatItemLocHorizontal(_loc1_);
                    this.setChatItemLocVertical(_loc1_);
                    this.setChatItemRenderable(_loc1_);
                };
            };
        }

        private function checkLastItemAllowsAdding(param1:RoomChatItem):Boolean
        {
            if (this._itemList.length == 0)
            {
                return (true);
            };
            var _loc2_:RoomChatItem = this._itemList[(this._itemList.length - 1)];
            if (((param1 == null) || (_loc2_ == null)))
            {
                return (false);
            };
            if (_loc2_.view == null)
            {
                return (true);
            };
            if ((this._activeContentWindow.rectangle.bottom - ((this._activeContentWindow.y + _loc2_.y) + _loc2_.height)) <= this.getItemSpacing(_loc2_, param1))
            {
                return (false);
            };
            return (true);
        }

        private function alignItems():void
        {
            var _loc1_:int;
            var _loc2_:RoomChatItem;
            var _loc3_:IWindowContainer;
            if (this.var_4947 == null)
            {
                return;
            };
            _loc1_ = (this._itemList.length - 1);
            while (_loc1_ >= 0)
            {
                _loc2_ = this._itemList[_loc1_];
                if (_loc2_ != null)
                {
                    this.setChatItemLocHorizontal(_loc2_);
                    this.setChatItemLocVertical(_loc2_);
                };
                _loc1_--;
            };
            _loc1_ = 0;
            while (_loc1_ < this._itemList.length)
            {
                _loc2_ = this._itemList[_loc1_];
                if (_loc2_ != null)
                {
                    this.setChatItemRenderable(_loc2_);
                };
                _loc1_++;
            };
            _loc1_ = 0;
            while (_loc1_ < this.var_4950.length)
            {
                _loc2_ = this.var_4950[_loc1_];
                if (_loc2_ != null)
                {
                    this.setChatItemLocHorizontal(_loc2_);
                };
                _loc1_++;
            };
        }

        private function animationStart():void
        {
            if (this.var_2571)
            {
                return;
            };
            this.selectItemsToMove();
            this.var_2571 = true;
        }

        private function animationStop():void
        {
            this.var_2571 = false;
        }

        private function selectItemsToMove():void
        {
            var _loc4_:RoomChatItem;
            if (this.var_2571)
            {
                return;
            };
            this.purgeItems();
            this.var_4951 = new Array();
            var _loc1_:int = new Date().time;
            var _loc2_:int;
            if (this._itemList.length == 0)
            {
                this.var_4954 = 1;
                return;
            };
            if (this.historyViewerActive())
            {
                return;
            };
            this.var_4954++;
            var _loc3_:int = (this._itemList.length - 1);
            while (_loc3_ >= 0)
            {
                _loc4_ = this._itemList[_loc3_];
                if (_loc4_.view != null)
                {
                    if ((((_loc4_.screenLevel > var_1320) || (_loc4_.screenLevel == (_loc2_ - 1))) || ((_loc1_ - _loc4_.timeStamp) >= var_1331)))
                    {
                        _loc4_.timeStamp = _loc1_;
                        _loc2_ = _loc4_.screenLevel;
                        _loc4_.screenLevel--;
                        this.var_4951.push(_loc4_);
                    };
                };
                _loc3_--;
            };
        }

        private function moveItemsUp(param1:int):void
        {
            var _loc3_:Boolean;
            if (this.var_4951 == null)
            {
                return;
            };
            if (this.var_4951.length == 0)
            {
                return;
            };
            var _loc2_:RoomChatItem;
            var _loc4_:int = -1;
            var _loc5_:int = (this.var_4951.length - 1);
            while (_loc5_ >= 0)
            {
                _loc2_ = this.var_4951[_loc5_];
                if (_loc2_ != null)
                {
                    if (_loc4_ == -1)
                    {
                        _loc4_ = this._itemList.indexOf(_loc2_);
                    }
                    else
                    {
                        _loc4_++;
                    };
                    _loc3_ = true;
                    if (this.historyViewerActive())
                    {
                        if (((_loc2_.y - param1) + _loc2_.height) < 0)
                        {
                            _loc3_ = false;
                        };
                    };
                    if (_loc4_ > 0)
                    {
                        if (this._itemList[(_loc4_ - 1)].view != null)
                        {
                            if (((_loc2_.y - param1) - this._itemList[(_loc4_ - 1)].y) < this.getItemSpacing(this._itemList[(_loc4_ - 1)], _loc2_))
                            {
                                _loc3_ = false;
                            };
                        };
                    };
                    if (_loc3_)
                    {
                        _loc2_.y = (_loc2_.y - param1);
                    };
                };
                _loc5_--;
            };
        }

        private function setChatItemLocHorizontal(param1:RoomChatItem):void
        {
            var _loc9_:Number;
            var _loc10_:Number;
            if (((param1 == null) || (this.var_4947 == null)))
            {
                return;
            };
            var _loc2_:Number = ((param1.senderX + this.var_4958.x) * this.var_4956);
            var _loc3_:Number = (_loc2_ - (param1.width / 2));
            var _loc4_:Number = (_loc3_ + param1.width);
            var _loc5_:Number = ((-(this.var_2083.width) / 2) - var_1332);
            var _loc6_:Number = (((this.var_2083.width / 2) + var_1332) - this.var_4947.scrollbarWidth);
            var _loc7_:Boolean = ((_loc3_ >= _loc5_) && (_loc3_ <= _loc6_));
            var _loc8_:Boolean = ((_loc4_ >= _loc5_) && (_loc4_ <= _loc6_));
            if (((_loc7_) && (_loc8_)))
            {
                _loc9_ = _loc3_;
                _loc10_ = _loc9_;
            }
            else
            {
                if (_loc2_ >= 0)
                {
                    _loc9_ = (_loc6_ - param1.width);
                }
                else
                {
                    _loc9_ = _loc5_;
                };
            };
            param1.x = ((_loc9_ + (this.var_2083.width / 2)) + this.var_2083.x);
            if (((_loc2_ < _loc5_) || (_loc2_ > _loc6_)))
            {
                param1.hidePointer();
            }
            else
            {
                param1.setPointerOffset((_loc3_ - _loc9_));
            };
        }

        private function setChatItemLocVertical(param1:RoomChatItem):void
        {
            var _loc2_:int;
            var _loc3_:Number;
            var _loc4_:Number;
            if (param1 != null)
            {
                _loc2_ = this._itemList.indexOf(param1);
                _loc3_ = ((this.historyViewerActive()) ? 0 : this.var_4954);
                if (_loc2_ == (this._itemList.length - 1))
                {
                    param1.y = ((this.getAreaBottom() - ((_loc3_ + 1) * var_1321)) - var_1333);
                }
                else
                {
                    _loc4_ = this._itemList[(_loc2_ + 1)].aboveLevels;
                    if (_loc4_ < 2)
                    {
                        param1.y = (this._itemList[(_loc2_ + 1)].y - this.getItemSpacing(param1, this._itemList[(_loc2_ + 1)]));
                    }
                    else
                    {
                        param1.y = (this._itemList[(_loc2_ + 1)].y - (_loc4_ * var_1321));
                    };
                };
            };
        }

        private function setChatItemRenderable(param1:RoomChatItem):void
        {
            if (param1 != null)
            {
                if (param1.y < -(var_1334))
                {
                    if (param1.view != null)
                    {
                        this._activeContentWindow.removeChild(param1.view);
                        param1.hideView();
                    };
                }
                else
                {
                    if (param1.view == null)
                    {
                        param1.renderView();
                        if (param1.view != null)
                        {
                            this._activeContentWindow.addChild(param1.view);
                        };
                    };
                };
            };
        }

        public function getTotalContentHeight():int
        {
            var _loc1_:RoomChatItem;
            var _loc2_:int;
            var _loc3_:int;
            while (_loc3_ < this._itemList.length)
            {
                _loc1_ = this._itemList[_loc3_];
                if (_loc1_ != null)
                {
                    if (_loc3_ == 0)
                    {
                        _loc2_ = (_loc2_ + var_1321);
                    }
                    else
                    {
                        _loc2_ = (_loc2_ + this.getItemSpacing(this._itemList[(_loc3_ - 1)], _loc1_));
                    };
                    _loc2_ = (_loc2_ + ((_loc1_.aboveLevels - 1) * var_1321));
                };
                _loc3_++;
            };
            return (_loc2_);
        }

        private function getAreaBottom():Number
        {
            if (this.historyViewerActive())
            {
                return (this._activeContentWindow.height);
            };
            return (this.var_4945 + this.var_2083.y);
        }

        private function getItemSpacing(param1:RoomChatItem, param2:RoomChatItem):Number
        {
            if (param1.checkOverlap(param2.x, param1.y, param2.width, param2.height))
            {
                return (var_1321);
            };
            return (var_1335);
        }

        private function purgeItems():void
        {
            var _loc2_:RoomChatItem;
            if (this.historyViewerActive())
            {
                return;
            };
            var _loc1_:int;
            var _loc3_:int;
            while (this._itemList.length > this.var_4960)
            {
                _loc2_ = this._itemList.shift();
                _loc3_ = this.var_4951.indexOf(_loc2_);
                if (_loc3_ > -1)
                {
                    this.var_4951.splice(_loc3_, 1);
                };
                if (_loc2_.view != null)
                {
                    this._activeContentWindow.removeChild(_loc2_.view);
                    _loc2_.hideView();
                };
                _loc2_.dispose();
                _loc2_ = null;
            };
            var _loc4_:Boolean;
            _loc1_ = 0;
            while (_loc1_ < this._itemList.length)
            {
                _loc2_ = this._itemList[_loc1_];
                if (_loc2_ != null)
                {
                    if (_loc2_.y <= -(var_1334))
                    {
                        _loc2_.aboveLevels = 1;
                        if (_loc2_.view != null)
                        {
                            _loc3_ = this.var_4951.indexOf(_loc2_);
                            if (_loc3_ > -1)
                            {
                                this.var_4951.splice(_loc3_, 1);
                            };
                            this._activeContentWindow.removeChild(_loc2_.view);
                            _loc2_.hideView();
                        };
                    }
                    else
                    {
                        _loc4_ = true;
                        break;
                    };
                };
                _loc1_++;
            };
            if (this.var_4950.length > 0)
            {
                _loc4_ = true;
            };
            if ((((this.getTotalContentHeight() > var_1321) && (!(_loc4_))) && (!(this.historyViewerActive()))))
            {
                if (this.var_4947 != null)
                {
                    this.stretchAreaBottomTo(this.var_2083.y);
                    this.alignItems();
                    if (!this.historyViewerActive())
                    {
                        this.var_4947.showHistoryViewer();
                    };
                    if (!this.historyViewerVisible())
                    {
                        this.var_4947.visible = true;
                    };
                };
            }
            else
            {
                if (this.historyViewerVisible())
                {
                    this.var_4947.visible = false;
                };
            };
        }

        private function getFreeItemId():String
        {
            return ((("chat_" + this.var_4952.toString()) + "_item_") + (this.var_4953++).toString());
        }

        public function onItemMouseClick(param1:int, param2:String, param3:int, param4:int, param5:int, param6:WindowMouseEvent):void
        {
            if (param6.shiftKey)
            {
                if (this.var_4947 != null)
                {
                    this.var_4947.toggleHistoryViewer();
                };
                return;
            };
            var _loc7_:RoomWidgetRoomObjectMessage = new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.var_1336, param1, param3);
            messageListener.processWidgetMessage(_loc7_);
            var _loc8_:RoomWidgetChatSelectAvatarMessage = new RoomWidgetChatSelectAvatarMessage(RoomWidgetChatSelectAvatarMessage.var_1337, param1, param2, param4, param5);
            messageListener.processWidgetMessage(_loc8_);
        }

        public function onItemMouseDown(param1:int, param2:int, param3:int, param4:int, param5:WindowMouseEvent):void
        {
            if (this.historyViewerVisible())
            {
                return;
            };
            if (this.var_4947 != null)
            {
                this.var_4947.beginDrag(param5.stageY);
            };
        }

        public function onItemMouseOver(param1:int, param2:int, param3:int, param4:int, param5:WindowMouseEvent):void
        {
        }

        public function onItemMouseOut(param1:int, param2:int, param3:int, param4:int, param5:WindowMouseEvent):void
        {
        }

        public function onPulldownMouseDown(param1:WindowMouseEvent):void
        {
            if (this.var_4947 != null)
            {
                this.var_4947.beginDrag(param1.stageY, true);
            };
        }

        public function onPulldownCloseButtonClicked(param1:WindowMouseEvent):void
        {
            if (this.var_4947 != null)
            {
                this.var_4947.hideHistoryViewer();
            };
        }

        public function stretchAreaBottomBy(param1:Number):void
        {
            var _loc2_:Number = ((this.var_2083.rectangle.bottom + param1) - RoomChatHistoryPulldown.var_1322);
            this.stretchAreaBottomTo(_loc2_);
        }

        public function stretchAreaBottomTo(param1:Number):void
        {
            var _loc2_:int = (this.var_2083.context.getDesktopWindow().height - RoomChatHistoryPulldown.var_1322);
            param1 = Math.min(param1, _loc2_);
            this.var_4945 = (param1 - this.var_2083.y);
            this.var_2083.height = (this.var_4945 + RoomChatHistoryPulldown.var_1322);
            if (this.var_4947 != null)
            {
                this.var_4947.containerResized(this.var_2083.rectangle);
            };
        }

        public function resetArea():void
        {
            if (this.var_4947 == null)
            {
                return;
            };
            this.animationStop();
            this.var_4945 = (var_1338 + var_1333);
            this.var_2083.height = (this.var_4945 + this.var_4947.pulldownBarHeight);
            this.var_4946.width = (this.var_2083.width - this.var_4947.scrollbarWidth);
            this.var_4946.height = this.var_4945;
            this._activeContentWindow.width = (this.var_2083.width - this.var_4947.scrollbarWidth);
            if (this.historyViewerActive())
            {
                this._activeContentWindow.height = (this.getTotalContentHeight() + var_1333);
            }
            else
            {
                this._activeContentWindow.height = this.var_4945;
            };
            this.var_4946.scrollV = 1;
            if (!this.historyViewerActive())
            {
                this.var_4947.containerResized(this.var_2083.rectangle);
            };
            this.purgeItems();
            this.alignItems();
        }

        private function historyViewerActive():Boolean
        {
            return ((this.var_4947 == null) ? false : this.var_4947.active);
        }

        private function historyViewerVisible():Boolean
        {
            return ((this.var_4947 == null) ? false : this.var_4947.visible);
        }

        public function hideHistoryViewer():void
        {
            if (this.var_4947 != null)
            {
                this.var_4947.hideHistoryViewer();
            };
        }

        private function historyViewerMinimized():Boolean
        {
            return (this.var_4946.height <= 1);
        }

        public function resizeContainerToLowestItem():void
        {
            var _loc4_:RoomChatItem;
            var _loc1_:int;
            var _loc2_:int;
            while (_loc2_ < this._itemList.length)
            {
                _loc4_ = this._itemList[_loc2_];
                if (_loc4_.y > _loc1_)
                {
                    _loc1_ = _loc4_.y;
                };
                _loc2_++;
            };
            _loc2_ = 0;
            while (_loc2_ < this.var_4950.length)
            {
                _loc4_ = this.var_4950[_loc2_];
                if (_loc4_.y > _loc1_)
                {
                    _loc1_ = _loc4_.y;
                };
                _loc2_++;
            };
            _loc1_ = (_loc1_ + var_1334);
            _loc1_ = ((_loc1_ < 0) ? 0 : _loc1_);
            var _loc3_:int = this.var_2083.rectangle.bottom;
            this.stretchAreaBottomTo((this.var_2083.rectangle.top + _loc1_));
            _loc3_ = (_loc3_ - this.var_2083.rectangle.bottom);
            if (Math.abs(_loc3_) < RoomChatHistoryViewer.var_1339)
            {
                this.resetArea();
                return;
            };
            _loc2_ = 0;
            while (_loc2_ < this._itemList.length)
            {
                _loc4_ = this._itemList[_loc2_];
                _loc4_.y = (_loc4_.y + _loc3_);
                _loc2_++;
            };
            _loc2_ = 0;
            while (_loc2_ < this.var_4950.length)
            {
                _loc4_ = this.var_4950[_loc2_];
                _loc4_.y = (_loc4_.y + _loc3_);
                _loc2_++;
            };
            this.var_4959 = true;
        }

        public function mouseUp():void
        {
            var _loc1_:Number = (this.var_2083.rectangle.bottom - RoomChatHistoryPulldown.var_1322);
            if (_loc1_ < var_1338)
            {
                if (_loc1_ <= (this.var_4945 + this.var_2083.y))
                {
                    if (this.historyViewerActive())
                    {
                        this.hideHistoryViewer();
                    };
                    this.resetArea();
                    return;
                };
            };
            if (((this.var_4959) && (!(this.historyViewerActive()))))
            {
                this.resetArea();
                this.var_4959 = false;
            };
        }

        public function reAlignItemsToHistoryContent():void
        {
            if (this.historyViewerActive())
            {
                this._activeContentWindow.height = (this.getTotalContentHeight() + var_1333);
                this.alignItems();
            };
        }

        public function enableDragTooltips():void
        {
            var _loc2_:int;
            var _loc1_:RoomChatItem;
            _loc2_ = 0;
            while (_loc2_ < this._itemList.length)
            {
                _loc1_ = this._itemList[_loc2_];
                _loc1_.enableTooltip();
                _loc2_++;
            };
            _loc2_ = 0;
            while (_loc2_ < this.var_4950.length)
            {
                _loc1_ = this.var_4950[_loc2_];
                _loc1_.enableTooltip();
                _loc2_++;
            };
        }

        public function disableDragTooltips():void
        {
            var _loc2_:int;
            var _loc1_:RoomChatItem;
            _loc2_ = 0;
            while (_loc2_ < this._itemList.length)
            {
                _loc1_ = this._itemList[_loc2_];
                _loc1_.disableTooltip();
                _loc2_++;
            };
            _loc2_ = 0;
            while (_loc2_ < this.var_4950.length)
            {
                _loc1_ = this.var_4950[_loc2_];
                _loc1_.disableTooltip();
                _loc2_++;
            };
        }

    }
}