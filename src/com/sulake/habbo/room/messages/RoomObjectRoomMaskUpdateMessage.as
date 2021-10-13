package com.sulake.habbo.room.messages
{
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;

    public class RoomObjectRoomMaskUpdateMessage extends RoomObjectUpdateMessage 
    {

        public static const var_471:String = "RORMUM_ADD_MASK";
        public static const var_494:String = "RORMUM_ADD_MASK";
        public static const var_470:String = "door";
        public static const var_1196:String = "window";
        public static const var_472:String = "hole";

        private var _type:String = "";
        private var var_3951:String = "";
        private var var_3952:String = "";
        private var var_3953:Vector3d = null;
        private var var_3954:String = "window";

        public function RoomObjectRoomMaskUpdateMessage(param1:String, param2:String, param3:String=null, param4:IVector3d=null, param5:String="window")
        {
            super(null, null);
            this._type = param1;
            this.var_3951 = param2;
            this.var_3952 = param3;
            if (param4 != null)
            {
                this.var_3953 = new Vector3d(param4.x, param4.y, param4.z);
            };
            this.var_3954 = param5;
        }

        public function get type():String
        {
            return (this._type);
        }

        public function get maskId():String
        {
            return (this.var_3951);
        }

        public function get maskType():String
        {
            return (this.var_3952);
        }

        public function get maskLocation():IVector3d
        {
            return (this.var_3953);
        }

        public function get maskCategory():String
        {
            return (this.var_3954);
        }

    }
}