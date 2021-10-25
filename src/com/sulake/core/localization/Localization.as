package com.sulake.core.localization
{

    import flash.utils.Dictionary;

    public class Localization implements ILocalization
    {

        private var _key: String;
        private var _raw: String;
        private var _parameters: Dictionary;
        private var _listeners: Array;
        private var _unknown1: Boolean = false;

        public function Localization(key: String, raw: String = null)
        {
            this._listeners = [];
            this._parameters = new Dictionary();
            this._key = key;
            this._raw = raw;
        }

        public function get isInitialized(): Boolean
        {
            return this._raw != null;
        }

        public function get key(): String
        {
            return this._key;
        }

        public function get value(): String
        {
            return this.fillParameterValues();
        }

        public function get raw(): String
        {
            return this._raw;
        }

        public function setValue(value: String): void
        {
            this._raw = value;
            this.updateListeners();
        }

        public function registerListener(listener: ILocalizable): void
        {
            this._listeners.push(listener);
            listener.localization = this.value;
        }

        public function removeListener(listener: ILocalizable): void
        {
            var index: int = this._listeners.indexOf(listener);

            if (index >= 0)
            {
                this._listeners.splice(index, 1);
            }

        }

        public function registerParameter(name: String, value: String, templateChar: String = "%"): void
        {
            // %name%
            name = templateChar + name + templateChar;
            this._parameters[name] = value;
            this.updateListeners();
        }

        public function updateListeners(): void
        {
            var listener: ILocalizable;

            for each (listener in this._listeners)
            {
                listener.localization = this.value;
            }

        }

        private function fillParameterValues(): String
        {
            var param: String;
            var value: String;
            var regex: RegExp;
            var raw: String = this._raw;

            for (param in this._parameters)
            {
                value = this._parameters[param];

                regex = new RegExp(param, "gim");

                if (raw != null)
                {
                    raw = raw.replace(regex, value);
                }

            }


            return raw;
        }

    }
}
