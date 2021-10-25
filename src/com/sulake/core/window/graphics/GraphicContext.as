package com.sulake.core.window.graphics
{

    import flash.display.Sprite;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;
    import flash.display.Shape;
    import flash.text.TextField;
    import flash.display.Bitmap;
    import flash.text.TextFieldType;
    import flash.display.MorphShape;
    import flash.display.DisplayObject;
    import flash.geom.Point;
    import flash.display.IBitmapDrawable;
    import flash.display.BitmapData;

    import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;

    public class GraphicContext extends Sprite implements IGraphicContext
    {

        public static const var_1750: uint = 0;
        public static const var_1028: uint = 1 << 0;
        public static const var_1155: uint = 1 << 1;
        public static const var_1723: uint = 1 << 2;
        public static const var_1751: uint = 1 << 3;
        public static const var_1752: uint = 1 << 4;
        public static const var_1753: uint = 1 << 6;
        public static const var_1754: uint = 1 << 7;
        public static const var_1755: uint = 1 << 8;
        protected static var var_1045: uint = 0;
        protected static var var_2246: uint = 0;

        protected var var_2247: DisplayObjectContainer;
        protected var var_2248: Boolean;
        protected var var_2249: Boolean;
        protected var _disposed: Boolean = false;
        protected var var_1018: Rectangle;
        protected var _mask: Shape;

        public function GraphicContext(param1: String, param2: uint, param3: Rectangle)
        {
            var _loc4_: TextField;
            super();
            var_1045++;
            if (param3 == null)
            {
                param3 = new Rectangle(0, 0, 0, 0);
            }

            this.name = param1;
            this.mouseEnabled = false;
            this.doubleClickEnabled = false;
            this.x = param3.x;
            this.y = param3.y;
            this.var_1018 = param3.clone();
            this.var_2248 = true;
            this.var_2249 = false;
            switch (param2)
            {
                case GraphicContext.var_1028:
                    this.var_2249 = true;
                    this.setDisplayObject(new Bitmap());
                    this.allocateDrawBuffer(param3.width, param3.height);
                    return;
                case GraphicContext.var_1155:
                    _loc4_ = new TextField();
                    _loc4_.width = param3.width;
                    _loc4_.height = param3.height;
                    _loc4_.type = TextFieldType.INPUT;
                    this.setDisplayObject(_loc4_);
                    return;
                case GraphicContext.var_1751:
                    this.setDisplayObject(new Shape());
                    return;
                case GraphicContext.var_1752:
                    this.setDisplayObject(new MorphShape());
                    return;
                case GraphicContext.var_1723:
                    this.setDisplayObject(new Sprite());
                    return;
                case GraphicContext.var_1755:
                    return;
                case GraphicContext.var_1750:
                    return;
                default:
                    throw new Error("Unsupported graphic context type: " + param2 + "!");
            }

        }

        public static function get numGraphicContexts(): uint
        {
            return var_1045;
        }

        public static function get allocatedByteCount(): uint
        {
            return var_2246;
        }

        public function set parent(param1: DisplayObjectContainer): void
        {
            if (parent != null)
            {
                parent.removeChild(this);
            }

            if (param1 != null)
            {
                param1.addChild(this);
            }

        }

        override public function get filters(): Array
        {
            return this.getDisplayObject().filters;
        }

        override public function set filters(param1: Array): void
        {
            this.getDisplayObject().filters = param1;
        }

        public function get blend(): Number
        {
            return this.alpha;
        }

        public function set blend(param1: Number): void
        {
            this.alpha = param1;
        }

        public function get mouse(): Boolean
        {
            return super.mouseEnabled;
        }

        public function set mouse(param1: Boolean): void
        {
            super.mouseEnabled = param1;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function dispose(): void
        {
            if (!this._disposed)
            {
                if (parent != null)
                {
                    parent.removeChild(this);
                    this.parent = null;
                }

                while (this.numChildContexts > 0)
                {
                    this.removeChildContextAt(0);
                }

                if (this.var_2249)
                {
                    this.releaseDrawBuffer();
                }

                if (this.var_2247 != null)
                {
                    while (this.var_2247.numChildren > 0)
                    {
                        this.var_2247.removeChildAt(0);
                    }

                }

                this.var_2247 = null;
                while (numChildren > 0)
                {
                    removeChildAt(0);
                }

                this._mask = null;
                this._disposed = true;
                var_1045--;
            }

        }

        override public function toString(): String
        {
            return "[object GraphicContext name=\"" + name + "\"]";
        }

        public function getDrawRegion(): Rectangle
        {
            return this.var_1018.clone();
        }

        public function setDrawRegion(param1: Rectangle, param2: Boolean, param3: Rectangle): void
        {
            if (this.var_2249 && param2)
            {
                this.allocateDrawBuffer(param1.width, param1.height);
            }

            x = param1.x;
            y = param1.y;
            this.var_1018.x = param1.x;
            this.var_1018.y = param1.y;
            this.var_1018.width = param1.width;
            this.var_1018.height = param1.height;
            if (param3)
            {
                if (!this._mask)
                {
                    this._mask = new Shape();
                    this._mask.visible = false;
                    this._mask.cacheAsBitmap = true;
                    super.addChild(this._mask);
                }

                this._mask.graphics.clear();
                this._mask.graphics.beginFill(0xFF);
                this._mask.graphics.drawRect(param3.x, param3.y, param3.width, param3.height);
                this._mask.graphics.endFill();
                this.getDisplayObject().mask = this._mask;
            }
            else
            {
                if (this._mask)
                {
                    super.removeChild(this._mask);
                    this._mask.graphics.clear();
                    this._mask = null;
                    this.getDisplayObject().mask = null;
                }

            }

        }

        public function getDisplayObject(): DisplayObject
        {
            return getChildAt(0);
        }

        public function setDisplayObject(param1: DisplayObject): DisplayObject
        {
            var _loc2_: DisplayObject;
            if (numChildren > 0)
            {
                _loc2_ = removeChildAt(0);
            }

            addChildAt(param1, 0);
            param1.cacheAsBitmap = true;
            param1.mask = this._mask;
            return _loc2_;
        }

        public function getAbsoluteMousePosition(param1: Point): void
        {
            param1.x = stage.mouseX;
            param1.y = stage.mouseY;
        }

        public function getRelativeMousePosition(param1: Point): void
        {
            var _loc2_: DisplayObject = this.getDisplayObject();
            param1.x = _loc2_.mouseX;
            param1.y = _loc2_.mouseY;
        }

        public function fetchDrawBuffer(): IBitmapDrawable
        {
            var _loc1_: DisplayObject;
            if (this.var_2249)
            {
                _loc1_ = this.getDisplayObject();
                if (_loc1_ != null)
                {
                    return Bitmap(_loc1_).bitmapData;
                }

            }

            return null;
        }

        protected function allocateDrawBuffer(width: int, height: int): BitmapData
        {
            var displayObject: DisplayObject;
            var bitmap: BitmapData;
            if (this.var_2249)
            {
                displayObject = this.getDisplayObject();
                if (displayObject is Bitmap)
                {
                    bitmap = Bitmap(displayObject).bitmapData;
                    if (bitmap != null)
                    {
                        if (bitmap.width != width || bitmap.height != height)
                        {
                            var_2246 = var_2246 - bitmap.width * bitmap.height * 4;
                            bitmap.dispose();
                            bitmap = null;
                        }

                    }

                    if (bitmap == null && width > 0 && height > 0)
                    {
                        try
                        {
                            bitmap = new TrackedBitmapData(this, width, height, this.var_2248, 0xFFFFFF);
                        }
                        catch (e: Error)
                        {
                            bitmap = new TrackedBitmapData(this, 1, 1, var_2248, 0xFFFFFF);
                        }

                        var_2246 = var_2246 + bitmap.width * bitmap.height * 4;
                    }

                    Bitmap(displayObject).bitmapData = bitmap;
                    return bitmap;
                }

            }

            return null;
        }

        protected function releaseDrawBuffer(): void
        {
            var _loc1_: DisplayObject;
            var _loc2_: BitmapData;
            if (this.var_2249)
            {
                _loc1_ = this.getDisplayObject();
                if (_loc1_ is Bitmap)
                {
                    _loc2_ = Bitmap(_loc1_).bitmapData;
                    if (_loc2_ != null)
                    {
                        var_2246 = var_2246 - _loc2_.width * _loc2_.height * 4;
                        _loc2_.dispose();
                    }

                }

            }

        }

        public function showRedrawRegion(param1: Rectangle): void
        {
            graphics.clear();
            graphics.lineStyle(1, 0xFF00FF00);
            graphics.drawRect(0, 0, width, height);
            if (param1 != null)
            {
                graphics.lineStyle(1, 0xFF0000FF);
                graphics.drawRect(param1.x, param1.y, param1.width, param1.height);
            }

        }

        protected function setupChildContainer(): DisplayObjectContainer
        {
            if (this.var_2247 == null)
            {
                this.var_2247 = new Sprite();
                this.var_2247.name = this.name + " - Child Container";
                this.var_2247.mouseEnabled = false;
                addChild(this.var_2247);
            }

            return this.var_2247;
        }

        protected function removeChildContainer(): void
        {
            if (this.var_2247 != null)
            {
                removeChild(this.var_2247);
                this.var_2247 = null;
            }

        }

        public function get numChildContexts(): int
        {
            return this.var_2247 != null ? this.var_2247.numChildren : 0;
        }

        public function addChildContext(param1: IGraphicContext): IGraphicContext
        {
            return this.setupChildContainer().addChild(param1 as DisplayObject) as IGraphicContext;
        }

        public function addChildContextAt(param1: IGraphicContext, param2: int): IGraphicContext
        {
            return this.setupChildContainer().addChildAt(param1 as DisplayObject, param2) as IGraphicContext;
        }

        public function getChildContextAt(param1: int): IGraphicContext
        {
            return this.setupChildContainer().getChildAt(param1) as IGraphicContext;
        }

        public function getChildContextByName(param1: String): IGraphicContext
        {
            return this.setupChildContainer().getChildByName(param1) as IGraphicContext;
        }

        public function getChildContextIndex(param1: IGraphicContext): int
        {
            return this.setupChildContainer().getChildIndex(DisplayObject(param1));
        }

        public function removeChildContext(param1: IGraphicContext): IGraphicContext
        {
            return this.setupChildContainer().removeChild(DisplayObject(param1)) as IGraphicContext;
        }

        public function removeChildContextAt(param1: int): IGraphicContext
        {
            var _loc2_: IGraphicContext = this.setupChildContainer().getChildAt(param1) as IGraphicContext;
            return _loc2_ == null ? null : this.removeChildContext(_loc2_);
        }

        public function setChildContextIndex(child: IGraphicContext, index: int): void
        {
            var current: int;
            var temp: Array;
            var i: uint;
            var dispObj: DisplayObject = child as DisplayObject;
            if (dispObj != null)
            {
                try
                {
                    current = this.setupChildContainer().getChildIndex(dispObj);
                }
                catch (error: ArgumentError)
                {
                    temp = [];
                    i = 0;
                    while (i < numChildContexts)
                    {
                        temp.push(getChildContextAt(i));
                        i++;
                    }

                    throw new Error("Provided display object is not a child of this!");
                }

                if (index != current)
                {
                    this.setupChildContainer().setChildIndex(dispObj, index);
                }

            }
            else
            {
                throw new Error("Provided child must implement IGraphicContext!");
            }

        }

        public function swapChildContexts(param1: IGraphicContext, param2: IGraphicContext): void
        {
            this.setupChildContainer().swapChildren(param1 as DisplayObject, param2 as DisplayObject);
        }

        public function swapChildContextsAt(param1: int, param2: int): void
        {
            this.setupChildContainer().swapChildrenAt(param1, param2);
        }

    }
}
