package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomModerationData implements IDisposable 
    {

        private var var_2972:int;
        private var var_2973:int;
        private var var_2974:Boolean;
        private var var_2975:int;
        private var _ownerName:String;
        private var var_2955:RoomData;
        private var var_2227:RoomData;
        private var _disposed:Boolean;

        public function RoomModerationData(param1:IMessageDataWrapper)
        {
            this.var_2972 = param1.readInteger();
            this.var_2973 = param1.readInteger();
            this.var_2974 = param1.readBoolean();
            this.var_2975 = param1.readInteger();
            this._ownerName = param1.readString();
            this.var_2955 = new RoomData(param1);
            this.var_2227 = new RoomData(param1);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            if (this._disposed)
            {
                return;
            };
            this._disposed = true;
            if (this.var_2955 != null)
            {
                this.var_2955.dispose();
                this.var_2955 = null;
            };
            if (this.var_2227 != null)
            {
                this.var_2227.dispose();
                this.var_2227 = null;
            };
        }

        public function get flatId():int
        {
            return (this.var_2972);
        }

        public function get userCount():int
        {
            return (this.var_2973);
        }

        public function get ownerInRoom():Boolean
        {
            return (this.var_2974);
        }

        public function get ownerId():int
        {
            return (this.var_2975);
        }

        public function get ownerName():String
        {
            return (this._ownerName);
        }

        public function get room():RoomData
        {
            return (this.var_2955);
        }

        public function get event():RoomData
        {
            return (this.var_2227);
        }

    }
}