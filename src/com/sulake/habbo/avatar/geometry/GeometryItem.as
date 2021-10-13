package com.sulake.habbo.avatar.geometry
{
    public class GeometryItem extends Node3D 
    {

        private var _id:String;
        private var var_2488:Number;
        private var var_2490:Vector3D;
        private var var_2491:Boolean = false;
        private var var_2492:Boolean = false;

        public function GeometryItem(param1:XML, param2:Boolean=false)
        {
            super(parseFloat(param1.@x), parseFloat(param1.@y), parseFloat(param1.@z));
            this._id = String(param1.@id);
            this.var_2488 = parseFloat(param1.@radius);
            this.var_2490 = new Vector3D(parseFloat(param1.@nx), parseFloat(param1.@ny), parseFloat(param1.@nz));
            this.var_2491 = (parseInt(param1.@double) as Boolean);
            this.var_2492 = param2;
        }

        public function getDistance(param1:Vector3D):Number
        {
            var _loc2_:Number = Math.abs(((param1.z - this.transformedLocation.z) - this.var_2488));
            var _loc3_:Number = Math.abs(((param1.z - this.transformedLocation.z) + this.var_2488));
            return (Math.min(_loc2_, _loc3_));
        }

        public function get id():String
        {
            return (this._id);
        }

        public function get normal():Vector3D
        {
            return (this.var_2490);
        }

        public function get isDoubleSided():Boolean
        {
            return (this.var_2491);
        }

        public function toString():String
        {
            return ((((this._id + ": ") + this.location) + " - ") + this.transformedLocation);
        }

        public function get isDynamic():Boolean
        {
            return (this.var_2492);
        }

    }
}