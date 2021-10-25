package com.sulake.habbo.friendbar.view.utils
{

    import com.sulake.core.runtime.IDisposable;

    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;

    import com.sulake.core.window.components.ITextWindow;

    public class TextCropper implements IDisposable
    {

        private var _disposed: Boolean = false;
        private var var_3397: TextField;
        private var var_3398: TextFormat;
        private var var_3399: String = "...";
        private var var_3400: int = 20;

        public function TextCropper()
        {
            this.var_3397 = new TextField();
            this.var_3397.autoSize = TextFieldAutoSize.LEFT;
            this.var_3398 = this.var_3397.defaultTextFormat;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function dispose(): void
        {
            if (!this._disposed)
            {
                this.var_3397 = null;
                this._disposed = true;
            }

        }

        public function crop(param1: ITextWindow): void
        {
            var _loc3_: int;
            this.var_3398.font = param1.fontFace;
            this.var_3398.size = param1.fontSize;
            this.var_3398.bold = param1.bold;
            this.var_3398.italic = param1.italic;
            this.var_3397.setTextFormat(this.var_3398);
            this.var_3397.text = param1.getLineText(0);
            var _loc2_: int = this.var_3397.textWidth;
            if (_loc2_ > param1.width)
            {
                _loc3_ = int(this.var_3397.getCharIndexAtPoint(param1.width - this.var_3400, this.var_3397.textHeight / 2));
                param1.text = param1.text.slice(0, _loc3_) + this.var_3399;
            }

        }

    }
}
