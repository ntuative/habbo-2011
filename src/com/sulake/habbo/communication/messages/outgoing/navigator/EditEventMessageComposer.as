package com.sulake.habbo.communication.messages.outgoing.navigator
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class EditEventMessageComposer implements IMessageComposer, IDisposable 
    {

        private var var_2217:Array = new Array();

        public function EditEventMessageComposer(param1:int, param2:String, param3:String, param4:Array)
        {
            var _loc5_:String;
            super();
            this.var_2217.push(param1);
            this.var_2217.push(param2);
            this.var_2217.push(param3);
            this.var_2217.push(param4.length);
            for each (_loc5_ in param4)
            {
                this.var_2217.push(_loc5_);
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