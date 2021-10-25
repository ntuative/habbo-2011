package com.sulake.habbo.widget.roomchat
{

    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.assets.IAssetLibrary;

    import flash.display.BitmapData;

    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.habbo.widget.events.RoomWidgetChatUpdateEvent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;

    import flash.geom.Rectangle;
    import flash.text.TextFormat;

    import com.sulake.core.window.components.ILabelWindow;
    import com.sulake.core.window.components.ITextWindow;

    import flash.geom.Point;
    import flash.geom.ColorTransform;
    import flash.display.BlendMode;
    import flash.geom.Matrix;

    import com.sulake.habbo.window.enum.HabboWindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.utils.HabboWebTools;

    public class RoomChatItem
    {

        private static const HEIGHT: Number = 18;
        private static const var_4930: int = 6;
        private static const var_4931: int = 6;
        private static const var_4932: int = 35;
        private static const NAME: String = "name";
        private static const MESSAGE: String = "message";
        private static const POINTER: String = "pointer";
        private static const BACKGROUND: String = "background";
        private static var var_4928: IRegionWindow;
        private static var var_4926: IRegionWindow;
        private static var var_4925: IRegionWindow;
        private static var var_4927: IRegionWindow;

        private var _widget: RoomChatWidget;
        private var _windowManager: IHabboWindowManager;
        private var _localization: IHabboLocalizationManager;
        private var _window: IRegionWindow;
        private var _assetLibrary: IAssetLibrary;
        private var _id: String;
        private var var_4934: String;
        private var _aboveLevels: int = 0;
        private var _screenLevel: int = -1;
        private var var_4404: int;
        private var var_3158: int;
        private var var_2907: String = "";
        private var _message: String = "";
        private var var_4937: Array;
        private var var_4938: Array;
        private var _timestamp: int;
        private var _senderX: Number;
        private var var_4940: BitmapData;
        private var var_4941: uint;
        private var _roomId: int;
        private var _roomCategory: int;
        private var var_4942: int;
        private var _width: Number = 0;
        private var var_4943: Boolean = false;
        private var var_4944: Number = 0;
        private var _x: Number = 0;
        private var _y: Number = 0;

        public function RoomChatItem(param1: RoomChatWidget, param2: IHabboWindowManager, param3: IAssetLibrary, param4: String, param5: IHabboLocalizationManager, param6: String)
        {
            this._widget = param1;
            this._windowManager = param2;
            this._assetLibrary = param3;
            this._id = param4;
            this._localization = param5;
            this.var_4934 = param6;
            if (!var_4925)
            {
                var_4925 = (this._windowManager.buildFromXML(this._assetLibrary.getAssetByName("bubble_speak").content as XML, 1) as IRegionWindow);
                var_4925.tags.push("roomchat_bubble");
                var_4925.x = 0;
                var_4925.y = 0;
                var_4925.width = 0;
                var_4925.background = true;
                var_4925.mouseThreshold = 0;
                var_4925.setParamFlag(WindowParam.WINDOW_PARAM_FORCE_CLIPPING, true);
            }

            if (!var_4926)
            {
                var_4926 = (this._windowManager.buildFromXML(this._assetLibrary.getAssetByName("bubble_shout").content as XML, 1) as IRegionWindow);
                var_4926.tags.push("roomchat_bubble");
                var_4926.x = 0;
                var_4926.y = 0;
                var_4926.width = 0;
                var_4926.background = true;
                var_4926.mouseThreshold = 0;
                var_4925.setParamFlag(WindowParam.WINDOW_PARAM_FORCE_CLIPPING, true);
            }

            if (!var_4927)
            {
                var_4927 = (this._windowManager.buildFromXML(this._assetLibrary.getAssetByName("bubble_whisper").content as XML, 1) as IRegionWindow);
                var_4927.tags.push("roomchat_bubble");
                var_4927.x = 0;
                var_4927.y = 0;
                var_4927.width = 0;
                var_4927.background = true;
                var_4927.mouseThreshold = 0;
                var_4925.setParamFlag(WindowParam.WINDOW_PARAM_FORCE_CLIPPING, true);
            }

            if (!var_4928)
            {
                var_4928 = (this._windowManager.buildFromXML(this._assetLibrary.getAssetByName("bubble_whisper").content as XML, 1) as IRegionWindow);
                var_4928.tags.push("roomchat_bubble");
                var_4928.x = 0;
                var_4928.y = 0;
                var_4928.width = 0;
                var_4928.background = true;
                var_4928.mouseThreshold = 0;
                var_4925.setParamFlag(WindowParam.WINDOW_PARAM_FORCE_CLIPPING, true);
            }

        }

        public function dispose(): void
        {
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
                this._widget = null;
                this._windowManager = null;
                this._localization = null;
                this.var_4940 = null;
            }

        }

        public function define(param1: RoomWidgetChatUpdateEvent): void
        {
            this.var_4404 = param1.chatType;
            this.var_3158 = param1.userId;
            this.var_2907 = param1.userName;
            this.var_4942 = param1.userCategory;
            this._message = param1.text;
            this.var_4937 = param1.links;
            this._senderX = param1.userX;
            this.var_4940 = param1.userImage;
            this.var_4941 = param1.userColor;
            this._roomId = param1.roomId;
            this._roomCategory = param1.roomCategory;
            this.renderView();
        }

        public function get view(): IWindowContainer
        {
            return this._window;
        }

        public function get screenLevel(): int
        {
            return this._screenLevel;
        }

        public function get timeStamp(): int
        {
            return this._timestamp;
        }

        public function get senderX(): Number
        {
            return this._senderX;
        }

        public function set senderX(param1: Number): void
        {
            this._senderX = param1;
        }

        public function get width(): Number
        {
            return this._width;
        }

        public function get height(): Number
        {
            return HEIGHT;
        }

        public function get message(): String
        {
            return this._message;
        }

        public function get x(): Number
        {
            return this._x;
        }

        public function get y(): Number
        {
            return this._y;
        }

        public function get aboveLevels(): int
        {
            return this._aboveLevels;
        }

        public function set aboveLevels(param1: int): void
        {
            this._aboveLevels = param1;
        }

        public function set screenLevel(param1: int): void
        {
            this._screenLevel = param1;
        }

        public function set timeStamp(param1: int): void
        {
            this._timestamp = param1;
        }

        public function set x(param1: Number): void
        {
            this._x = param1;

            if (this._window != null)
            {
                this._window.x = param1;
            }

        }

        public function set y(param1: Number): void
        {
            this._y = param1;

            if (this._window != null)
            {
                this._window.y = param1 - this.var_4944;
            }

        }

        public function hidePointer(): void
        {
            if (this._window)
            {
                this._window.findChildByName("pointer").visible = false;
            }

        }

        public function setPointerOffset(param1: Number): void
        {
            if (!this._window || this._window.disposed)
            {
                return;
            }

            var _loc2_: IBitmapWrapperWindow = this._window.findChildByName("pointer") as IBitmapWrapperWindow;
            var _loc3_: IBitmapWrapperWindow = this._window.findChildByName("middle") as IBitmapWrapperWindow;
            if (_loc3_ == null || _loc2_ == null)
            {
                return;
            }

            _loc2_.visible = true;
            param1 = param1 + this._window.width / 2;
            param1 = Math.min(param1, _loc3_.rectangle.right - _loc2_.width);
            param1 = Math.max(param1, _loc3_.rectangle.left);
            _loc2_.x = param1;
        }

        public function checkOverlap(param1: Number, param2: Number, param3: Number, param4: Number): Boolean
        {
            var _loc5_: Rectangle = new Rectangle(this._x, this._y, this.width, HEIGHT);
            var _loc6_: Rectangle = new Rectangle(param1, param2, param3, param4);
            return _loc5_.intersects(_loc6_);
        }

        public function hideView(): void
        {
            if (this._window)
            {
                this._window.dispose();
            }

            this._window = null;
            this.var_4943 = false;
        }

        public function renderView(): void
        {
            var messageWidth: int;
            var x1: int;
            var y1: int;
            var userIconWindow: IBitmapWrapperWindow;
            var i: int;
            var lastLinkEndPos: int;
            var linkFormat: TextFormat;
            var filteredLink: String;
            var placeHolder: String;
            var placeholderPos: int;
            var linkPos: Array;
            if (this.var_4943)
            {
                return;
            }

            this.var_4943 = true;
            if (this._window)
            {
                return;
            }

            var isRespect: Boolean;
            switch (this.var_4404)
            {
                case RoomWidgetChatUpdateEvent.var_530:
                    this._window = (var_4925.clone() as IRegionWindow);
                    break;
                case RoomWidgetChatUpdateEvent.var_533:
                    this._window = (var_4927.clone() as IRegionWindow);
                    break;
                case RoomWidgetChatUpdateEvent.var_534:
                    this._window = (var_4926.clone() as IRegionWindow);
                    break;
                case RoomWidgetChatUpdateEvent.var_531:
                    this._window = (var_4928.clone() as IRegionWindow);
                    isRespect = true;
                    break;
                case RoomWidgetChatUpdateEvent.var_532:
                    this._window = (var_4928.clone() as IRegionWindow);
                    isRespect = true;
                    break;
            }

            var background: IBitmapWrapperWindow = this._window.findChildByName(BACKGROUND) as IBitmapWrapperWindow;
            var nameWindow: ILabelWindow = this._window.findChildByName(NAME) as ILabelWindow;
            var textWindow: ITextWindow = this._window.findChildByName(MESSAGE) as ITextWindow;
            var pointerWindow: IBitmapWrapperWindow = this._window.findChildByName(POINTER) as IBitmapWrapperWindow;
            var pointerBitmapData: BitmapData = this._assetLibrary.getAssetByName("chat_bubble_pointer").content as BitmapData;
            var totalHeight: Number = this._window.height;
            var topOffset: int;
            if (this.var_4940 != null)
            {
                topOffset = int(Math.max(0, (this.var_4940.height - background.height) / 2));
                totalHeight = Math.max(totalHeight, this.var_4940.height);
            }

            this._width = 0;
            this._window.x = this._x;
            this._window.y = this._y;
            this._window.width = 0;
            this._window.height = totalHeight;
            this.enableTooltip();
            this.addEventListeners(this._window);
            if (this.var_4940 && !isRespect)
            {
                x1 = int(14 - this.var_4940.width / 2);
                y1 = int(Math.max(0, (background.height - this.var_4940.height) / 2));
                userIconWindow = (this._window.findChildByName("user_image") as IBitmapWrapperWindow);
                if (userIconWindow)
                {
                    userIconWindow.width = this.var_4940.width;
                    userIconWindow.height = this.var_4940.height;
                    userIconWindow.bitmap = this.var_4940;
                    userIconWindow.disposesBitmap = false;
                    userIconWindow.x = x1;
                    userIconWindow.y = y1;
                    this.var_4944 = Math.max(0, (this.var_4940.height - background.height) / 2);
                    this._width = this._width + (userIconWindow.x + this.var_4940.width);
                }

            }

            if (nameWindow != null)
            {
                if (!isRespect)
                {
                    nameWindow.text = this.var_2907 + ": ";
                    nameWindow.y = nameWindow.y + this.var_4944;
                    nameWindow.width = nameWindow.textWidth + var_4930;
                }
                else
                {
                    nameWindow.text = "";
                    nameWindow.width = 0;
                }

                this._width = this._width + nameWindow.width;
            }

            if (this.var_4404 == RoomWidgetChatUpdateEvent.var_531)
            {
                textWindow.text = this._localization.registerParameter("widgets.chatbubble.respect", "username", this.var_2907);
                this._width = var_4932;
            }
            else
            {
                if (this.var_4404 == RoomWidgetChatUpdateEvent.var_532)
                {
                    textWindow.text = this._localization.registerParameter("widget.chatbubble.petrespect", "petname", this.var_2907);
                    this._width = var_4932;
                }
                else
                {
                    if (this.var_4937 == null)
                    {
                        textWindow.text = this.message;
                    }
                    else
                    {
                        this.var_4938 = [];
                        lastLinkEndPos = -1;
                        i = 0;
                        while (i < this.var_4937.length)
                        {
                            filteredLink = this.var_4937[i][1];
                            placeHolder = "{" + i + "}";
                            placeholderPos = this._message.indexOf(placeHolder);
                            lastLinkEndPos = placeholderPos + filteredLink.length;
                            this.var_4938.push([placeholderPos, lastLinkEndPos]);
                            this._message = this._message.replace(placeHolder, filteredLink);
                            i = i + 1;
                        }

                        textWindow.text = this.message;
                        textWindow.immediateClickMode = true;
                        textWindow.setParamFlag(WindowParam.var_693, false);
                        textWindow.setParamFlag(WindowParam.WINDOW_PARAM_FORCE_CLIPPING, true);
                        linkFormat = textWindow.getTextFormat();
                        linkFormat.color = 5923473;
                        linkFormat.underline = true;
                        i = 0;
                        while (i < this.var_4938.length)
                        {
                            linkPos = this.var_4938[i];
                            try
                            {
                                textWindow.setTextFormat(linkFormat, linkPos[0], linkPos[1]);
                            }
                            catch (e: RangeError)
                            {
                                Logger.log("Chat message links were malformed. Could not set TextFormat");
                            }

                            i = i + 1;
                        }

                    }

                }

            }

            if (textWindow.visible)
            {
                textWindow.x = this._width;
                if (nameWindow != null)
                {
                    textWindow.x = nameWindow.x + nameWindow.width;
                    if (nameWindow.width > var_4930)
                    {
                        textWindow.x = textWindow.x - (var_4930 - 1);
                    }

                }

                textWindow.y = textWindow.y + this.var_4944;
                messageWidth = textWindow.textWidth;
                textWindow.width = messageWidth + var_4931;
                this._width = this._width + textWindow.width;
            }

            if (pointerWindow != null && pointerWindow.visible)
            {
                pointerWindow.bitmap = pointerBitmapData;
                pointerWindow.disposesBitmap = false;
                pointerWindow.x = this._width / 2;
                pointerWindow.y = pointerWindow.y + this.var_4944;
            }

            var bitmap: BitmapData = this.buildBubbleImage(nameWindow.width + textWindow.width, background.height, this.var_4941, isRespect);
            this._window.width = bitmap.width;
            this._window.y = this._window.y - this.var_4944;
            this._width = this._window.width;
            background.bitmap = bitmap;
            background.y = this.var_4944;
        }

        private function buildBubbleImage(param1: int, param2: int, param3: uint, param4: Boolean): BitmapData
        {
            var _loc13_: BitmapData;
            var _loc14_: uint;
            var _loc15_: uint;
            var _loc16_: uint;
            var _loc5_: BitmapData = this._assetLibrary.getAssetByName("chat_bubble_left").content as BitmapData;
            var _loc6_: BitmapData = this._assetLibrary.getAssetByName("chat_bubble_middle").content as BitmapData;
            var _loc7_: BitmapData = this._assetLibrary.getAssetByName("chat_bubble_left_color").content as BitmapData;
            var _loc8_: BitmapData = this._assetLibrary.getAssetByName("chat_bubble_right").content as BitmapData;
            var _loc9_: int;
            var _loc10_: Point = new Point();
            var _loc11_: BitmapData = new BitmapData(_loc5_.width + param1 + _loc8_.width, param2, true, 0xFF00FF);
            _loc9_ = _loc9_ + _loc5_.width;
            _loc11_.copyPixels(_loc5_, _loc5_.rect, _loc10_);
            if (param4)
            {
                _loc13_ = (this._assetLibrary.getAssetByName("chat_bubble_left_gen").content as BitmapData);
                _loc11_.copyPixels(_loc13_, _loc13_.rect, _loc10_, null, null, true);
            }
            else
            {
                _loc14_ = 232;
                _loc15_ = 177;
                _loc16_ = 55;
                if (param3 != 0)
                {
                    _loc14_ = param3 >> 16 & 0xFF;
                    _loc15_ = param3 >> 8 & 0xFF;
                    _loc16_ = param3 >> 0 & 0xFF;
                }

                _loc11_.draw(_loc7_, null, new ColorTransform(_loc14_ / 0xFF, _loc15_ / 0xFF, _loc16_ / 0xFF), BlendMode.DARKEN);
            }

            var _loc12_: Matrix = new Matrix();
            _loc12_.scale(param1 / _loc6_.width, 1);
            _loc12_.translate(_loc9_, 0);
            _loc11_.draw(_loc6_, _loc12_);
            _loc9_ = _loc9_ + param1;
            _loc10_.x = _loc9_;
            _loc11_.copyPixels(_loc8_, _loc8_.rect, _loc10_);
            _loc9_ = _loc9_ + _loc8_.width;
            return _loc11_;
        }

        public function enableTooltip(): void
        {
            if (this._window != null)
            {
                this._window.toolTipCaption = "${chat.history.drag.tooltip}";
                this._window.toolTipDelay = 500;
            }

        }

        public function disableTooltip(): void
        {
            if (this._window != null)
            {
                this._window.toolTipCaption = "";
            }

        }

        private function addEventListeners(param1: IWindowContainer): void
        {
            param1.setParamFlag(HabboWindowParam.var_157, true);
            param1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onBubbleMouseClick);
            param1.addEventListener(WindowMouseEvent.var_628, this.onBubbleMouseDown);
            param1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onBubbleMouseOver);
            param1.addEventListener(WindowMouseEvent.var_626, this.onBubbleMouseOut);
            param1.addEventListener(WindowMouseEvent.var_633, this.onBubbleMouseUp);
        }

        private function testMessageLinkMouseClick(param1: int, param2: int): Boolean
        {
            var _loc5_: int;
            var _loc3_: ITextWindow = this._window.getChildByName(MESSAGE) as ITextWindow;
            var _loc4_: int = _loc3_.getCharIndexAtPoint(param1 - _loc3_.x, param2 - _loc3_.y);
            if (_loc4_ > -1)
            {
                _loc5_ = 0;
                while (_loc5_ < this.var_4938.length)
                {
                    if (_loc4_ >= this.var_4938[_loc5_][0] && _loc4_ <= this.var_4938[_loc5_][1])
                    {
                        if (this.var_4937[_loc5_][2] == 0)
                        {
                            HabboWebTools.openExternalLinkWarning(this.var_4937[_loc5_][0]);
                        }
                        else
                        {
                            if (this.var_4937[_loc5_][2] == 1)
                            {
                                HabboWebTools.openWebPage(this.var_4934 + this.var_4937[_loc5_][0], "habboMain");
                            }
                            else
                            {
                                HabboWebTools.openWebPage(this.var_4934 + this.var_4937[_loc5_][0]);
                            }

                        }

                        return true;
                    }

                    _loc5_++;
                }

            }

            return false;
        }

        private function onBubbleMouseClick(param1: WindowMouseEvent): void
        {
            if (this.var_4937 && this.var_4937.length > 0)
            {
                if (this.testMessageLinkMouseClick(param1.localX, param1.localY))
                {
                    return;
                }

            }

            this._widget.onItemMouseClick(this.var_3158, this.var_2907, this.var_4942, this._roomId, this._roomCategory, param1);
        }

        private function onBubbleMouseDown(param1: WindowMouseEvent): void
        {
            this._widget.onItemMouseDown(this.var_3158, this.var_4942, this._roomId, this._roomCategory, param1);
        }

        private function onBubbleMouseOver(param1: WindowMouseEvent): void
        {
            this._widget.onItemMouseOver(this.var_3158, this.var_4942, this._roomId, this._roomCategory, param1);
        }

        private function onBubbleMouseOut(param1: WindowMouseEvent): void
        {
            this._widget.onItemMouseOut(this.var_3158, this.var_4942, this._roomId, this._roomCategory, param1);
        }

        private function onBubbleMouseUp(param1: WindowMouseEvent): void
        {
            this._widget.mouseUp();
        }

    }
}
