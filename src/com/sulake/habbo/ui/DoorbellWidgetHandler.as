package com.sulake.habbo.ui
{

    import com.sulake.habbo.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.widget.messages.RoomWidgetLetUserInMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionDoorbellEvent;
    import com.sulake.habbo.widget.events.RoomWidgetDoorbellEvent;

    import flash.events.Event;

    public class DoorbellWidgetHandler implements IRoomWidgetHandler
    {

        private var var_978: Boolean = false;
        private var _container: IRoomWidgetHandlerContainer = null;

        public function get disposed(): Boolean
        {
            return this.var_978;
        }

        public function get type(): String
        {
            return RoomWidgetEnum.var_269;
        }

        public function set container(param1: IRoomWidgetHandlerContainer): void
        {
            this._container = param1;
        }

        public function dispose(): void
        {
            this.var_978 = true;
            this._container = null;
        }

        public function getWidgetMessages(): Array
        {
            return [RoomWidgetLetUserInMessage.var_1853];
        }

        public function processWidgetMessage(param1: RoomWidgetMessage): RoomWidgetUpdateEvent
        {
            var _loc2_: RoomWidgetLetUserInMessage;
            switch (param1.type)
            {
                case RoomWidgetLetUserInMessage.var_1853:
                    _loc2_ = (param1 as RoomWidgetLetUserInMessage);
                    this._container.roomSession.letUserIn(_loc2_.userName, _loc2_.canEnter);
                    break;
            }

            return null;
        }

        public function getProcessedEvents(): Array
        {
            return [
                RoomSessionDoorbellEvent.var_269,
                RoomSessionDoorbellEvent.var_369,
                RoomSessionDoorbellEvent.var_370
            ];
        }

        public function processEvent(param1: Event): void
        {
            var _loc2_: RoomSessionDoorbellEvent;
            switch (param1.type)
            {
                case RoomSessionDoorbellEvent.var_269:
                    _loc2_ = (param1 as RoomSessionDoorbellEvent);
                    if (_loc2_ == null)
                    {
                        return;
                    }

                    this._container.events.dispatchEvent(new RoomWidgetDoorbellEvent(RoomWidgetDoorbellEvent.var_1361, _loc2_.userName));
                    return;
                case RoomSessionDoorbellEvent.var_369:
                    _loc2_ = (param1 as RoomSessionDoorbellEvent);
                    if (_loc2_ == null)
                    {
                        return;
                    }

                    this._container.events.dispatchEvent(new RoomWidgetDoorbellEvent(RoomWidgetDoorbellEvent.var_369, _loc2_.userName));
                    return;
                case RoomSessionDoorbellEvent.var_370:
                    _loc2_ = (param1 as RoomSessionDoorbellEvent);
                    if (_loc2_ == null)
                    {
                        return;
                    }

                    this._container.events.dispatchEvent(new RoomWidgetDoorbellEvent(RoomWidgetDoorbellEvent.var_370, _loc2_.userName));
                    return;
            }

        }

        public function update(): void
        {
        }

    }
}
