package com.sulake.habbo.communication.messages.outgoing.marketplace
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class GetMarketplaceItemStatsComposer implements IMessageComposer, IDisposable 
    {

        private var var_2217:Array = new Array();

        public function GetMarketplaceItemStatsComposer(param1:int, param2:int)
        {
            this.var_2217.push(param1);
            this.var_2217.push(param2);
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