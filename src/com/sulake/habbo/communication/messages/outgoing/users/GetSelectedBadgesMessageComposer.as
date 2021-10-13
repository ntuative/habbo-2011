package com.sulake.habbo.communication.messages.outgoing.users
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class GetSelectedBadgesMessageComposer implements IMessageComposer, IDisposable 
    {

        private var var_2217:Array = [];

        public function GetSelectedBadgesMessageComposer(param1:int)
        {
            this.var_2217.push(int(param1));
        }

        public function getMessageArray():Array
        {
            return (this.var_2217);
        }

        public function dispose():void
        {
            this.var_2217 = null;
        }

        public function get disposed():Boolean
        {
            return (false);
        }

    }
}