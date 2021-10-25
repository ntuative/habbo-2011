package com.sulake.core.runtime.events
{

    public class ErrorEvent extends WarningEvent
    {

        protected var _critical: Boolean;
        protected var _stackTrace: String;

        public function ErrorEvent(param1: String, param2: String, critical: Boolean, stackTrace: String = null)
        {
            this._critical = critical;
            this._stackTrace = stackTrace;
            super(param1, param2);
        }

        public function get critical(): Boolean
        {
            return this._critical;
        }

        public function get stackTrace(): String
        {
            return this._stackTrace;
        }

    }
}
