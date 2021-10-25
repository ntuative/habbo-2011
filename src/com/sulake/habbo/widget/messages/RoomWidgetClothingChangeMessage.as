package com.sulake.habbo.widget.messages
{

    import com.sulake.core.window.IWindowContainer;

    public class RoomWidgetClothingChangeMessage extends RoomWidgetMessage
    {

        public static const var_1376: String = "RWCCM_REQUEST_EDITOR";

        private var var_2358: int = 0;
        private var var_3098: int = 0;
        private var _roomId: int = 0;
        private var _roomCategory: int = 0;
        private var var_2071: String = "";
        private var _window: IWindowContainer = null;

        public function RoomWidgetClothingChangeMessage(param1: String, param2: String, param3: int, param4: int, param5: int, param6: int, param7: IWindowContainer)
        {
            super(param1);
            this.var_2071 = param2;
            this.var_2358 = param3;
            this.var_3098 = param4;
            this._roomId = param5;
            this._roomCategory = param6;
            this._window = param7;
        }

        public function get objectId(): int
        {
            return this.var_2358;
        }

        public function get objectCategory(): int
        {
            return this.var_3098;
        }

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomCategory(): int
        {
            return this._roomCategory;
        }

        public function get gender(): String
        {
            return this.var_2071;
        }

        public function get window(): IWindowContainer
        {
            return this._window;
        }

    }
}
