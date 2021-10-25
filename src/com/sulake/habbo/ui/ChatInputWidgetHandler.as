package com.sulake.habbo.ui
{

    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.widget.messages.RoomWidgetChatInputWidgetMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetChatTypingMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.toolbar.events.HabboToolbarShowMenuEvent;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.session.events.RoomSessionChatEvent;

    import flash.events.Event;

    import com.sulake.habbo.widget.events.RoomWidgetFloodControlEvent;

    public class ChatInputWidgetHandler implements IRoomWidgetHandler
    {

        private var _disposed: Boolean = false;
        private var _container: IRoomWidgetHandlerContainer = null;
        private var _toolbar: IHabboToolbar;

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get type(): String
        {
            return RoomWidgetEnum.CHAT_INPUT_WIDGET;
        }

        public function set container(container: IRoomWidgetHandlerContainer): void
        {
            this._container = container;
            this._toolbar = this._container.toolbar;
        }

        public function dispose(): void
        {
            this._disposed = true;
            this._container = null;
            this._toolbar = null;
        }

        public function getWidgetMessages(): Array
        {
            var messages: Array = [];
            
            messages.push(RoomWidgetChatInputWidgetMessage.RWCIW_MESSAGE_POSITION_WINDOW);
            messages.push(RoomWidgetChatTypingMessage.RWCTM_TYPING_STATUS);
            
            return messages;
        }

        public function processWidgetMessage(roomWidget: RoomWidgetMessage): RoomWidgetUpdateEvent
        {
            var chatInputWidget: RoomWidgetChatInputWidgetMessage;
            var chatTypingWidget: RoomWidgetChatTypingMessage;
            
            switch (roomWidget.type)
            {
                case RoomWidgetChatInputWidgetMessage.RWCIW_MESSAGE_POSITION_WINDOW:
                    chatInputWidget = (roomWidget as RoomWidgetChatInputWidgetMessage);

                    if (chatInputWidget != null)
                    {
                        this.positionWindow(chatInputWidget.window);
                    }

                    break;

                case RoomWidgetChatTypingMessage.RWCTM_TYPING_STATUS:
                    chatTypingWidget = (roomWidget as RoomWidgetChatTypingMessage);

                    if (chatTypingWidget != null)
                    {
                        this._container.roomSession.sendChatTypingMessage(chatTypingWidget.isTyping);
                    }

                    break;
            }

            return null;
        }

        private function positionWindow(param1: IWindowContainer): void
        {
            if (this._toolbar == null)
            {
                return;
            }

            this._toolbar.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.HTSME_DISPLAY_WINDOW, HabboToolbarIconEnum.CHATINPUT, param1));
        }

        public function getProcessedEvents(): Array
        {
            return [RoomSessionChatEvent.RSCE_FLOOD_EVENT];
        }

        public function processEvent(event: Event): void
        {
            var chatEvent: RoomSessionChatEvent;
            var _loc4_: int;
            var outgoing: Event;
            if (this._container == null || this._container.events == null)
            {
                return;
            }

            switch (event.type)
            {
                case RoomSessionChatEvent.RSCE_FLOOD_EVENT:
                    chatEvent = (event as RoomSessionChatEvent);
                    _loc4_ = parseInt(chatEvent.text);
                    outgoing = new RoomWidgetFloodControlEvent(_loc4_);
                    break;
            }

            if (this._container != null && this._container.events != null && outgoing != null)
            {
                this._container.events.dispatchEvent(outgoing);
            }

        }

        public function update(): void
        {
        }

    }
}
