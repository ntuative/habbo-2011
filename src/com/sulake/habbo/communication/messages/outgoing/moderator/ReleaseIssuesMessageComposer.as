package com.sulake.habbo.communication.messages.outgoing.moderator
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class ReleaseIssuesMessageComposer implements IMessageComposer, IDisposable 
    {

        private var var_2217:Array = new Array();

        public function ReleaseIssuesMessageComposer(param1:Array)
        {
            this.var_2217.push(param1.length);
            var _loc2_:int;
            while (_loc2_ < param1.length)
            {
                this.var_2217.push(param1[_loc2_]);
                _loc2_++;
            };
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