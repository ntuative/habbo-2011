package com.sulake.habbo.communication.messages.incoming.navigator
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PopularRoomTagsData implements IDisposable, MsgWithRequestId
    {

        private var _tags: Array = [];
        private var _disposed: Boolean;

        public function PopularRoomTagsData(param1: IMessageDataWrapper)
        {
            var tagCount: int = param1.readInteger();
            var i: int;

            while (i < tagCount)
            {
                this._tags.push(new PopularTagData(param1));
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
            this._tags = null;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get tags(): Array
        {
            return this._tags;
        }

    }
}
