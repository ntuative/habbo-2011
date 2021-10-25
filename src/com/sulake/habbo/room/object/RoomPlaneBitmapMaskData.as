﻿package com.sulake.habbo.room.object
{

    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;

    public class RoomPlaneBitmapMaskData
    {

        public static const WINDOW: String = "window";
        public static const HOLE: String = "hole";

        private var _loc: Vector3d = null;
        private var _type: String = null;
        private var _category: String = null;

        public function RoomPlaneBitmapMaskData(type: String, loc: IVector3d, category: String)
        {
            this.type = type;
            this.loc = loc;
            this.category = category;
        }

        public function get loc(): IVector3d
        {
            return this._loc;
        }

        public function set loc(value: IVector3d): void
        {
            if (this._loc == null)
            {
                this._loc = new Vector3d();
            }

            this._loc.assign(value);
        }

        public function get type(): String
        {
            return this._type;
        }

        public function set type(value: String): void
        {
            this._type = value;
        }

        public function get category(): String
        {
            return this._category;
        }

        public function set category(value: String): void
        {
            this._category = value;
        }

        public function dispose(): void
        {
            this._loc = null;
        }

    }
}
