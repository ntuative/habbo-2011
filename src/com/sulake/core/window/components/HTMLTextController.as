package com.sulake.core.window.components
{

    import com.sulake.core.window.utils.PropertyDefaults;

    import flash.text.StyleSheet;
    import flash.text.TextFieldType;

    import com.sulake.core.window.WindowContext;

    import flash.geom.Rectangle;

    import com.sulake.core.window.IWindow;

    import flash.net.URLRequest;
    import flash.external.ExternalInterface;
    import flash.net.navigateToURL;

    import com.sulake.core.window.enum.LinkTarget;

    import flash.events.TextEvent;

    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowLinkEvent;

    import flash.events.Event;

    import com.sulake.core.window.utils.PropertyStruct;

    public class HTMLTextController extends TextFieldController implements IHTMLTextWindow
    {

        private static var var_1168: String = PropertyDefaults.HTML_LINK_TARGET_VALUE;

        private var var_2002: String = PropertyDefaults.HTML_LINK_TARGET_VALUE;
        private var _htmlStyleSheetString: String = null;
        private var var_2004: StyleSheet = null;

        public function HTMLTextController(param1: String, param2: uint, param3: uint, param4: uint, param5: WindowContext, param6: Rectangle, param7: IWindow, param8: Function, param9: Array = null, param10: Array = null, param11: uint = 0)
        {
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
            this.immediateClickMode = true;
            _field.type = TextFieldType.DYNAMIC;
            _field.mouseEnabled = true;
            _field.selectable = false;
        }

        public static function set defaultLinkTarget(param1: String): void
        {
            var_1168 = param1;
        }

        public static function get defaultLinkTarget(): String
        {
            return var_1168;
        }

        private static function setHtmlStyleSheetString(param1: HTMLTextController, param2: String): void
        {
            var _loc3_: StyleSheet;
            if (param1 == null)
            {
                return;
            }

            if (param1._htmlStyleSheetString == param2)
            {
                return;
            }

            param1._htmlStyleSheetString = param2;
            param1.var_2004 = null;
            if (param1._htmlStyleSheetString != null)
            {
                _loc3_ = new StyleSheet();
                _loc3_.parseCSS(param1._htmlStyleSheetString);
                param1.var_2004 = _loc3_;
            }

        }

        private static function convertLinksToEvents(param1: String): String
        {
            var _loc2_: RegExp;
            _loc2_ = /<a[^>]+(http:\/\/[^"']+)['"][^>]*>(.*)<\/a>/gi;
            param1 = param1.replace(_loc2_, "<a href='event:$1'>$2</a>");
            _loc2_ = /<a[^>]+(https:\/\/[^"']+)['"][^>]*>(.*)<\/a>/gi;
            return param1.replace(_loc2_, "<a href='event:$1'>$2</a>");
        }

        private static function openWebPage(param1: String, param2: String): void
        {
            var _loc4_: String;
            var _loc5_: *;
            if (param2 == null)
            {
                param2 = var_1168;
            }

            var _loc3_: URLRequest = new URLRequest(param1);
            if (!ExternalInterface.available)
            {
                navigateToURL(_loc3_, param2);
            }
            else
            {
                _loc4_ = String(ExternalInterface.call("function() { return navigator.userAgent; }")).toLowerCase();
                if (_loc4_.indexOf("safari") > -1 || _loc4_.indexOf("chrome") > -1 || _loc4_.indexOf("firefox") > -1 || _loc4_.indexOf("msie") > -1 && uint(_loc4_.substr(_loc4_.indexOf("msie") + 5, 3)) >= 7)
                {
                    _loc5_ = ExternalInterface.call("function() {var win = window.open('" + _loc3_.url + "', '" + param2 + "'); if (win) { win.focus();} return true; }");
                    if (_loc5_)
                    {
                        Logger.log("Opened web page url = " + param1);
                    }

                }
                else
                {
                    navigateToURL(_loc3_, param2);
                }

            }

        }

        public function set linkTarget(param1: String): void
        {
            if (PropertyDefaults.var_1169.indexOf(param1) > -1)
            {
                this.var_2002 = param1;
            }

        }

        public function get linkTarget(): String
        {
            return this.var_2002 == LinkTarget.var_525 ? defaultLinkTarget : this.var_2002;
        }

        public function get htmlStyleSheetString(): String
        {
            return this._htmlStyleSheetString;
        }

        public function set htmlStyleSheetString(value: String): void
        {
            setHtmlStyleSheetString(this, value);
        }

        override public function set immediateClickMode(param1: Boolean): void
        {
            if (param1 != _immediateClickMode)
            {
                super.immediateClickMode = param1;
                if (_immediateClickMode)
                {
                    _field.addEventListener(TextEvent.LINK, this.immediateClickHandler);
                }
                else
                {
                    _field.removeEventListener(TextEvent.LINK, this.immediateClickHandler);
                }

            }

        }

        override public function set text(value: String): void
        {
            if (value == null)
            {
                return;
            }


            if (var_1171)
            {
                context.removeLocalizationListener(_caption.slice(2, _caption.indexOf("}")), this);
                var_1171 = false;
            }


            _caption = value;

            if (_caption.charAt(0) == "$" && _caption.charAt(1) == "{")
            {
                context.registerLocalizationListener(_caption.slice(2, _caption.indexOf("}")), this);
                var_1171 = true;
            }
            else
            {
                if (_field != null)
                {
                    _field.htmlText = convertLinksToEvents(_caption);
                    refreshTextImage();
                }

            }

        }

        override public function set localization(value: String): void
        {
            if (value != null && _field != null)
            {
                _field.htmlText = convertLinksToEvents(value);
                refreshTextImage();
            }

        }

        override public function set htmlText(value: String): void
        {
            if (value == null)
            {
                return;
            }


            if (var_1171)
            {
                context.removeLocalizationListener(_caption.slice(2, _caption.indexOf("}")), this);
                var_1171 = false;
            }


            _caption = value;

            if (_caption.charAt(0) == "$" && _caption.charAt(1) == "{")
            {
                context.registerLocalizationListener(_caption.slice(2, _caption.indexOf("}")), this);
                var_1171 = true;
            }
            else
            {
                if (_field != null)
                {
                    _field.htmlText = convertLinksToEvents(_caption);
                    _field.styleSheet = this.var_2004;
                    refreshTextImage();
                }

            }

        }

        override protected function immediateClickHandler(param1: Event): void
        {
            var _loc2_: WindowEvent;
            if (param1 is TextEvent)
            {
                _loc2_ = WindowLinkEvent.allocate(TextEvent(param1).text, this, null);
                _events.dispatchEvent(_loc2_);
                if (!_loc2_.isWindowOperationPrevented())
                {
                    if (procedure != null)
                    {
                        procedure(_loc2_, this);
                    }

                }

                if (!_loc2_.isWindowOperationPrevented() && this.linkTarget != LinkTarget.var_1172)
                {
                    openWebPage(TextEvent(param1).text, this.linkTarget);
                }

                param1.stopImmediatePropagation();
                _loc2_.recycle();
            }
            else
            {
                super.immediateClickHandler(param1);
            }

        }

        override public function get properties(): Array
        {
            var _loc1_: Array = super.properties;
            if (this.var_2002 != PropertyDefaults.HTML_LINK_TARGET_VALUE)
            {
                _loc1_.push(new PropertyStruct(PropertyDefaults.var_1173, this.var_2002, PropertyStruct.var_613, true, PropertyDefaults.var_1169));
            }
            else
            {
                _loc1_.push(PropertyDefaults.var_1174);
            }

            return _loc1_;
        }

        override public function set properties(param1: Array): void
        {
            var _loc2_: PropertyStruct;
            for each (_loc2_ in param1)
            {
                if (_loc2_.key == PropertyDefaults.var_1173)
                {
                    this.var_2002 = (_loc2_.value as String);
                    break;
                }

                if (_loc2_.key == "html_stylesheet")
                {
                    this.htmlStyleSheetString = (_loc2_.value as String);
                    break;
                }

            }

            super.properties = param1;
        }

    }
}
