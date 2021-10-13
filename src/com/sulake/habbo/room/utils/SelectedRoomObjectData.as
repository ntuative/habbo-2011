package com.sulake.habbo.room.utils
{
    import com.sulake.habbo.room.ISelectedRoomObjectData;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;

    public class SelectedRoomObjectData implements ISelectedRoomObjectData 
    {

        private var _id:int = 0;
        private var _category:int = 0;
        private var var_4306:String = "";
        private var var_3041:Vector3d = null;
        private var var_3035:Vector3d = null;
        private var var_2703:int = 0;
        private var var_4307:String = null;

        public function SelectedRoomObjectData(param1:int, param2:int, param3:String, param4:IVector3d, param5:IVector3d, param6:int=0, param7:String=null)
        {
            this._id = param1;
            this._category = param2;
            this.var_4306 = param3;
            this.var_3041 = new Vector3d();
            this.var_3041.assign(param4);
            this.var_3035 = new Vector3d();
            this.var_3035.assign(param5);
            this.var_2703 = param6;
            this.var_4307 = param7;
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get category():int
        {
            return (this._category);
        }

        public function get operation():String
        {
            return (this.var_4306);
        }

        public function get loc():Vector3d
        {
            return (this.var_3041);
        }

        public function get dir():Vector3d
        {
            return (this.var_3035);
        }

        public function get typeId():int
        {
            return (this.var_2703);
        }

        public function get instanceData():String
        {
            return (this.var_4307);
        }

        public function dispose():void
        {
            this.var_3041 = null;
            this.var_3035 = null;
        }

    }
}