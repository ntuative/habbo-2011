package com.sulake.habbo.widget.poll
{

    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.widget.messages.RoomWidgetPollMessage;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class PollOfferDialog implements IPollDialog
    {

        public static const var_1973: String = "POLL_OFFER_STATE_OK";
        public static const var_1974: String = "POLL_OFFER_STATE_CANCEL";
        public static const var_592: String = "POLL_OFFER_STATE_UNKNOWN";

        private var _disposed: Boolean = false;
        private var _window: IFrameWindow;
        private var _state: String = "POLL_OFFER_STATE_UNKNOWN";
        private var _widget: PollWidget;
        private var _id: int = -1;

        public function PollOfferDialog(param1: int, param2: String, param3: PollWidget)
        {
            var _loc5_: ITextWindow;
            var _loc6_: IItemListWindow;
            super();
            this._id = param1;
            this._widget = param3;
            var _loc4_: XmlAsset = this._widget.assets.getAssetByName("poll_offer") as XmlAsset;
            if (_loc4_)
            {
                this._window = (this._widget.windowManager.buildFromXML(_loc4_.content as XML) as IFrameWindow);
                if (this._window)
                {
                    this._window.center();
                    this._window.procedure = this.offerDialogEventProc;
                    _loc5_ = (this._window.findChildByName("poll_offer_summary") as ITextWindow);
                    if (_loc5_)
                    {
                        _loc5_.htmlText = param2;
                        _loc6_ = (this._window.findChildByName("poll_offer_summary_wrapper") as IItemListWindow);
                        if (_loc6_)
                        {
                            this._window.height = this._window.height + (_loc6_.scrollableRegion.height - _loc6_.visibleRegion.height);
                        }

                    }

                }

            }

        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get state(): String
        {
            return this._state;
        }

        public function dispose(): void
        {
            if (!this._disposed)
            {
                if (this._window)
                {
                    this._window.dispose();
                    this._window = null;
                }

                this._widget = null;
                this._disposed = true;
            }

        }

        private function offerDialogEventProc(param1: WindowEvent, param2: IWindow): void
        {
            if (this._state == var_592)
            {
                if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
                {
                    switch (param2.name)
                    {
                        case "poll_offer_button_ok":
                            this._state = var_1973;
                            this._widget.messageListener.processWidgetMessage(new RoomWidgetPollMessage(RoomWidgetPollMessage.var_1890, this._id));
                            return;
                        case "poll_offer_button_cancel":
                            this._state = var_1974;
                            this._widget.messageListener.processWidgetMessage(new RoomWidgetPollMessage(RoomWidgetPollMessage.var_1889, this._id));
                            this._widget.pollCancelled(this._id);
                            return;
                        case "poll_offer_button_later":
                            this._state = var_1974;
                            this._widget.pollCancelled(this._id);
                            return;
                        case "header_button_close":
                            this._state = var_1974;
                            this._widget.messageListener.processWidgetMessage(new RoomWidgetPollMessage(RoomWidgetPollMessage.var_1889, this._id));
                            this._widget.pollCancelled(this._id);
                            return;
                    }

                }

            }

        }

    }
}
