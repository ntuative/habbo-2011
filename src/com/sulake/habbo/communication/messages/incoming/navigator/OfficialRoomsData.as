package com.sulake.habbo.communication.messages.incoming.navigator
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OfficialRoomsData implements IDisposable, MsgWithRequestId
    {

        private var _entries: Array = [];
        private var _disposed: Boolean;

        public function OfficialRoomsData(param1: IMessageDataWrapper)
        {
            var roomCount: int = param1.readInteger();
            var i: int;

            while (i < roomCount)
            {
                this._entries.push(new OfficialRoomEntryData(param1));
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

            var entry: OfficialRoomEntryData;

            if (this._entries != null)
            {
                for each (entry in this._entries)
                {
                    entry.dispose();
                }

            }


            this._entries = null;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get entries(): Array
        {
            return this._entries;
        }

    }
}
