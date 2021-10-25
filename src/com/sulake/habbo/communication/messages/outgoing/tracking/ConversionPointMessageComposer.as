package com.sulake.habbo.communication.messages.outgoing.tracking
{

    import com.sulake.core.communication.messages.IMessageComposer;

    public class ConversionPointMessageComposer implements IMessageComposer
    {

        private var _category: String;
        private var _type: String;
        private var _action: String;
        private var var_2940: String;

        public function ConversionPointMessageComposer(param1: String, param2: String, param3: String, param4: String = "")
        {
            this._category = param1;
            this._type = param2;
            this._action = param3;
            this.var_2940 = param4;
        }

        public function dispose(): void
        {
        }

        public function getMessageArray(): Array
        {
            return [this._category, this._type, this._action, this.var_2940];
        }

    }
}
