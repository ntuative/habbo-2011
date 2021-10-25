package com.sulake.habbo.localization
{

    public class BadgeBaseAndLevel
    {

        private var _base: String = "";
        private var _level: int = 1;

        public function BadgeBaseAndLevel(id: String)
        {
            var offset: int = id.length - 1;

            while (offset > 0 && this.isNumber(id.charAt(offset)))
            {
                offset--;
            }

            this._base = id.substring(0, offset + 1);

            var level: String = id.substring(offset + 1, id.length);
            if (level != null && level != "")
            {
                this._level = int(level);
            }

            Logger.log("Split badgeId " + id + " into " + this._base + " and " + this._level);
        }

        private function isNumber(value: String): Boolean
        {
            var charCode: int = value.charCodeAt(0);
            
            return charCode >= 48 && charCode <= 57;
        }

        public function get base(): String
        {
            return this._base;
        }

        public function get level(): int
        {
            return this._level;
        }

    }
}
