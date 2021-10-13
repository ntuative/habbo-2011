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

        private var _navigator:HabboNavigator;
        private var var_3873:ITextFieldWindow;
        private var var_3686:Boolean;
        private var var_3434:String = "";
        private var var_3874:int;
        private var var_3875:Function;
        private var var_3876:String = "";
        private var var_3877:IWindowContainer;
        private var var_3878:Boolean;
        private var _orgTextBackgroundColor:uint;
        private var var_3879:uint;

        public function TextFieldManager(param1:HabboNavigator, param2:ITextFieldWindow, param3:int=1000, param4:Function=null, param5:String=null)
        {
            this._navigator = param1;
            this.var_3873 = param2;
            this.var_3874 = param3;
            this.var_3875 = param4;
            if (param5 != null)
            {
                this.var_3686 = true;
                this.var_3434 = param5;
                this.var_3873.text = param5;
            };
            Util.setProcDirectly(this.var_3873, this.onInputClick);
            this.var_3873.addEventListener(WindowKeyboardEvent.var_1156, this.checkEnterPress);
            this.var_3873.addEventListener(WindowEvent.var_590, this.checkMaxLen);
            this.var_3878 = this.var_3873.textBackground;
            this._orgTextBackgroundColor = this.var_3873.textBackgroundColor;
            this.var_3879 = this.var_3873.textColor;
        }

        public function checkMandatory(param1:String):Boolean
        {
            if (!this.isInputValid())
            {
                this.displayError(param1);
                return (false);
            };
            this.restoreBackground();
            return (true);
        }

        public function restoreBackground():void
        {
            this.var_3873.textBackground = this.var_3878;
            this.var_3873.textBackgroundColor = this._orgTextBackgroundColor;
            this.var_3873.textColor = this.var_3879;
        }

        public function displayError(param1:String):void
        {
            this.var_3873.textBackground = true;
            this.var_3873.textBackgroundColor = 4294021019;
            this.var_3873.textColor = 0xFF000000;
            if (this.var_3877 == null)
            {
                this.var_3877 = IWindowContainer(this._navigator.getXmlWindow("nav_error_popup"));
                this._navigator.refreshButton(this.var_3877, "popup_arrow_down", true, null, 0);
                IWindowContainer(this.var_3873.parent).addChild(this.var_3877);
            };
            var _loc2_:ITextWindow = ITextWindow(this.var_3877.findChildByName("error_text"));
            _loc2_.text = param1;
            _loc2_.width = (_loc2_.textWidth + 5);
            this.var_3877.findChildByName("border").width = (_loc2_.width + 15);
            this.var_3877.width = (_loc2_.width + 15);
            var _loc3_:Point = new Point();
            this.var_3873.getLocalPosition(_loc3_);
            this.var_3877.x = _loc3_.x;
            this.var_3877.y = ((_loc3_.y - this.var_3877.height) + 3);
            var _loc4_:IWindow = this.var_3877.findChildByName("popup_arrow_down");
            _loc4_.x = ((this.var_3877.width / 2) - (_loc4_.width / 2));
            this.var_3877.x = (this.var_3877.x + ((this.var_3873.width - this.var_3877.width) / 2));
            this.var_3877.visible = true;
        }

        public function goBackToInitialState():void
        {
            this.clearErrors();
            if (this.var_3434 != null)
            {
                this.var_3873.text = this.var_3434;
                this.var_3686 = true;
            }
            else
            {
                this.var_3873.text = "";
                this.var_3686 = false;
            };
        }

        public function getText():String
        {
            if (this.var_3686)
            {
                return (this.var_3876);
            };
            return (this.var_3873.text);
        }

        public function setText(param1:String):void
        {
            this.var_3686 = false;
            this.var_3873.text = param1;
        }

        public function clearErrors():void
        {
            this.restoreBackground();
            if (this.var_3877 != null)
            {
                this.var_3877.visible = false;
            };
        }

        public function get input():ITextFieldWindow
        {
            return (this.var_3873);
        }

        private function isInputValid():Boolean
        {
            return ((!(this.var_3686)) && (Util.trim(this.getText()).length > 2));
        }

        private function onInputClick(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowEvent.var_552)
            {
                return;
            };
            if (!this.var_3686)
            {
                return;
            };
            this.var_3873.text = this.var_3876;
            this.var_3686 = false;
            this.restoreBackground();
        }

        private function checkEnterPress(param1:WindowKeyboardEvent):void
        {
            if (param1.charCode == Keyboard.ENTER)
            {
                if (this.var_3875 != null)
                {
                    this.var_3875();
                };
            };
        }

        private function checkMaxLen(param1:WindowEvent):void
        {
            var _loc2_:String = this.var_3873.text;
            if (_loc2_.length > this.var_3874)
            {
                this.var_3873.text = _loc2_.substring(0, this.var_3874);
            };
        }

    }
}