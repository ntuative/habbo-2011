package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class GuestRoomSearchResultData implements IDisposable, MsgWithRequestId 
    {

        private var _searchType:int;
        private var var_2989:String;
        private var var_2978:Array = new Array();
        private var var_2990:OfficialRoomEntryData;
        private var _disposed:Boolean;

        public function GuestRoomSearchResultData(param1:IMessageDataWrapper):void
        {
            this._searchType = param1.readInteger();
            this.var_2989 = param1.readString();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_2978.push(new GuestRoomData(param1));
                _loc3_++;
            };
            var _loc4_:Boolean = param1.readBoolean();
            if (_loc4_)
            {
                this.var_2990 = new OfficialRoomEntryData(param1);
            };
        }

        public function dispose():void
        {
            var _loc1_:GuestRoomData;
            if (this._disposed)
            {
                return;
            };
            this._disposed = true;
            if (this.var_2978 != null)
            {
                for each (_loc1_ in this.var_2978)
                {
                    _loc1_.dispose();
                };
            };
            if (this.var_2990 != null)
            {
                this.var_2990.dispose();
                this.var_2990 = null;
            };
            this.var_2978 = null;
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get searchType():int
        {
            return (this._searchType);
        }

        public function get searchParam():String
        {
            return (this.var_2989);
        }

        public function get rooms():Array
        {
            return (this.var_2978);
        }

        public function get ad():OfficialRoomEntryData
        {
            return (this.var_2990);
        }

    }
}