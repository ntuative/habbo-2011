package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CfhChatlogData 
    {

        private var var_2951:int;
        private var var_2952:int;
        private var var_2953:int;
        private var var_2954:int;
        private var var_2955:RoomChatlogData;

        public function CfhChatlogData(param1:IMessageDataWrapper)
        {
            this.var_2951 = param1.readInteger();
            this.var_2952 = param1.readInteger();
            this.var_2953 = param1.readInteger();
            this.var_2954 = param1.readInteger();
            this.var_2955 = new RoomChatlogData(param1);
            Logger.log(("READ CFHCHATLOGDATA: callId: " + this.var_2951));
        }

        public function get callId():int
        {
            return (this.var_2951);
        }

        public function get callerUserId():int
        {
            return (this.var_2952);
        }

        public function get reportedUserId():int
        {
            return (this.var_2953);
        }

        public function get chatRecordId():int
        {
            return (this.var_2954);
        }

        public function get room():RoomChatlogData
        {
            return (this.var_2955);
        }

    }
}