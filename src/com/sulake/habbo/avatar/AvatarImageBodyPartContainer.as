package com.sulake.habbo.avatar
{

    import flash.display.BitmapData;
    import flash.geom.Point;

    public class AvatarImageBodyPartContainer
    {

        private var _image: BitmapData;
        private var var_2445: Point;
        private var _offset: Point = new Point(0, 0);

        public function AvatarImageBodyPartContainer(param1: BitmapData, param2: Point)
        {
            this._image = param1;
            this.var_2445 = param2;
            this.cleanPoints();
        }

        public function dispose(): void
        {
            if (this._image)
            {
                this._image.dispose();
            }

            this._image = null;
            this.var_2445 = null;
            this._offset = null;
        }

        public function set image(param1: BitmapData): void
        {
            this._image = param1;
        }

        public function get image(): BitmapData
        {
            return this._image;
        }

        public function setRegPoint(param1: Point): void
        {
            this.var_2445 = param1;
            this.cleanPoints();
        }

        public function get regPoint(): Point
        {
            return this.var_2445.add(this._offset);
        }

        public function set offset(param1: Point): void
        {
            this._offset = param1;
            this.cleanPoints();
        }

        private function cleanPoints(): void
        {
            this.var_2445.x = int(this.var_2445.x);
            this.var_2445.y = int(this.var_2445.y);
            this._offset.x = int(this._offset.x);
            this._offset.y = int(this._offset.y);
        }

    }
}
