package com.sulake.habbo.help
{

    public class WelcomeNotification
    {

        private var _targetIconId: String;
        private var _titleLocalizationKey: String;
        private var _descriptionLocalizationKey: String;

        public function WelcomeNotification(targetIconId: String, titleLocalizationKey: String, descriptionLocalizationKey: String)
        {
            this._targetIconId = targetIconId;
            this._titleLocalizationKey = titleLocalizationKey;
            this._descriptionLocalizationKey = descriptionLocalizationKey;
        }

        public function get targetIconId(): String
        {
            return this._targetIconId;
        }

        public function get titleLocalizationKey(): String
        {
            return this._titleLocalizationKey;
        }

        public function get descriptionLocalizationKey(): String
        {
            return this._descriptionLocalizationKey;
        }

    }
}
