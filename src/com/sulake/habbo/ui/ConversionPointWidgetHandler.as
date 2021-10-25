package com.sulake.habbo.ui
{

    import com.sulake.habbo.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.widget.messages.RoomWidgetConversionPointMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;

    import flash.events.Event;

    public class ConversionPointWidgetHandler implements IRoomWidgetHandler
    {

        private var var_978: Boolean = false;
        private var _container: IRoomWidgetHandlerContainer = null;

        public function get disposed(): Boolean
        {
            return this.var_978;
        }

        public function get type(): String
        {
            return RoomWidgetEnum.var_272;
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
            return [RoomWidgetConversionPointMessage.var_1381];
        }

        public function processWidgetMessage(param1: RoomWidgetMessage): RoomWidgetUpdateEvent
        {
            var _loc2_: RoomWidgetConversionPointMessage;
            switch (param1.type)
            {
                case RoomWidgetConversionPointMessage.var_1381:
                    _loc2_ = (param1 as RoomWidgetConversionPointMessage);
                    if (_loc2_ == null)
                    {
                        return null;
                    }

                    this._container.roomSession.sendConversionPoint(_loc2_.category, _loc2_.pointType, _loc2_.action, _loc2_.extra);
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
