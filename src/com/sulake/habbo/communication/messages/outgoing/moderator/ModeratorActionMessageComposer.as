package com.sulake.habbo.communication.messages.outgoing.moderator
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

    public class ModeratorActionMessageComposer implements IMessageComposer, IDisposable 
    {

        public static const var_1863:int = 0;
        public static const var_1864:int = 1;
        public static const var_1865:int = 0;
        public static const var_1866:int = 1;
        public static const var_1867:int = 2;
        public static const var_1868:int = 3;
        public static const var_1869:int = 4;

        private var var_2217:Array = new Array();

        public function ModeratorActionMessageComposer(param1:int, param2:int, param3:String, param4:String, param5:String, param6:int=0)
        {
            this.var_2217.push(param1);
            this.var_2217.push(param2);
            this.var_2217.push(param3);
            this.var_2217.push(param4);
            this.var_2217.push(param5);
            this.var_2217.push(param6);
            this.var_2217.push(false);
            this.var_2217.push(false);
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