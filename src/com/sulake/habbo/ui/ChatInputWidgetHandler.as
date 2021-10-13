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

        private var var_978:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var var_2844:IHabboToolbar;

        public function get disposed():Boolean
        {
            return (this.var_978);
        }

        public function get type():String
        {
            return (RoomWidgetEnum.CHAT_INPUT_WIDGET);
        }

        public function set container(param1:IRoomWidgetHandlerContainer):void
        {
            this._container = param1;
            this.var_2844 = this._container.toolbar;
        }

        public function dispose():void
        {
            this.var_978 = true;
            this._container = null;
            this.var_2844 = null;
        }

        public function getWidgetMessages():Array
        {
            var _loc1_:Array = [];
            _loc1_.push(RoomWidgetChatInputWidgetMessage.var_1357);
            _loc1_.push(RoomWidgetChatTypingMessage.var_1910);
            return (_loc1_);
        }

        public function processWidgetMessage(param1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _loc2_:RoomWidgetChatInputWidgetMessage;
            var _loc3_:RoomWidgetChatTypingMessage;
            switch (param1.type)
            {
                case RoomWidgetChatInputWidgetMessage.var_1357:
                    _loc2_ = (param1 as RoomWidgetChatInputWidgetMessage);
                    if (_loc2_ != null)
                    {
                        this.positionWindow(_loc2_.window);
                    };
                    break;
                case RoomWidgetChatTypingMessage.var_1910:
                    _loc3_ = (param1 as RoomWidgetChatTypingMessage);
                    if (_loc3_ != null)
                    {
                        this._container.roomSession.sendChatTypingMessage(_loc3_.var_1215);
                    };
                    break;
            };
            return (null);
        }

        private function positionWindow(param1:IWindowContainer):void
        {
            if (this.var_2844 == null)
            {
                return;
            };
            this.var_2844.events.dispatchEvent(new HabboToolbarShowMenuEvent(HabboToolbarShowMenuEvent.var_434, HabboToolbarIconEnum.CHATINPUT, param1));
        }

        public function getProcessedEvents():Array
        {
            return ([RoomSessionChatEvent.var_367]);
        }

        public function processEvent(param1:Event):void
        {
            var _loc3_:RoomSessionChatEvent;
            var _loc4_:int;
            var _loc2_:Event;
            if (((this._container == null) || (this._container.events == null)))
            {
                return;
            };
            switch (param1.type)
            {
                case RoomSessionChatEvent.var_367:
                    _loc3_ = (param1 as RoomSessionChatEvent);
                    _loc4_ = parseInt(_loc3_.text);
                    _loc2_ = new RoomWidgetFloodControlEvent(_loc4_);
                    break;
            };
            if ((((!(this._container == null)) && (!(this._container.events == null))) && (!(_loc2_ == null))))
            {
                this._container.events.dispatchEvent(_loc2_);
            };
        }

        public function update():void
        {
        }

    }
}