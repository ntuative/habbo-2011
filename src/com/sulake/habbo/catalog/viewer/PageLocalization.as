package com.sulake.habbo.catalog.viewer
{

    import flash.utils.Dictionary;

    public class PageLocalization implements IPageLocalization
    {

        private static const var_773: Array = [
            "ctlg_header_text",
            "ctlg_description",
            "ctlg_special_txt",
            "ctlg_text_1",
            "ctlg_text_2"
        ];
        private static const var_774: Array = [
            "ctlg_header_img",
            "ctlg_teaserimg_1",
            "ctlg_special_img",
            "ctlg_teaserimg_2",
            "ctlg_teaserimg_3"
        ];
        private static const LAYOUTS_IMAGE_FIELDS: Object = {
            "frontpage3": [
                "ctlg_header_img",
                "ctlg_special_img",
                "frontpage_promotion"
            ]
        };
        private static const LAYOUTS_TEXT_FIELDS: Object = {
            "camera1": ["ctlg_header_text", "ctlg_text_1"],
            "club1": ["ctlg_text_1", "ctlg_text_2", "ctlg_text_3", "ctlg_text_4", "ctlg_text_5"],
            "club2": ["ctlg_text_1", "ctlg_text_2", "ctlg_text_3", "ctlg_text_4"],
            "presents": ["ctlg_header_text", "ctlg_text1"],
            "collectibles": ["ctlg_header_text", "ctlg_collectibles_link"],
            "purse": ["ctlg_header_text", "ctlg_special_txt"],
            "pets": ["ctlg_header_text", "ctlg_text_1", "ctlg_text_2", "ctlg_text_3"],
            "pets2": ["ctlg_header_text", "ctlg_text_1", "ctlg_text_2", "ctlg_text_3"],
            "info_credits": [
                "ctlg_text_1",
                "ctlg_text_2",
                "ctlg_text_3",
                "ctlg_text_4",
                "ctlg_text_5",
                "ctlg_text_6",
                "ctlg_text_7",
                "ctlg_text_8"
            ],
            "info_pixels": [
                "ctlg_text_1",
                "ctlg_text_2",
                "ctlg_text_3",
                "ctlg_text_4",
                "ctlg_text_5",
                "ctlg_text_6",
                "ctlg_text_7",
                "ctlg_text_8"
            ],
            "frontpage3": [
                "ctlg_txt1",
                "ctlg_txt2",
                "ctlg_txt3",
                "ctlg_txt4",
                "ctlg_txt5",
                "ctlg_txt6",
                "",
                "",
                "",
                "ctlg_txt7"
            ]
        };
        private static const var_770: Dictionary = new Dictionary();
        private static const var_772: Object = { "frontpage3": [7, 8] };
        private static const var_771: Object = { "frontpage3": [["ctlg_txt1", "ctlg_txt2"], ["ctlg_txt3"]] };

        private var _images: Array;
        private var var_2834: Array;

        {
            var_770["frontpage3"] = ["ctlg_txt3", "ctlg_txt7"];
            var_770["info_pixels"] = ["ctlg_text_5", "ctlg_text_7"];
            var_770["info_credits"] = ["ctlg_text_5", "ctlg_text_7"];
            var_770["collectibles"] = ["ctlg_collectibles_link"];
            var_770["club1"] = ["ctlg_text_5"];
            var_770["club_buy"] = ["club_link"];
            var_770["mad_money"] = ["ctlg_madmoney_button"];
        }

        public function PageLocalization(param1: Array, param2: Array)
        {
            this._images = param1;
            this.var_2834 = param2;
        }

        public function get imageCount(): int
        {
            return this._images.length;
        }

        public function get textCount(): int
        {
            return this.var_2834.length;
        }

        public function dispose(): void
        {
            this._images = null;
            this.var_2834 = null;
        }

        public function hasLinks(param1: String): Boolean
        {
            return var_770[param1] != null;
        }

        public function getLinks(param1: String): Array
        {
            return var_770[param1];
        }

        public function hasColors(param1: String): Boolean
        {
            return var_771[param1] != null && var_772[param1] != null;
        }

        public function getColorTargets(param1: String): Array
        {
            return var_771[param1];
        }

        public function getColorSources(param1: String): Array
        {
            return var_772[param1];
        }

        public function getTextElementName(param1: int, param2: String): String
        {
            var _loc3_: Array = LAYOUTS_TEXT_FIELDS[param2];
            if (_loc3_ == null)
            {
                _loc3_ = var_773;
            }

            if (param1 < _loc3_.length)
            {
                return _loc3_[param1];
            }

            return "";
        }

        public function getImageElementName(param1: int, param2: String): String
        {
            var _loc3_: Array = LAYOUTS_IMAGE_FIELDS[param2];
            if (_loc3_ == null)
            {
                _loc3_ = var_774;
            }

            if (param1 < _loc3_.length)
            {
                return _loc3_[param1];
            }

            return "";
        }

        public function getTextElementContent(param1: int): String
        {
            if (param1 < this.var_2834.length)
            {
                return this.var_2834[param1];
            }

            return "";
        }

        public function getImageElementContent(param1: int): String
        {
            if (param1 < this._images.length)
            {
                return this._images[param1];
            }

            return "";
        }

        public function getColorUintFromText(param1: int): uint
        {
            var _loc2_: String;
            if (param1 < this.var_2834.length)
            {
                _loc2_ = String(this.var_2834[param1]).replace("#", "0x");
                return uint(Number(_loc2_));
            }

            return 0;
        }

    }
}
