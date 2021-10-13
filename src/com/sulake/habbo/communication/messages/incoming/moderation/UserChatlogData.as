package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserChatlogData 
    {

        private var _userId:int;
        private var _userName:String;
        private var var_2978:Array = new Array();

        public function UserChatlogData(param1:IMessageDataWrapper)
        {
            this._userId = param1.readInteger();
            this._userName = param1.readString();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_2978.push(new RoomChatlogData(param1));
                _loc3_++;
            };
        }

        public function get userId():int
        {
            return (this._userId);
        }

        public function get userName():String
        {
            return (this._userName);
        }

        public function get rooms():Array
        {
            return (this.var_2978);
        }

    }
}