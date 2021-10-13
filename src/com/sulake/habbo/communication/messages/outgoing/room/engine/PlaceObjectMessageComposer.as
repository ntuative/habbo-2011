package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;

    public class PlaceObjectMessageComposer implements IMessageComposer 
    {

        private var var_2358:int;
        private var var_3098:int;
        private var var_2675:String;
        private var _x:int = 0;
        private var var_2497:int = 0;
        private var var_3035:int = 0;
        private var _roomId:int;
        private var _roomCategory:int;

        public function PlaceObjectMessageComposer(param1:int, param2:int, param3:String, param4:int, param5:int, param6:int, param7:int=0, param8:int=0)
        {
            this.var_2358 = param1;
            this.var_3098 = param2;
            this.var_2675 = param3;
            this._x = param4;
            this.var_2497 = param5;
            this.var_3035 = param6;
            this._roomId = param7;
            this._roomCategory = param8;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            switch (this.var_3098)
            {
                case RoomObjectCategoryEnum.var_72:
                    return ([((((((this.var_2358 + " ") + this._x) + " ") + this.var_2497) + " ") + this.var_3035)]);
                case RoomObjectCategoryEnum.var_73:
                    return ([((this.var_2358 + " ") + this.var_2675)]);
                default:
                    return ([]);
            };
        }

    }
}