package com.sulake.habbo.navigator
{

    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.ITextWindow;

    import flash.geom.Point;

    import com.sulake.core.window.IWindow;

    import flash.ui.Keyboard;

    public class TextFieldManager
    {

        private var _navigator: HabboNavigator;
        private var _input: ITextFieldWindow;
        private var var_3686: Boolean;
        private var _orgInput: String = "";
        private var _maxLength: int;
        private var _callback: Function;
        private var var_3876: String = "";
        private var _errorPopup: IWindowContainer;
        private var _orgTextBackground: Boolean;
        private var _orgTextBackgroundColor: uint;
        private var _orgTextColor: uint;

        public function TextFieldManager(param1: HabboNavigator, param2: ITextFieldWindow, param3: int = 1000, param4: Function = null, param5: String = null)
        {
            this._navigator = param1;
            this._input = param2;
            this._maxLength = param3;
            this._callback = param4;
            
            if (param5 != null)
            {
                this.var_3686 = true;
                this._orgInput = param5;
                this._input.text = param5;
            }

            Util.setProcDirectly(this._input, this.onInputClick);
            this._input.addEventListener(WindowKeyboardEvent.var_1156, this.checkEnterPress);
            this._input.addEventListener(WindowEvent.var_590, this.checkMaxLen);
            this._orgTextBackground = this._input.textBackground;
            this._orgTextBackgroundColor = this._input.textBackgroundColor;
            this._orgTextColor = this._input.textColor;
        }

        public function checkMandatory(param1: String): Boolean
        {
            if (!this.isInputValid())
            {
                this.displayError(param1);
                return false;
            }

            this.restoreBackground();
            return true;
        }

        public function restoreBackground(): void
        {
            this._input.textBackground = this._orgTextBackground;
            this._input.textBackgroundColor = this._orgTextBackgroundColor;
            this._input.textColor = this._orgTextColor;
        }

        public function displayError(param1: String): void
        {
            this._input.textBackground = true;
            this._input.textBackgroundColor = 4294021019;
            this._input.textColor = 0xFF000000;
            
            if (this._errorPopup == null)
            {
                this._errorPopup = IWindowContainer(this._navigator.getXmlWindow("nav_error_popup"));
                this._navigator.refreshButton(this._errorPopup, "popup_arrow_down", true, null, 0);
                IWindowContainer(this._input.parent).addChild(this._errorPopup);
            }

            var errorText: ITextWindow = ITextWindow(this._errorPopup.findChildByName("error_text"));
            errorText.text = param1;
            errorText.width = errorText.textWidth + 5;
            this._errorPopup.findChildByName("border").width = errorText.width + 15;
            this._errorPopup.width = errorText.width + 15;
            var loc: Point = new Point();
            this._input.getLocalPosition(loc);
            this._errorPopup.x = loc.x;
            this._errorPopup.y = (loc.y - this._errorPopup.height) + 3;
            var popupArrow: IWindow = this._errorPopup.findChildByName("popup_arrow_down");
            popupArrow.x = this._errorPopup.width / 2 - popupArrow.width / 2;
            this._errorPopup.x = this._errorPopup.x + (this._input.width - this._errorPopup.width) / 2;
            this._errorPopup.visible = true;
        }

        public function goBackToInitialState(): void
        {
            this.clearErrors();

            if (this._orgInput != null)
            {
                this._input.text = this._orgInput;
                this.var_3686 = true;
            }
            else
            {
                this._input.text = "";
                this.var_3686 = false;
            }

        }

        public function getText(): String
        {
            if (this.var_3686)
            {
                return this.var_3876;
            }

            return this._input.text;
        }

        public function setText(param1: String): void
        {
            this.var_3686 = false;
            this._input.text = param1;
        }

        public function clearErrors(): void
        {
            this.restoreBackground();

            if (this._errorPopup != null)
            {
                this._errorPopup.visible = false;
            }

        }

        public function get input(): ITextFieldWindow
        {
            return this._input;
        }

        private function isInputValid(): Boolean
        {
            return !this.var_3686 && Util.trim(this.getText()).length > 2;
        }

        private function onInputClick(param1: WindowEvent, param2: IWindow): void
        {
            if (param1.type != WindowEvent.var_552)
            {
                return;
            }

            if (!this.var_3686)
            {
                return;
            }

            this._input.text = this.var_3876;
            this.var_3686 = false;
            this.restoreBackground();
        }

        private function checkEnterPress(param1: WindowKeyboardEvent): void
        {
            if (param1.charCode == Keyboard.ENTER)
            {
                if (this._callback != null)
                {
                    this._callback();
                }

            }

        }

        private function checkMaxLen(param1: WindowEvent): void
        {
            var text: String = this._input.text;
            
            if (text.length > this._maxLength)
            {
                this._input.text = text.substring(0, this._maxLength);
            }

        }

    }
}
