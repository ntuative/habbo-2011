package com.sulake.habbo.ui
{

    import com.sulake.habbo.widget.enums.RoomWidgetEnum;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.WelcomeGiftStatusEvent;
    import com.sulake.habbo.communication.messages.incoming.users.ChangeEmailResultEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.WelcomeGiftStatusParser;
    import com.sulake.habbo.widget.events.RoomWidgetWelcomeGiftUpdateEvent;
    import com.sulake.habbo.communication.messages.parser.users.ChangeEmailResultParser;
    import com.sulake.habbo.widget.events.RoomWidgetChangeEmailResultEvent;
    import com.sulake.habbo.widget.messages.RoomWidgetFurniActionMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetChangeEmailMessage;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.OpenWelcomeGiftComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.ChangeEmailComposer;
    import com.sulake.habbo.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;

    import flash.events.Event;

    public class WelcomeGiftWidgetHandler implements IRoomWidgetHandler
    {

        private var _disposed: Boolean = false;
        private var _container: IRoomWidgetHandlerContainer = null;
        private var var_4465: Array;

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function dispose(): void
        {
            if (!this._disposed)
            {
                this.removeMessageEvents();
                this._container = null;
                this._disposed = true;
            }

        }

        public function get type(): String
        {
            return RoomWidgetEnum.var_283;
        }

        public function set container(param1: IRoomWidgetHandlerContainer): void
        {
            this._container = param1;
            this.addMessageEvents();
        }

        private function addMessageEvents(): void
        {
            var _loc1_: IMessageEvent;
            if (!this._container || !this._container.connection)
            {
                return;
            }

            this.var_4465 = [];
            this.var_4465.push(new WelcomeGiftStatusEvent(this.onWelcomeGiftStatus));
            this.var_4465.push(new ChangeEmailResultEvent(this.onChangeEmailResult));
            for each (_loc1_ in this.var_4465)
            {
                this._container.connection.addMessageEvent(_loc1_);
            }

        }

        private function removeMessageEvents(): void
        {
            var _loc1_: IMessageEvent;
            if (!this._container || !this._container.connection || !this.var_4465)
            {
                return;
            }

            for each (_loc1_ in this.var_4465)
            {
                this._container.connection.removeMessageEvent(_loc1_);
                _loc1_.dispose();
            }

            this.var_4465 = null;
        }

        private function onWelcomeGiftStatus(param1: WelcomeGiftStatusEvent): void
        {
            var _loc2_: WelcomeGiftStatusParser = param1.getParser();
            var _loc3_: RoomWidgetWelcomeGiftUpdateEvent = new RoomWidgetWelcomeGiftUpdateEvent();
            _loc3_.email = _loc2_.email;
            _loc3_.isVerified = _loc2_.isVerified;
            _loc3_.allowEmailChange = _loc2_.allowChange;
            _loc3_.furniId = _loc2_.furniId;
            _loc3_.requestedByUser = _loc2_.requestedByUser;
            this._container.events.dispatchEvent(_loc3_);
        }

        private function onChangeEmailResult(param1: ChangeEmailResultEvent): void
        {
            var _loc2_: ChangeEmailResultParser = param1.getParser();
            this._container.events.dispatchEvent(new RoomWidgetChangeEmailResultEvent(_loc2_.result));
        }

        public function getWidgetMessages(): Array
        {
            var _loc1_: Array = [];
            _loc1_.push(RoomWidgetFurniActionMessage.var_1238);
            _loc1_.push(RoomWidgetChangeEmailMessage.var_1794);
            return _loc1_;
        }

        public function processWidgetMessage(param1: RoomWidgetMessage): RoomWidgetUpdateEvent
        {
            var _loc2_: RoomWidgetFurniActionMessage;
            var _loc3_: RoomWidgetChangeEmailMessage;
            if (!param1)
            {
                return null;
            }

            switch (param1.type)
            {
                case RoomWidgetFurniActionMessage.var_1238:
                    _loc2_ = (param1 as RoomWidgetFurniActionMessage);
                    this._container.connection.send(new OpenWelcomeGiftComposer(_loc2_.furniId));
                    break;
                case RoomWidgetChangeEmailMessage.var_1794:
                    _loc3_ = (param1 as RoomWidgetChangeEmailMessage);
                    this._container.connection.send(new ChangeEmailComposer(_loc3_.newEmail));
                    break;
            }

            return null;
        }

        public function getProcessedEvents(): Array
        {
            return [];
        }

        public function processEvent(param1: Event): void
        {
        }

        public function update(): void
        {
        }

    }
}
