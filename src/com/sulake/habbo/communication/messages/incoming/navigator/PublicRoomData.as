package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PublicRoomData implements IDisposable 
    {

        private var var_3002:String;
        private var var_3003:int;
        private var var_3004:int;
        private var var_3005:String;
        private var var_3006:int;
        private var var_2979:int;
        private var _disposed:Boolean;

        public function PublicRoomData(param1:IMessageDataWrapper)
        {
            this.var_3002 = param1.readString();
            this.var_3003 = param1.readInteger();
            this.var_3004 = param1.readInteger();
            this.var_3005 = param1.readString();
            this.var_3006 = param1.readInteger();
            this.var_2979 = param1.readInteger();
        }

        public function dispose():void
        {
            if (this._disposed)
            {
                return;
            };
            this._disposed = true;
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get unitPropertySet():String
        {
            return (this.var_3002);
        }

        public function get unitPort():int
        {
            return (this.var_3003);
        }

        public function get worldId():int
        {
            return (this.var_3004);
        }

        public function get castLibs():String
        {
            return (this.var_3005);
        }

        public function get maxUsers():int
        {
            return (this.var_3006);
        }

        public function get nodeId():int
        {
            return (this.var_2979);
        }

    }
}