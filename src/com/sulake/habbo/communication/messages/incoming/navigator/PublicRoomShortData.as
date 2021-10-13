﻿package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PublicRoomShortData implements IDisposable 
    {

        private var var_3002:String;
        private var var_3004:int;
        private var _disposed:Boolean;

        public function PublicRoomShortData(param1:IMessageDataWrapper)
        {
            this.var_3002 = param1.readString();
            this.var_3004 = param1.readInteger();
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

        public function get worldId():int
        {
            return (this.var_3004);
        }

    }
}