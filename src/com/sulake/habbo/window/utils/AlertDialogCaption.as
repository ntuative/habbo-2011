package com.sulake.habbo.window.utils
{

    import com.sulake.habbo.window.utils.ICaption;

    internal class AlertDialogCaption implements ICaption
    {

        private var _text: String;
        private var _tooltip: String;
        private var _visible: Boolean;

        public function AlertDialogCaption(text: String, tooltip: String, visible: Boolean)
        {
            this._text = text;
            this._tooltip = tooltip;
            this._visible = visible;
        }

        public function get text(): String
        {
            return this._text;
        }

        public function set text(value: String): void
        {
            this._text = value;
        }

        public function get toolTip(): String
        {
            return this._tooltip;
        }

        public function set toolTip(value: String): void
        {
            this._tooltip = value;
        }

        public function get visible(): Boolean
        {
            return this._visible;
        }

        public function set visible(value: Boolean): void
        {
            this._visible = value;
        }

    }
}
