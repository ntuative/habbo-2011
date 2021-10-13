package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class GuestRoomData implements IDisposable 
    {

        private var var_2972:int;
        private var var_2227:Boolean;
        private var var_2970:String;
        private var _ownerName:String;
        private var var_2981:int;
        private var var_2973:int;
        private var var_2982:int;
        private var var_2400:String;
        private var var_2983:int;
        private var var_2984:Boolean;
        private var var_2985:int;
        private var var_2465:int;
        private var var_2986:String;
        private var var_1029:Array = new Array();
        private var var_2987:RoomThumbnailData;
        private var var_2988:Boolean;
        private var _disposed:Boolean;

        public function GuestRoomData(param1:IMessageDataWrapper)
        {
            var _loc4_:String;
            super();
            this.var_2972 = param1.readInteger();
            this.var_2227 = param1.readBoolean();
            this.var_2970 = param1.readString();
            this._ownerName = param1.readString();
            this.var_2981 = param1.readInteger();
            this.var_2973 = param1.readInteger();
            this.var_2982 = param1.readInteger();
            this.var_2400 = param1.readString();
            this.var_2983 = param1.readInteger();
            this.var_2984 = param1.readBoolean();
            this.var_2985 = param1.readInteger();
            this.var_2465 = param1.readInteger();
            this.var_2986 = param1.readString();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                _loc4_ = param1.readString();
                this.var_1029.push(_loc4_);
                _loc3_++;
            };
            this.var_2987 = new RoomThumbnailData(param1);
            this.var_2988 = param1.readBoolean();
        }

        public function dispose():void
        {
            if (this._disposed)
            {
                return;
            };
            this._disposed = true;
            this.var_1029 = null;
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get flatId():int
        {
            return (this.var_2972);
        }

        public function get event():Boolean
        {
            return (this.var_2227);
        }

        public function get roomName():String
        {
            return (this.var_2970);
        }

        public function get ownerName():String
        {
            return (this._ownerName);
        }

        public function get doorMode():int
        {
            return (this.var_2981);
        }

        public function get userCount():int
        {
            return (this.var_2973);
        }

        public function get maxUserCount():int
        {
            return (this.var_2982);
        }

        public function get description():String
        {
            return (this.var_2400);
        }

        public function get srchSpecPrm():int
        {
            return (this.var_2983);
        }

        public function get allowTrading():Boolean
        {
            return (this.var_2984);
        }

        public function get score():int
        {
            return (this.var_2985);
        }

        public function get categoryId():int
        {
            return (this.var_2465);
        }

        public function get eventCreationTime():String
        {
            return (this.var_2986);
        }

        public function get tags():Array
        {
            return (this.var_1029);
        }

        public function get thumbnail():RoomThumbnailData
        {
            return (this.var_2987);
        }

        public function get allowPets():Boolean
        {
            return (this.var_2988);
        }

    }
}