package com.sulake.habbo.ui
{

    import com.sulake.habbo.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.catalog.purse.PurseEvent;

    import flash.events.Event;

    public class RoomInfoWidgetHandler implements IRoomWidgetHandler
    {

        private var _disposed: Boolean = false;
        private var _container: IRoomWidgetHandlerContainer = null;

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function dispose(): void
        {
            if (!this._disposed)
            {
                this._container = null;
                this._disposed = true;
            }

        }

        public function get type(): String
        {
            return RoomWidgetEnum.var_285;
        }

        public function set container(param1: IRoomWidgetHandlerContainer): void
        {
            this._container = param1;
        }

        public function getWidgetMessages(): Array
        {
            return [];
        }

        public function getProcessedEvents(): Array
        {
            return [];
        }

        public function processWidgetMessage(param1: RoomWidgetMessage): RoomWidgetUpdateEvent
        {
            return null;
        }

        private function purseEventHandler(param1: PurseEvent): void
        {
        }

        public function processEvent(param1: Event): void
        {
        }

        public function update(): void
        {
        }

    }
}
