package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FriendRequestData 
    {

        private var var_2913:int;
        private var var_2914:String;
        private var var_2915:int;

        public function FriendRequestData(param1:IMessageDataWrapper)
        {
            this.var_2913 = param1.readInteger();
            this.var_2914 = param1.readString();
            this.var_2915 = int(param1.readString());
        }

        public function get requestId():int
        {
            return (this.var_2913);
        }

        public function get requesterName():String
        {
            return (this.var_2914);
        }

        public function get requesterUserId():int
        {
            return (this.var_2915);
        }

    }
}