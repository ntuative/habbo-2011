﻿package com.sulake.habbo.communication.messages.outgoing.avatar
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class CheckUserNameMessageComposer implements IMessageComposer 
    {

        private var _data:Array;

        public function CheckUserNameMessageComposer(param1:String)
        {
            this._data = new Array();
            this._data.push(param1);
        }

        public function getMessageArray():Array
        {
            return (this._data);
        }

        public function dispose():void
        {
            this._data = null;
        }

    }
}