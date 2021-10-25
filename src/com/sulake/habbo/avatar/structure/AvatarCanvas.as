package com.sulake.habbo.avatar.structure
{

    import flash.geom.Point;

    public class AvatarCanvas
    {

        private var _id: String;
        private var _width: int;
        private var _height: int;
        private var _depth: int;
        private var _dy: int;
        private var _dx: int;
        private var _offset: Point;

        public function AvatarCanvas(data: XML)
        {
            this._id = String(data.@id);
            this._width = parseInt(data.@width);
            this._height = parseInt(data.@height);
            this._depth = parseInt(data.@depth);
            this._dx = parseInt(data.@dx);
            this._dy = parseInt(data.@dy);
            this._offset = new Point(this._dx, this._dy);
        }

        public function get width(): int
        {
            return this._width;
        }

        public function get height(): int
        {
            return this._height;
        }

        public function get offset(): Point
        {
            return this._offset;
        }

        public function get id(): String
        {
            return this._id;
        }

    }
}
