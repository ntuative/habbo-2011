package com.sulake.habbo.avatar.animation
{
    public class CanvasDataContainer 
    {

        private var _id:String;
        private var var_2237:int;
        private var _height:int;

        public function CanvasDataContainer(param1:XML)
        {
            this._id = String(param1.@id);
            this.var_2237 = parseInt(param1.@width);
            this._height = parseInt(param1.@height);
        }

    }
}