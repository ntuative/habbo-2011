package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomEventData implements IDisposable 
    {

        private var var_2971:Boolean;
        private var var_3007:int;
        private var var_3008:String;
        private var var_2972:int;
        private var var_3009:int;
        private var var_3010:String;
        private var var_3011:String;
        private var var_3012:String;
        private var var_1029:Array = new Array();
        private var _disposed:Boolean;

        public function RoomEventData(param1:IMessageDataWrapper)
        {
            var _loc5_:String;
            super();
            var _loc2_:String = param1.readString();
            if (_loc2_ == "-1")
            {
                Logger.log("Got null room event");
                this.var_2971 = false;
                return;
            };
            this.var_2971 = true;
            this.var_3007 = int(_loc2_);
            this.var_3008 = param1.readString();
            this.var_2972 = int(param1.readString());
            this.var_3009 = param1.readInteger();
            this.var_3010 = param1.readString();
            this.var_3011 = param1.readString();
            this.var_3012 = param1.readString();
            var _loc3_:int = param1.readInteger();
            var _loc4_:int;
            while (_loc4_ < _loc3_)
            {
                _loc5_ = param1.readString();
                this.var_1029.push(_loc5_);
                _loc4_++;
            };
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

        public function get ownerAvatarId():int
        {
            return (this.var_3007);
        }

        public function get ownerAvatarName():String
        {
            return (this.var_3008);
        }

        public function get flatId():int
        {
            return (this.var_2972);
        }

        public function get eventType():int
        {
            return (this.var_3009);
        }

        public function get eventName():String
        {
            return (this.var_3010);
        }

        public function get eventDescription():String
        {
            return (this.var_3011);
        }

        public function get creationTime():String
        {
            return (this.var_3012);
        }

        public function get tags():Array
        {
            return (this.var_1029);
        }

        public function get exists():Boolean
        {
            return (this.var_2971);
        }

    }
}