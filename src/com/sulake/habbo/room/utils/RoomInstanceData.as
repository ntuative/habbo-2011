package com.sulake.habbo.room.utils
{
    import com.sulake.core.utils.Map;

    public class RoomInstanceData 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var var_4299:TileHeightMap = null;
        private var var_4300:LegacyWallGeometry = null;
        private var var_4301:RoomCamera = null;
        private var var_4302:SelectedRoomObjectData = null;
        private var var_4303:SelectedRoomObjectData = null;
        private var _worldType:String = null;
        private var var_4304:Map = new Map();
        private var var_4305:Map = new Map();

        public function RoomInstanceData(param1:int, param2:int)
        {
            this._roomId = param1;
            this._roomCategory = param2;
            this.var_4300 = new LegacyWallGeometry();
            this.var_4301 = new RoomCamera();
        }

        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

        public function get tileHeightMap():TileHeightMap
        {
            return (this.var_4299);
        }

        public function set tileHeightMap(param1:TileHeightMap):void
        {
            if (this.var_4299 != null)
            {
                this.var_4299.dispose();
            };
            this.var_4299 = param1;
        }

        public function get legacyGeometry():LegacyWallGeometry
        {
            return (this.var_4300);
        }

        public function get roomCamera():RoomCamera
        {
            return (this.var_4301);
        }

        public function get worldType():String
        {
            return (this._worldType);
        }

        public function set worldType(param1:String):void
        {
            this._worldType = param1;
        }

        public function get selectedObject():SelectedRoomObjectData
        {
            return (this.var_4302);
        }

        public function set selectedObject(param1:SelectedRoomObjectData):void
        {
            if (this.var_4302 != null)
            {
                this.var_4302.dispose();
            };
            this.var_4302 = param1;
        }

        public function get placedObject():SelectedRoomObjectData
        {
            return (this.var_4303);
        }

        public function set placedObject(param1:SelectedRoomObjectData):void
        {
            if (this.var_4303 != null)
            {
                this.var_4303.dispose();
            };
            this.var_4303 = param1;
        }

        public function dispose():void
        {
            if (this.var_4299 != null)
            {
                this.var_4299.dispose();
                this.var_4299 = null;
            };
            if (this.var_4300 != null)
            {
                this.var_4300.dispose();
                this.var_4300 = null;
            };
            if (this.var_4301 != null)
            {
                this.var_4301.dispose();
                this.var_4301 = null;
            };
            if (this.var_4302 != null)
            {
                this.var_4302.dispose();
                this.var_4302 = null;
            };
            if (this.var_4303 != null)
            {
                this.var_4303.dispose();
                this.var_4303 = null;
            };
            if (this.var_4304 != null)
            {
                this.var_4304.dispose();
                this.var_4304 = null;
            };
            if (this.var_4305 != null)
            {
                this.var_4305.dispose();
                this.var_4305 = null;
            };
        }

        public function addFurnitureData(param1:FurnitureData):void
        {
            if (param1 != null)
            {
                this.var_4304.remove(param1.id);
                this.var_4304.add(param1.id, param1);
            };
        }

        public function getFurnitureData():FurnitureData
        {
            if (this.var_4304.length > 0)
            {
                return (this.getFurnitureDataWithId(this.var_4304.getKey(0)));
            };
            return (null);
        }

        public function getFurnitureDataWithId(param1:int):FurnitureData
        {
            return (this.var_4304.remove(param1));
        }

        public function addWallItemData(param1:FurnitureData):void
        {
            if (param1 != null)
            {
                this.var_4305.remove(param1.id);
                this.var_4305.add(param1.id, param1);
            };
        }

        public function getWallItemData():FurnitureData
        {
            if (this.var_4305.length > 0)
            {
                return (this.getWallItemDataWithId(this.var_4305.getKey(0)));
            };
            return (null);
        }

        public function getWallItemDataWithId(param1:int):FurnitureData
        {
            return (this.var_4305.remove(param1));
        }

    }
}