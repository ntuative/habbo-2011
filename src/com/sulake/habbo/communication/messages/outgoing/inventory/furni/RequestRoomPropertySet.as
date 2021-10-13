package com.sulake.habbo.communication.messages.outgoing.inventory.furni
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class RequestRoomPropertySet implements IMessageComposer 
    {

        private var var_2933:int = 0;

        public function RequestRoomPropertySet(param1:int)
        {
            this.var_2933 = param1;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            var _loc1_:Array = new Array();
            _loc1_.push(this.var_2933);
            return (_loc1_);
        }

    }
}