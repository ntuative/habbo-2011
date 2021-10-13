package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AcceptBuddyFailureData 
    {

        private var var_2907:String;
        private var var_2102:int;

        public function AcceptBuddyFailureData(param1:IMessageDataWrapper)
        {
            this.var_2907 = param1.readString();
            this.var_2102 = param1.readInteger();
        }

        public function get senderName():String
        {
            return (this.var_2907);
        }

        public function get errorCode():int
        {
            return (this.var_2102);
        }

    }
}