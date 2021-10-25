package com.sulake.habbo.moderation
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;

    import flash.utils.Dictionary;
    import flash.utils.Timer;

    import com.sulake.core.utils.Map;

    import flash.events.TimerEvent;

    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomChatlogData;
    import com.sulake.habbo.communication.messages.incoming.moderation.ChatlineData;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class ChatlogCtrl implements IDisposable, TrackedWindow
    {

        private static var var_3639: Array = [];
        private static var var_3640: int = 1000;
        private static var var_3641: Array = [];
        private static var var_3642: int = 200;

        private var _type: int;
        private var _id: int;
        private var var_2960: IMessageComposer;
        private var var_3486: ModerationManager;
        private var _frame: IFrameWindow;
        private var var_2190: IItemListWindow;
        private var var_2978: Array;
        private var _disposed: Boolean;
        private var var_3643: IWindowContainer;
        private var var_3644: IWindowContainer;
        private var var_3645: Dictionary;
        private var var_3635: Timer;
        private var var_3646: Map;
        private var var_3647: Array = [];
        private var var_3648: Array = [];

        public function ChatlogCtrl(param1: IMessageComposer, param2: ModerationManager, param3: int, param4: int)
        {
            this.var_3486 = param2;
            this._type = param3;
            this._id = param4;
            this.var_2960 = param1;
            this.var_3646 = new Map();
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function show(): void
        {
            this.var_3643 = IWindowContainer(this.var_3486.getXmlWindow("chatlog_roomheader"));
            this.var_3644 = IWindowContainer(this.var_3486.getXmlWindow("chatlog_chatline"));
            this.var_3635 = new Timer(1000, 1);
            this.var_3635.addEventListener(TimerEvent.TIMER, this.onResizeTimer);
            this._frame = IFrameWindow(this.var_3486.getXmlWindow("chatlog_frame"));
            this.var_2190 = IItemListWindow(this._frame.findChildByName("chatline_list"));
            this._frame.procedure = this.onWindow;
            var _loc1_: IWindow = this._frame.findChildByTag("close");
            _loc1_.procedure = this.onClose;
            this.var_3486.connection.send(this.var_2960);
            this.var_3486.messageHandler.addChatlogListener(this);
        }

        public function onChatlog(param1: String, param2: int, param3: int, param4: Array, param5: Dictionary): void
        {
            if (param2 != this._type || param3 != this._id || this._disposed)
            {
                return;
            }

            this.var_3486.messageHandler.removeChatlogListener(this);
            this._frame.caption = param1;
            this.var_2978 = param4;
            this.var_3645 = param5;
            this.populate();
            this.onResizeTimer(null);
            this._frame.visible = true;
        }

        public function getType(): int
        {
            return this._type;
        }

        public function getId(): String
        {
            return "" + this._id;
        }

        public function getFrame(): IFrameWindow
        {
            return this._frame;
        }

        private function populate(): void
        {
            var _loc1_: RoomChatlogData;
            this.var_2190.autoArrangeItems = false;
            for each (_loc1_ in this.var_2978)
            {
                this.populateRoomChat(_loc1_);
            }

            this.var_2190.autoArrangeItems = true;
        }

        private function populateRoomChat(param1: RoomChatlogData): void
        {
            var _loc5_: ChatlineData;
            var _loc2_: IWindowContainer = this.getChatHeaderWindow();
            var _loc3_: ITextWindow = ITextWindow(_loc2_.findChildByName("room_name_txt"));
            if (param1.roomId > 0)
            {
                _loc3_.caption = param1.roomName;
                _loc3_.underline = true;
                new OpenRoomTool(this._frame, this.var_3486, _loc3_, param1.isPublic, param1.roomId);
            }
            else
            {
                _loc3_.caption = "Not in room";
                _loc3_.underline = false;
            }

            this.addHeaderLineToList(_loc2_, this.var_2190);
            var _loc4_: Boolean = true;
            for each (_loc5_ in param1.chatlog)
            {
                this.populateChatline(this.var_2190, _loc5_, _loc4_);
                _loc4_ = !_loc4_;
            }

        }

        private function addChatLineToList(param1: IWindowContainer, param2: IItemListWindow): void
        {
            param2.addListItem(param1);
            this.var_3647.push(param1);
        }

        private function addHeaderLineToList(param1: IWindowContainer, param2: IItemListWindow): void
        {
            param2.addListItem(param1);
            this.var_3648.push(param1);
        }

        private function getChatLineWindow(): IWindowContainer
        {
            if (var_3639.length > 0)
            {
                return var_3639.pop() as IWindowContainer;
            }

            return IWindowContainer(this.var_3644.clone());
        }

        private function storeChatLineWindow(param1: IWindowContainer): void
        {
            var _loc2_: ITextWindow;
            if (var_3639.length < var_3640)
            {
                _loc2_ = ITextWindow(param1.findChildByName("chatter_txt"));
                _loc2_.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onChatLogUserClick);
                param1.width = this.var_3644.width;
                param1.height = this.var_3644.height;
                var_3639.push(param1);
            }
            else
            {
                param1.dispose();
            }

        }

        private function getChatHeaderWindow(): IWindowContainer
        {
            if (var_3641.length > 0)
            {
                return var_3641.pop() as IWindowContainer;
            }

            return IWindowContainer(this.var_3643.clone());
        }

        private function storeChatHeaderWindow(param1: IWindowContainer): void
        {
            var _loc2_: ITextWindow;
            if (var_3641.length < var_3642)
            {
                _loc2_ = ITextWindow(param1.findChildByName("room_name_txt"));
                _loc2_.procedure = null;
                param1.width = this.var_3643.width;
                param1.height = this.var_3643.height;
                var_3641.push(param1);
            }
            else
            {
                param1.dispose();
            }

        }

        private function populateChatline(param1: IItemListWindow, param2: ChatlineData, param3: Boolean): void
        {
            var _loc4_: IWindowContainer = this.getChatLineWindow();
            _loc4_.color = this.var_3645[param2.chatterId] != null ? (param3 ? 4294623571 : 0xFFFFE240) : (param3
                    ? 4288861930
                    : 0xFFFFFFFF);
            var _loc5_: ITextWindow = ITextWindow(_loc4_.findChildByName("time_txt"));
            _loc5_.text = RoomVisitsCtrl.getFormattedTime(param2.hour, param2.minute);
            var _loc6_: ITextWindow = ITextWindow(_loc4_.findChildByName("chatter_txt"));
            _loc6_.color = _loc4_.color;
            if (param2.chatterId > 0)
            {
                _loc6_.text = param2.chatterName;
                _loc6_.underline = true;
                _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onChatLogUserClick);
                if (!this.var_3646.getValue(param2.chatterName))
                {
                    this.var_3646.add(param2.chatterName, param2.chatterId);
                }

            }
            else
            {
                if (param2.chatterId == 0)
                {
                    _loc6_.text = "Bot / pet";
                    _loc6_.underline = false;
                }
                else
                {
                    _loc6_.text = "-";
                    _loc6_.underline = false;
                }

            }

            var _loc7_: ITextWindow = ITextWindow(_loc4_.findChildByName("msg_txt"));
            _loc7_.text = param2.msg;
            _loc7_.height = _loc7_.textHeight + 5;
            _loc4_.height = _loc7_.height;
            this.addChatLineToList(_loc4_, param1);
        }

        private function onChatLogUserClick(param1: WindowMouseEvent): void
        {
            var _loc2_: String = param1.target.caption;
            var _loc3_: int = this.var_3646.getValue(_loc2_);
            this.var_3486.windowTracker.show(new UserInfoFrameCtrl(this.var_3486, _loc3_), this._frame, false, false, true);
        }

        private function onClose(param1: WindowEvent, param2: IWindow): void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            }

            this.dispose();
        }

        private function onWindow(param1: WindowEvent, param2: IWindow): void
        {
            if (param1.type != WindowEvent.var_573 || param2 != this._frame)
            {
                return;
            }

            this.var_3635.reset();
            this.var_3635.start();
        }

        private function onResizeTimer(param1: TimerEvent): void
        {
            this.refreshListDims();
            var _loc2_: Boolean = this.refreshScrollBarVisibility();
        }

        private function refreshListDims(): void
        {
            var _loc1_: IWindowContainer;
            var _loc2_: ITextWindow;
            this.var_2190.autoArrangeItems = false;
            var _loc3_: int = this.var_2190.numListItems;
            var _loc4_: int;
            while (_loc4_ < _loc3_)
            {
                _loc1_ = IWindowContainer(this.var_2190.getListItemAt(_loc4_));
                if (_loc1_.name == "chatline")
                {
                    _loc2_ = ITextWindow(_loc1_.findChildByName("msg_txt"));
                    _loc2_.width = _loc1_.width - _loc2_.x;
                    _loc2_.height = _loc2_.textHeight + 5;
                    _loc1_.height = _loc2_.height;
                }

                _loc4_++;
            }

            this.var_2190.autoArrangeItems = true;
        }

        private function refreshScrollBarVisibility(): Boolean
        {
            var _loc1_: IWindowContainer = IWindowContainer(this.var_2190.parent);
            var _loc2_: IWindow = _loc1_.getChildByName("scroller") as IWindow;
            var _loc3_: * = this.var_2190.scrollableRegion.height > this.var_2190.height;
            var _loc4_: int = 22;
            if (_loc2_.visible)
            {
                if (_loc3_)
                {
                    return false;
                }

                _loc2_.visible = false;
                this.var_2190.width = this.var_2190.width + _loc4_;
                return true;
            }

            if (_loc3_)
            {
                _loc2_.visible = true;
                this.var_2190.width = this.var_2190.width - _loc4_;
                return true;
            }

            return false;
        }

        public function dispose(): void
        {
            var _loc1_: IWindowContainer;
            if (this._disposed)
            {
                return;
            }

            this._disposed = true;
            this.var_3486 = null;
            this.var_2960 = null;
            if (this.var_2190 != null)
            {
                this.var_2190.removeListItems();
                this.var_2190.dispose();
                this.var_2190 = null;
            }

            if (this._frame != null)
            {
                this._frame.destroy();
                this._frame = null;
            }

            this.var_2978 = null;
            this.var_3645 = null;
            if (this.var_3635 != null)
            {
                this.var_3635.stop();
                this.var_3635.removeEventListener(TimerEvent.TIMER, this.onResizeTimer);
                this.var_3635 = null;
            }

            for each (_loc1_ in this.var_3647)
            {
                this.storeChatLineWindow(_loc1_);
            }

            for each (_loc1_ in this.var_3648)
            {
                this.storeChatHeaderWindow(_loc1_);
            }

            this.var_3647 = [];
            this.var_3648 = [];
            if (this.var_3643 != null)
            {
                this.var_3643.dispose();
                this.var_3643 = null;
            }

            if (this.var_3644 != null)
            {
                this.var_3644.dispose();
                this.var_3644 = null;
            }

        }

    }
}
