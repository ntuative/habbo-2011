package com.sulake.room.renderer.utils
{

    import flash.display.BitmapData;
    import flash.geom.Point;

    public class ExtendedBitmapData extends BitmapData
    {

        private static const OFFSET: Point = new Point(0, 0);

        private var _referenceCount: int = 0;
        private var _disposed: Boolean = false;

        public function ExtendedBitmapData(param1: int, param2: int, param3: Boolean = true, param4: uint = 0)
        {
            super(param1, param2, param3, param4);
        }

        public function get referenceCount(): int
        {
            return this._referenceCount;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function addReference(): void
        {
            this._referenceCount++;
        }

        override public function dispose(): void
        {
            if (this._disposed)
            {
                return;
            }

            if (--this._referenceCount <= 0)
            {
                super.dispose();
                this._disposed = true;
            }

        }

        override public function clone(): BitmapData
        {
            var data: ExtendedBitmapData;
            
            try
            {
                data = new ExtendedBitmapData(width, height, true, 0xFFFFFF);
                data.copyPixels(this, rect, OFFSET, null, null, true);
            }
            catch (e: Error)
            {
                data = new ExtendedBitmapData(1, 1, true, 0xFFFFFF);
            }

            return data;
        }

    }
}
