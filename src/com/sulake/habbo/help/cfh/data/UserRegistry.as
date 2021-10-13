package com.sulake.habbo.help.cfh.data
{
    import com.sulake.core.utils.Map;

    public class UserRegistry 
    {

        private static const var_1411:int = 80;

        private var var_3460:Map = new Map();
        private var var_2970:String = "";
        private var var_3461:Array = new Array();

        public function getRegistry():Map
        {
            return (this.var_3460);
        }

        public function registerRoom(param1:String):void
        {
            this.var_2970 = param1;
            if (this.var_2970 != "")
            {
                this.addRoomNameForMissing();
            };
        }

        public function unregisterRoom():void
        {
            this.var_2970 = "";
        }

        public function registerUser(param1:int, param2:String, param3:Boolean=true):void
        {
            var _loc4_:UserRegistryItem;
            if (this.var_3460.getValue(param1) != null)
            {
                this.var_3460.remove(param1);
            };
            if (param3)
            {
                _loc4_ = new UserRegistryItem(param1, param2, this.var_2970);
            }
            else
            {
                _loc4_ = new UserRegistryItem(param1, param2);
            };
            if (((param3) && (this.var_2970 == "")))
            {
                this.var_3461.push(param1);
            };
            this.var_3460.add(param1, _loc4_);
            this.purgeUserIndex();
        }

        private function purgeUserIndex():void
        {
            var _loc1_:int;
            while (this.var_3460.length > var_1411)
            {
                _loc1_ = this.var_3460.getKey(0);
                this.var_3460.remove(_loc1_);
            };
        }

        private function addRoomNameForMissing():void
        {
            var _loc1_:UserRegistryItem;
            while (this.var_3461.length > 0)
            {
                _loc1_ = this.var_3460.getValue(this.var_3461.shift());
                if (_loc1_ != null)
                {
                    _loc1_.roomName = this.var_2970;
                };
            };
        }

    }
}