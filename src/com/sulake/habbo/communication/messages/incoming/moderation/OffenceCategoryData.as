package com.sulake.habbo.communication.messages.incoming.moderation
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OffenceCategoryData implements INamed, IDisposable
    {

        private var _name: String;
        private var _offences: Array = [];
        private var _disposed: Boolean;

        public function OffenceCategoryData(data: IMessageDataWrapper)
        {
            this._name = data.readString();

            Logger.log("READ CAT: " + this._name);

            var offenceCount: int = data.readInteger();
            var i: int;

            while (i < offenceCount)
            {
                this._offences.push(new OffenceData(data));
                i++;
            }

        }

        public function dispose(): void
        {
            if (this._disposed)
            {
                return;
            }


            this._disposed = true;
            this._offences = null;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get name(): String
        {
            return this._name;
        }

        public function get offences(): Array
        {
            return this._offences;
        }

    }
}
