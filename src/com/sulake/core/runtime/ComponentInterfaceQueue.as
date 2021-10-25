package com.sulake.core.runtime
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IID;

    internal class ComponentInterfaceQueue implements IDisposable
    {

        private var _identifier: IID;
        private var _disposed: Boolean;
        private var _receivers: Array;

        public function ComponentInterfaceQueue(param1: IID)
        {
            this._identifier = param1;
            this._receivers = [];
            this._disposed = false;
        }

        public function get identifier(): IID
        {
            return this._identifier;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get receivers(): Array
        {
            return this._receivers;
        }

        public function dispose(): void
        {
            if (!this._disposed)
            {
                this._disposed = true;
                this._identifier = null;

                while (this._receivers.length > 0)
                {
                    this._receivers.pop();
                }


                this._receivers = null;
            }

        }

    }
}
