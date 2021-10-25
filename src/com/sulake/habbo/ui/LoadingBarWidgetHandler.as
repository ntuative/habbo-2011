package com.sulake.habbo.ui
{

    import com.sulake.habbo.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.advertisement.events.AdEvent;
    import com.sulake.habbo.widget.events.RoomWidgetLoadingBarUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetInterstitialUpdateEvent;

    import flash.events.Event;

    public class LoadingBarWidgetHandler implements IRoomWidgetHandler
    {

        private var var_978: Boolean = false;
        private var _container: IRoomWidgetHandlerContainer = null;

        public function get disposed(): Boolean
        {
            return this.var_978;
        }

        public function get type(): String
        {
            return RoomWidgetEnum.var_270;
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
            return [];
        }

        public function processWidgetMessage(param1: RoomWidgetMessage): RoomWidgetUpdateEvent
        {
            return null;
        }

        public function getProcessedEvents(): Array
        {
            var _loc1_: Array = [];
            _loc1_.push(AdEvent.INTERSTITIAL_SHOW);
            _loc1_.push(AdEvent.INTERSTITIAL_COMPLETE);
            _loc1_.push(RoomWidgetLoadingBarUpdateEvent.var_1382);
            _loc1_.push(RoomWidgetLoadingBarUpdateEvent.var_1383);
            return _loc1_;
        }

        public function processEvent(param1: Event): void
        {
            var _loc2_: AdEvent;
            var _loc3_: RoomWidgetInterstitialUpdateEvent;
            if (this._container == null || this._container.events == null)
            {
                return;
            }

            switch (param1.type)
            {
                case AdEvent.INTERSTITIAL_SHOW:
                    _loc2_ = (param1 as AdEvent);
                    if (_loc2_ == null)
                    {
                        return;
                    }

                    _loc3_ = new RoomWidgetInterstitialUpdateEvent(RoomWidgetInterstitialUpdateEvent.var_1382, _loc2_.image, _loc2_.clickUrl);
                    this._container.events.dispatchEvent(_loc3_);
                    return;
                case AdEvent.INTERSTITIAL_COMPLETE:
                    this._container.setInterstitialCompleted();
                    return;
                case RoomWidgetLoadingBarUpdateEvent.var_1382:
                    this._container.events.dispatchEvent(param1);
                    return;
                case RoomWidgetLoadingBarUpdateEvent.var_1383:
                    this._container.events.dispatchEvent(param1);
                    return;
            }

        }

        public function update(): void
        {
        }

    }
}
