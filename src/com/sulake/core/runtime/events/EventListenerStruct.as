package com.sulake.core.runtime.events
{
    import flash.utils.Dictionary;

    public class EventListenerStruct 
    {

        private var var_2170:Dictionary;
        public var var_92:Boolean;
        public var priority:int;
        public var var_444:Boolean;

        public function EventListenerStruct(param1:Function, param2:Boolean=false, param3:int=0, param4:Boolean=false)
        {
            this.var_2170 = new Dictionary(param4);
            this.callback = param1;
            this.var_92 = param2;
            this.priority = param3;
            this.var_444 = param4;
        }

        public function set callback(param1:Function):void
        {
            var _loc2_:Object;
            for (_loc2_ in this.var_2170)
            {
                delete this.var_2170[_loc2_];
            };
            this.var_2170[param1] = null;
        }

        public function get callback():Function
        {
            var _loc1_:Object;
            for (_loc1_ in this.var_2170)
            {
                return (_loc1_ as Function);
            };
            return (null);
        }

    }
}