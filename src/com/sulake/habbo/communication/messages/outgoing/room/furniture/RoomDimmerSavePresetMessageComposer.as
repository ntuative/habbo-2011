package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class RoomDimmerSavePresetMessageComposer implements IMessageComposer 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var var_3101:int;
        private var var_3102:int;
        private var var_3103:String;
        private var var_3104:int;
        private var var_3105:Boolean;

        public function RoomDimmerSavePresetMessageComposer(param1:int, param2:int, param3:String, param4:int, param5:Boolean, param6:int=0, param7:int=0)
        {
            this._roomId = param6;
            this._roomCategory = param7;
            this.var_3101 = param1;
            this.var_3102 = param2;
            this.var_3103 = param3;
            this.var_3104 = param4;
            this.var_3105 = param5;
        }

        public function getMessageArray():Array
        {
            return ([this.var_3101, this.var_3102, this.var_3103, this.var_3104, int(this.var_3105)]);
        }

        public function dispose():void
        {
        }

    }
}