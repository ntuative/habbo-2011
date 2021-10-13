package com.sulake.room.object
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.object.visualization.IRoomObjectVisualization;
    import com.sulake.room.object.logic.IRoomObjectEventHandler;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.object.logic.IRoomObjectMouseHandler;
    import com.sulake.room.utils.*;

    public class RoomObject implements IRoomObjectController 
    {

        private static var var_1454:int = 0;

        private var _id:int;
        private var _type:String = "";
        private var var_3041:Vector3d;
        private var var_3035:Vector3d;
        private var var_4996:Vector3d;
        private var var_4997:Vector3d;
        private var var_4995:Array;
        private var var_2446:RoomObjectModel;
        private var _visualization:IRoomObjectVisualization;
        private var var_4998:IRoomObjectEventHandler;
        private var _updateID:int;
        private var _instanceId:int = 0;

        public function RoomObject(param1:int, param2:int, param3:String)
        {
            this._id = param1;
            this.var_3041 = new Vector3d();
            this.var_3035 = new Vector3d();
            this.var_4996 = new Vector3d();
            this.var_4997 = new Vector3d();
            this.var_4995 = new Array(param2);
            var _loc4_:Number = (param2 - 1);
            while (_loc4_ >= 0)
            {
                this.var_4995[_loc4_] = 0;
                _loc4_--;
            };
            this._type = param3;
            this.var_2446 = new RoomObjectModel();
            this._visualization = null;
            this.var_4998 = null;
            this._updateID = 0;
            this._instanceId = var_1454++;
        }

        public function dispose():void
        {
            this.var_3041 = null;
            this.var_3035 = null;
            if (this.var_2446 != null)
            {
                this.var_2446.dispose();
                this.var_2446 = null;
            };
            this.var_4995 = null;
            this.setVisualization(null);
            this.setEventHandler(null);
        }

        public function getId():int
        {
            return (this._id);
        }

        public function getType():String
        {
            return (this._type);
        }

        public function getInstanceId():int
        {
            return (this._instanceId);
        }

        public function getLocation():IVector3d
        {
            this.var_4996.assign(this.var_3041);
            return (this.var_4996);
        }

        public function getDirection():IVector3d
        {
            this.var_4997.assign(this.var_3035);
            return (this.var_4997);
        }

        public function getModel():IRoomObjectModel
        {
            return (this.var_2446);
        }

        public function getModelController():IRoomObjectModelController
        {
            return (this.var_2446);
        }

        public function getState(param1:int):int
        {
            if (((param1 >= 0) && (param1 < this.var_4995.length)))
            {
                return (this.var_4995[param1]);
            };
            return (-1);
        }

        public function getVisualization():IRoomObjectVisualization
        {
            return (this._visualization);
        }

        public function setLocation(param1:IVector3d):void
        {
            if (param1 == null)
            {
                return;
            };
            if ((((!(this.var_3041.x == param1.x)) || (!(this.var_3041.y == param1.y))) || (!(this.var_3041.z == param1.z))))
            {
                this.var_3041.x = param1.x;
                this.var_3041.y = param1.y;
                this.var_3041.z = param1.z;
                this._updateID++;
            };
        }

        public function setDirection(param1:IVector3d):void
        {
            if (param1 == null)
            {
                return;
            };
            if ((((!(this.var_3035.x == param1.x)) || (!(this.var_3035.y == param1.y))) || (!(this.var_3035.z == param1.z))))
            {
                this.var_3035.x = (((param1.x % 360) + 360) % 360);
                this.var_3035.y = (((param1.y % 360) + 360) % 360);
                this.var_3035.z = (((param1.z % 360) + 360) % 360);
                this._updateID++;
            };
        }

        public function setState(param1:int, param2:int):Boolean
        {
            if (((param2 >= 0) && (param2 < this.var_4995.length)))
            {
                if (this.var_4995[param2] != param1)
                {
                    this.var_4995[param2] = param1;
                    this._updateID++;
                };
                return (true);
            };
            return (false);
        }

        public function setDirty():void
        {
            this._updateID++;
        }

        public function setVisualization(param1:IRoomObjectVisualization):void
        {
            if (param1 != this._visualization)
            {
                if (this._visualization != null)
                {
                    this._visualization.dispose();
                };
                this._visualization = param1;
                if (this._visualization != null)
                {
                    this._visualization.object = this;
                };
            };
        }

        public function setEventHandler(param1:IRoomObjectEventHandler):void
        {
            if (param1 == this.var_4998)
            {
                return;
            };
            var _loc2_:IRoomObjectEventHandler = this.var_4998;
            if (_loc2_ != null)
            {
                this.var_4998 = null;
                _loc2_.object = null;
            };
            this.var_4998 = param1;
            if (this.var_4998 != null)
            {
                this.var_4998.object = this;
            };
        }

        public function getEventHandler():IRoomObjectEventHandler
        {
            return (this.var_4998);
        }

        public function getUpdateID():int
        {
            return (this._updateID);
        }

        public function getMouseHandler():IRoomObjectMouseHandler
        {
            return (this.getEventHandler());
        }

    }
}