package com.sulake.habbo.widget.messages
{

    import com.sulake.core.window.IWindowContainer;

    public class RoomWidgetChatInputWidgetMessage extends RoomWidgetMessage
    {

        public static const RWCIW_MESSAGE_POSITION_WINDOW: String = "RWCIW_MESSAGE_POSITION_WINDOW";

        private var _window: IWindowContainer;

        public function RoomWidgetChatInputWidgetMessage(message: String, window: IWindowContainer = null)
        {
            super(message);
            this._window = window;
        }

        public function get window(): IWindowContainer
        {
            return this._window;
        }

    }
}
