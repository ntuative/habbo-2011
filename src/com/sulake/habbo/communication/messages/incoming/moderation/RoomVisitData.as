package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomVisitData 
    {

        private var var_2969:Boolean;
        private var _roomId:int;
        private var var_2970:String;
        private var var_2976:int;
        private var var_2977:int;

        public function RoomVisitData(param1:IMessageDataWrapper)
        {
            this.var_2969 = param1.readBoolean();
            this._roomId = param1.readInteger();
            this.var_2970 = param1.readString();
            this.var_2976 = param1.readInteger();
            this.var_2977 = param1.readInteger();
        }

        public function get isPublic():Boolean
        {
            return (this.var_2969);
        }

        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomName():String
        {
            return (this.var_2970);
        }

        public function get enterHour():int
        {
            return (this.var_2976);
        }

        public function get enterMinute():int
        {
            return (this.var_2977);
        }

    }
}