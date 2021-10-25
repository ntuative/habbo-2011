package com.sulake.habbo.ui
{

    import com.sulake.habbo.catalog.purse.PurseEvent;
    import com.sulake.habbo.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.widget.messages.RoomWidgetGetPurseData;
    import com.sulake.habbo.widget.messages.RoomWidgetOpenCatalogMessage;
    import com.sulake.habbo.catalog.purse.IPurse;
    import com.sulake.habbo.widget.events.RoomWidgetPurseUpdateEvent;
    import com.sulake.habbo.catalog.purse.Purse;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.habbo.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;

    import flash.events.Event;

    public class PurseWidgetHandler implements IRoomWidgetHandler
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
                this._container.catalog.events.removeEventListener(PurseEvent.CATALOG_PURSE_CREDIT_BALANCE, this.purseEventHandler);
                this._container.catalog.events.removeEventListener(PurseEvent.CATALOG_PURSE_PIXEL_BALANCE, this.purseEventHandler);
                this._container = null;
                this._disposed = true;
            }

        }

        public function get type(): String
        {
            return RoomWidgetEnum.var_281;
        }

        public function set container(param1: IRoomWidgetHandlerContainer): void
        {
            this._container = param1;
            if (this._container.catalog)
            {
                this._container.catalog.events.addEventListener(PurseEvent.CATALOG_PURSE_CREDIT_BALANCE, this.purseEventHandler);
                this._container.catalog.events.addEventListener(PurseEvent.CATALOG_PURSE_PIXEL_BALANCE, this.purseEventHandler);
            }

        }

        public function getWidgetMessages(): Array
        {
            var _loc1_: Array = [];
            _loc1_.push(RoomWidgetGetPurseData.var_1814);
            _loc1_.push(RoomWidgetOpenCatalogMessage.var_1815);
            return _loc1_;
        }

        public function getProcessedEvents(): Array
        {
            return [];
        }

        public function processWidgetMessage(param1: RoomWidgetMessage): RoomWidgetUpdateEvent
        {
            var _loc2_: IPurse;
            var _loc3_: RoomWidgetOpenCatalogMessage;
            if (!param1)
            {
                return null;
            }

            switch (param1.type)
            {
                case RoomWidgetGetPurseData.var_1814:
                    _loc2_ = this._container.catalog.getPurse();
                    this._container.events.dispatchEvent(new RoomWidgetPurseUpdateEvent(RoomWidgetPurseUpdateEvent.var_150, _loc2_.credits));
                    this._container.events.dispatchEvent(new RoomWidgetPurseUpdateEvent(RoomWidgetPurseUpdateEvent.var_152, _loc2_.getActivityPointsForType(Purse.ACTIVITY_POINTS_TYPE_PIXELS)));
                    break;
                case RoomWidgetOpenCatalogMessage.var_1815:
                    _loc3_ = (param1 as RoomWidgetOpenCatalogMessage);
                    if (this._container.catalog != null)
                    {
                        switch (_loc3_.pageKey)
                        {
                            case RoomWidgetOpenCatalogMessage.var_1283:
                                this._container.catalog.openCatalogPage(CatalogPageName.var_915);
                                break;
                            case RoomWidgetOpenCatalogMessage.var_1282:
                                this._container.catalog.openCreditsHabblet();
                                break;
                        }

                    }

                    break;
                default:
                    Logger.log(param1.type);
            }

            return null;
        }

        private function purseEventHandler(param1: PurseEvent): void
        {
            var _loc2_: RoomWidgetUpdateEvent;
            switch (param1.type)
            {
                case PurseEvent.CATALOG_PURSE_CREDIT_BALANCE:
                    _loc2_ = new RoomWidgetPurseUpdateEvent(RoomWidgetPurseUpdateEvent.var_150, param1.balance);
                    break;
                case PurseEvent.CATALOG_PURSE_PIXEL_BALANCE:
                    _loc2_ = new RoomWidgetPurseUpdateEvent(RoomWidgetPurseUpdateEvent.var_152, param1.balance);
                    break;
            }

            if (_loc2_)
            {
                this._container.events.dispatchEvent(_loc2_);
            }

        }

        public function processEvent(param1: Event): void
        {
        }

        public function update(): void
        {
        }

    }
}
