package com.sulake.habbo.widget.roomchat
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.IScrollableWindow;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.display.DisplayObject;
    import flash.display.Stage;
    import flash.events.MouseEvent;

    public class RoomChatHistoryViewer implements IDisposable 
    {

        private static const var_4919:int = 18;
        private static const SCROLLBAR_WIDTH:int = 20;
        public static const var_1339:int = 3;

        private var var_4917:RoomChatHistoryPulldown;
        private var var_4920:Boolean = false;
        private var var_4921:Number = -1;
        private var var_4918:IScrollbarWindow;
        private var var_4922:Number = 1;
        private var var_3917:Boolean = false;
        private var _widget:RoomChatWidget;
        private var var_978:Boolean = false;
        private var var_4923:Boolean = false;
        private var var_4924:Boolean = false;

        public function RoomChatHistoryViewer(param1:RoomChatWidget, param2:IHabboWindowManager, param3:IWindowContainer, param4:IAssetLibrary)
        {
            this.var_978 = false;
            this._widget = param1;
            this.var_4917 = new RoomChatHistoryPulldown(param1, param2, param3, param4);
            this.var_4917.state = RoomChatHistoryPulldown.var_1833;
            var _loc5_:IItemListWindow = (param3.getChildByName("chat_contentlist") as IItemListWindow);
            if (_loc5_ == null)
            {
                return;
            };
            param3.removeChild(_loc5_);
            param3.addChild(_loc5_);
            this.var_4918 = (param2.createWindow("chatscroller", "", HabboWindowType.var_195, HabboWindowStyle.var_156, (HabboWindowParam.var_158 | HabboWindowParam.var_156), new Rectangle((param3.rectangle.right - SCROLLBAR_WIDTH), param3.y, SCROLLBAR_WIDTH, (param3.height - RoomChatHistoryPulldown.var_1322)), null, 0) as IScrollbarWindow);
            param3.addChild(this.var_4918);
            this.var_4918.visible = false;
            this.var_4918.scrollable = (_loc5_ as IScrollableWindow);
        }

        public function set disabled(param1:Boolean):void
        {
            this.var_3917 = param1;
        }

        public function set visible(param1:Boolean):void
        {
            if (this.var_4917 == null)
            {
                return;
            };
            this.var_4917.state = ((param1 == true) ? RoomChatHistoryPulldown.var_1834 : RoomChatHistoryPulldown.var_1833);
        }

        public function get active():Boolean
        {
            return (this.var_4920);
        }

        public function get scrollbarWidth():Number
        {
            return ((this.var_4920) ? SCROLLBAR_WIDTH : 0);
        }

        public function get pulldownBarHeight():Number
        {
            return (RoomChatHistoryPulldown.var_1322);
        }

        public function get disposed():Boolean
        {
            return (this.var_978);
        }

        public function get visible():Boolean
        {
            if (this.var_4917 == null)
            {
                return (false);
            };
            return ((this.var_4917.state == RoomChatHistoryPulldown.var_1834) || (this.var_4917.state == RoomChatHistoryPulldown.var_1835));
        }

        public function dispose():void
        {
            this.hideHistoryViewer();
            if (this.var_4918 != null)
            {
                this.var_4918.dispose();
                this.var_4918 = null;
            };
            if (this.var_4917 != null)
            {
                this.var_4917.dispose();
                this.var_4917 = null;
            };
            this.var_978 = true;
        }

        public function update(param1:uint):void
        {
            if (this.var_4917 != null)
            {
                this.var_4917.update(param1);
            };
            this.moveHistoryScroll();
        }

        public function toggleHistoryViewer():void
        {
            if (this.var_4920)
            {
                this.hideHistoryViewer();
            }
            else
            {
                this.showHistoryViewer();
            };
        }

        public function hideHistoryViewer():void
        {
            this.var_4922 = 1;
            this.cancelDrag();
            this.var_4920 = false;
            this.setHistoryViewerScrollbar(false);
            this.var_4917.state = RoomChatHistoryPulldown.var_1833;
            if (this._widget != null)
            {
                this._widget.resetArea();
                this._widget.enableDragTooltips();
            };
        }

        public function showHistoryViewer():void
        {
            var _loc1_:RoomChatItem;
            var _loc2_:int;
            var _loc3_:IWindowContainer;
            if (((!(this.var_4920)) && (!(this.var_3917))))
            {
                this.var_4920 = true;
                this.setHistoryViewerScrollbar(true);
                this.var_4917.state = RoomChatHistoryPulldown.var_1834;
                if (this._widget != null)
                {
                    this._widget.reAlignItemsToHistoryContent();
                    this._widget.disableDragTooltips();
                };
            };
        }

        private function setHistoryViewerScrollbar(param1:Boolean):void
        {
            if (this.var_4918 != null)
            {
                this.var_4918.visible = param1;
                if (param1)
                {
                    this.var_4918.scrollV = 1;
                    this.var_4922 = 1;
                }
                else
                {
                    this.var_4920 = false;
                    this.var_4921 = -1;
                };
            };
        }

        public function containerResized(param1:Rectangle, param2:Boolean=false):void
        {
            if (this.var_4918 != null)
            {
                this.var_4918.x = ((param1.x + param1.width) - this.var_4918.width);
                this.var_4918.y = param1.y;
                this.var_4918.height = (param1.height - RoomChatHistoryPulldown.var_1322);
                if (param2)
                {
                    this.var_4918.scrollV = this.var_4922;
                };
            };
            if (this.var_4917 != null)
            {
                this.var_4917.containerResized(param1);
            };
        }

        private function processDrag(param1:Number, param2:Boolean=false):void
        {
            var _loc3_:Number;
            var _loc4_:Number;
            var _loc5_:Number;
            var _loc6_:int;
            var _loc7_:Boolean;
            var _loc8_:Boolean;
            if (((this.var_4921 > 0) && (param2)))
            {
                if (this.var_4924)
                {
                    if (Math.abs((param1 - this.var_4921)) > var_1339)
                    {
                        this.var_4924 = false;
                    }
                    else
                    {
                        return;
                    };
                };
                if (!this.var_4920)
                {
                    this._widget.resizeContainerToLowestItem();
                    this.showHistoryViewer();
                    this.moveHistoryScroll();
                };
                if (this.var_4920)
                {
                    this.moveHistoryScroll();
                    _loc4_ = (this.var_4918.scrollable.scrollableRegion.height / this.var_4918.scrollable.visibleRegion.height);
                    _loc5_ = ((param1 - this.var_4921) / this.var_4918.height);
                    _loc3_ = (this.var_4922 - (_loc5_ / _loc4_));
                    _loc3_ = Math.max(0, _loc3_);
                    _loc3_ = Math.min(1, _loc3_);
                    _loc6_ = (param1 - this.var_4921);
                    _loc7_ = true;
                    _loc8_ = true;
                    if (this.var_4918.scrollV < (1 - (var_4919 / this.var_4918.scrollable.scrollableRegion.height)))
                    {
                        _loc8_ = false;
                    };
                    if (((_loc8_) || (this.var_4923)))
                    {
                        this._widget.stretchAreaBottomBy(_loc6_);
                        _loc7_ = false;
                        this.var_4918.scrollV = 1;
                    };
                    if (_loc7_)
                    {
                        this.var_4922 = _loc3_;
                    };
                    this.var_4921 = param1;
                };
            }
            else
            {
                this.var_4921 = -1;
            };
        }

        public function beginDrag(param1:Number, param2:Boolean=false):void
        {
            var _loc3_:DisplayObject;
            var _loc4_:Stage;
            this.var_4921 = param1;
            this.var_4923 = param2;
            this.var_4924 = true;
            if (this.var_4918 != null)
            {
                this.var_4922 = this.var_4918.scrollV;
            };
            if (this.var_4918 != null)
            {
                _loc3_ = this.var_4918.context.getDesktopWindow().getDisplayObject();
                if (_loc3_ != null)
                {
                    _loc4_ = _loc3_.stage;
                    if (_loc4_ != null)
                    {
                        _loc4_.addEventListener(MouseEvent.MOUSE_MOVE, this.onStageMouseMove);
                        _loc4_.addEventListener(MouseEvent.MOUSE_UP, this.onStageMouseUp);
                    };
                };
            };
        }

        public function cancelDrag():void
        {
            var _loc1_:DisplayObject;
            var _loc2_:Stage;
            this.var_4921 = -1;
            if (this.var_4918 != null)
            {
                _loc1_ = this.var_4918.context.getDesktopWindow().getDisplayObject();
                if (_loc1_ != null)
                {
                    _loc2_ = _loc1_.stage;
                    if (_loc2_ != null)
                    {
                        _loc2_.removeEventListener(MouseEvent.MOUSE_MOVE, this.onStageMouseMove);
                        _loc2_.removeEventListener(MouseEvent.MOUSE_UP, this.onStageMouseUp);
                    };
                };
            };
        }

        private function moveHistoryScroll():void
        {
            if (!this.var_4920)
            {
                return;
            };
            if (this.var_4921 == -1)
            {
                return;
            };
            if (this.var_4923)
            {
                return;
            };
            var _loc1_:Number = (this.var_4922 - this.var_4918.scrollV);
            if (_loc1_ == 0)
            {
                return;
            };
            if (Math.abs(_loc1_) < 0.01)
            {
                this.var_4918.scrollV = this.var_4922;
            }
            else
            {
                this.var_4918.scrollV = (this.var_4918.scrollV + (_loc1_ / 2));
            };
        }

        private function onStageMouseUp(param1:MouseEvent):void
        {
            this.cancelDrag();
            if (this._widget != null)
            {
                this._widget.mouseUp();
            };
        }

        private function onStageMouseMove(param1:MouseEvent):void
        {
            this.processDrag(param1.stageY, param1.buttonDown);
        }

    }
}