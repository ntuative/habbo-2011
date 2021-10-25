package com.sulake.habbo.utils
{

    import flash.net.URLRequest;
    import flash.external.ExternalInterface;
    import flash.net.navigateToURL;

    public class HabboWebTools
    {

        public static const var_643: String = "advertisement";

        public static function openWebPage(param1: String, param2: String = ""): void
        {
            var _loc4_: String;
            if (param2 == null || param2 == "")
            {
                param2 = var_643;
            }

            var _loc3_: URLRequest = new URLRequest(param1);
            if (!ExternalInterface.available)
            {
                flash.net.navigateToURL(_loc3_, param2);
            }
            else
            {
                _loc4_ = String(ExternalInterface.call("function() {return navigator.userAgent;}")).toLowerCase();
                if (_loc4_.indexOf("firefox") != -1 || _loc4_.indexOf("msie") != -1 && uint(_loc4_.substr(_loc4_.indexOf("msie") + 5, 3)) >= 7)
                {
                    ExternalInterface.call("window.open", _loc3_.url, param2);
                }
                else
                {
                    flash.net.navigateToURL(_loc3_, param2);
                }

            }

        }

        public static function navigateToURL(param1: String, param2: String = null): void
        {
            var _loc3_: URLRequest = new URLRequest(param1);
            flash.net.navigateToURL(_loc3_, param2);
        }

        public static function openExternalLinkWarning(param1: String): void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("FlashExternalInterface.openExternalLink", escape(param1));
            }
            else
            {
                Logger.log("External interface not available. Could not request to open: " + param1);
            }

        }

        public static function facebookLike(param1: int): void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("FlashExternalInterface.fbLike", param1);
            }
            else
            {
                Logger.log("External interface not available. Could not request Facebook like view.");
            }

        }

        public static function facebookAchievementPost(param1: String, param2: String, param3: String, param4: String): void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("FlashExternalInterface.postAchievementShareBonus", param1, param2, param3, param4);
            }
            else
            {
                Logger.log("External interface not available. Could not request Facebook achievement post view.");
            }

        }

        public static function facebookViralGiftPost(param1: String, param2: String, param3: String, param4: String, param5: String): void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("FlashExternalInterface.postXmasViral", param1, param2, param3, param4, param5);
            }
            else
            {
                Logger.log("External interface not available. Could not request Facebook viral post view.");
            }

        }

    }
}
