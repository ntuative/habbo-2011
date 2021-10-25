package mx.core
{

    import flash.system.ApplicationDomain;
    import flash.events.Event;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.display.DisplayObjectContainer;

    public class BitmapAsset extends FlexBitmap implements IFlexAsset, IFlexDisplayObject, ILayoutDirectionElement
    {

        private var _height: Number;
        private var _layoutDirection: String = "ltr";

        public function BitmapAsset(param1: BitmapData = null, param2: String = "auto", param3: Boolean = false)
        {
            var _loc4_: ApplicationDomain;
            super(param1, param2, param3);
        }

        override public function get x(): Number
        {
            return super.x;
        }

        override public function set x(param1: Number): void
        {
            if (this.x == param1)
            {
                return;
            }


            super.x = param1;
        }

        override public function get y(): Number
        {
            return super.y;
        }

        override public function set y(param1: Number): void
        {
            if (this.y == param1)
            {
                return;
            }

            super.y = param1;
        }

        override public function get z(): Number
        {
            return super.z;
        }

        override public function set z(param1: Number): void
        {
            if (this.z == param1)
            {
                return;
            }


            super.z = param1;
        }

        override public function get width(): Number
        {
            return super.width;
        }

        override public function set width(param1: Number): void
        {
            if (this.width == param1)
            {
                return;
            }


            super.width = param1;
        }

        override public function get height(): Number
        {
            return super.height;
        }

        override public function set height(param1: Number): void
        {
            if (this.height == param1)
            {
                return;
            }


            super.height = param1;
        }

        override public function get rotationX(): Number
        {
            return super.rotationX;
        }

        override public function set rotationX(param1: Number): void
        {
            if (this.rotationX == param1)
            {
                return;
            }


            super.rotationX = param1;
        }

        override public function get rotationY(): Number
        {
            return super.rotationY;
        }

        override public function set rotationY(param1: Number): void
        {
            if (this.rotationY == param1)
            {
                return;
            }


            super.rotationY = param1;
        }

        override public function get rotationZ(): Number
        {
            return super.rotationZ;
        }

        override public function set rotationZ(param1: Number): void
        {
            if (this.rotationZ == param1)
            {
                return;
            }

            super.rotationZ = param1;
        }

        override public function get rotation(): Number
        {
            return super.rotation;
        }

        override public function set rotation(param1: Number): void
        {
            if (this.rotation == param1)
            {
                return;
            }

            super.rotation = param1;
        }

        override public function get scaleX(): Number
        {
            return super.scaleX;
        }

        override public function set scaleX(param1: Number): void
        {
            if (this.scaleX == param1)
            {
                return;
            }

            super.scaleX = param1;
        }

        override public function get scaleY(): Number
        {
            return super.scaleY;
        }

        override public function set scaleY(param1: Number): void
        {
            if (this.scaleY == param1)
            {
                return;
            }

            super.scaleY = param1;
        }

        override public function get scaleZ(): Number
        {
            return super.scaleZ;
        }

        override public function set scaleZ(param1: Number): void
        {
            if (this.scaleZ == param1)
            {
                return;
            }

            super.scaleZ = param1;
        }

        public function get layoutDirection(): String
        {
            return this._layoutDirection;
        }

        public function set layoutDirection(param1: String): void
        {
            if (param1 == this._layoutDirection)
            {
                return;
            }

            this._layoutDirection = param1;
            this.invalidateLayoutDirection();
        }

        public function get measuredHeight(): Number
        {
            if (bitmapData)
            {
                return bitmapData.height;
            }

            return 0;
        }

        public function get measuredWidth(): Number
        {
            if (bitmapData)
            {
                return bitmapData.width;
            }

            return 0;
        }

        public function invalidateLayoutDirection(): void
        {
            var _loc2_: Boolean;
            var _loc1_: DisplayObjectContainer = parent;
            while (_loc1_)
            {
                if (_loc1_ is ILayoutDirectionElement)
                {
                    return;
                }


                _loc1_ = _loc1_.parent;
            }

        }

        public function move(param1: Number, param2: Number): void
        {
            this.x = param1;
            this.y = param2;
        }

        public function setActualSize(param1: Number, param2: Number): void
        {
            this.width = param1;
            this.height = param2;
        }

        private function addedHandler(param1: Event): void
        {
            this.invalidateLayoutDirection();
        }

        private function initAdvancedLayoutFeatures(): void
        {
            // no-op
        }

        private function validateTransformMatrix(): void
        {
            // no-op
        }

    }
}
