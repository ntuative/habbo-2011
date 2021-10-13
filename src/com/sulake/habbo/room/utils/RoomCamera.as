package com.sulake.habbo.room.utils
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;

    public class RoomCamera 
    {

        private static const var_4284:int = 3;

        private var var_4285:int = -1;
        private var var_4286:int = -2;
        private var var_3520:Vector3d = null;
        private var var_4287:Vector3d = null;
        private var var_4288:Vector3d = new Vector3d();
        private var var_4289:Boolean = false;
        private var var_4290:Boolean = false;
        private var var_4291:Boolean = false;
        private var var_4292:Boolean = false;
        private var var_4293:int = 0;
        private var var_4294:int = 0;
        private var _scale:int = 0;
        private var var_4295:int = 0;
        private var var_4296:int = 0;
        private var var_4015:int = -1;
        private var var_4297:int = 0;
        private var var_4298:Boolean = false;

        public function get location():IVector3d
        {
            return (this.var_4287);
        }

        public function get targetId():int
        {
            return (this.var_4285);
        }

        public function get targetCategory():int
        {
            return (this.var_4286);
        }

        public function get targetObjectLoc():IVector3d
        {
            return (this.var_4288);
        }

        public function get limitedLocationX():Boolean
        {
            return (this.var_4289);
        }

        public function get limitedLocationY():Boolean
        {
            return (this.var_4290);
        }

        public function get centeredLocX():Boolean
        {
            return (this.var_4291);
        }

        public function get centeredLocY():Boolean
        {
            return (this.var_4292);
        }

        public function get screenWd():int
        {
            return (this.var_4293);
        }

        public function get screenHt():int
        {
            return (this.var_4294);
        }

        public function get scale():int
        {
            return (this._scale);
        }

        public function get roomWd():int
        {
            return (this.var_4295);
        }

        public function get roomHt():int
        {
            return (this.var_4296);
        }

        public function get geometryUpdateId():int
        {
            return (this.var_4015);
        }

        public function get isMoving():Boolean
        {
            if (((!(this.var_3520 == null)) && (!(this.var_4287 == null))))
            {
                return (true);
            };
            return (false);
        }

        public function set targetId(param1:int):void
        {
            this.var_4285 = param1;
        }

        public function set targetObjectLoc(param1:IVector3d):void
        {
            this.var_4288.assign(param1);
        }

        public function set targetCategory(param1:int):void
        {
            this.var_4286 = param1;
        }

        public function set limitedLocationX(param1:Boolean):void
        {
            this.var_4289 = param1;
        }

        public function set limitedLocationY(param1:Boolean):void
        {
            this.var_4290 = param1;
        }

        public function set centeredLocX(param1:Boolean):void
        {
            this.var_4291 = param1;
        }

        public function set centeredLocY(param1:Boolean):void
        {
            this.var_4292 = param1;
        }

        public function set screenWd(param1:int):void
        {
            this.var_4293 = param1;
        }

        public function set screenHt(param1:int):void
        {
            this.var_4294 = param1;
        }

        public function set scale(param1:int):void
        {
            if (this._scale != param1)
            {
                this._scale = param1;
                this.var_4298 = true;
            };
        }

        public function set roomWd(param1:int):void
        {
            this.var_4295 = param1;
        }

        public function set roomHt(param1:int):void
        {
            this.var_4296 = param1;
        }

        public function set geometryUpdateId(param1:int):void
        {
            this.var_4015 = param1;
        }

        public function set target(param1:IVector3d):void
        {
            if (this.var_3520 == null)
            {
                this.var_3520 = new Vector3d();
            };
            if ((((!(this.var_3520.x == param1.x)) || (!(this.var_3520.y == param1.y))) || (!(this.var_3520.z == param1.z))))
            {
                this.var_3520.assign(param1);
                this.var_4297 = 0;
            };
        }

        public function dispose():void
        {
            this.var_3520 = null;
            this.var_4287 = null;
        }

        public function initializeLocation(param1:IVector3d):void
        {
            if (this.var_4287 != null)
            {
                return;
            };
            this.var_4287 = new Vector3d();
            this.var_4287.assign(param1);
        }

        public function resetLocation(param1:IVector3d):void
        {
            if (this.var_4287 == null)
            {
                this.var_4287 = new Vector3d();
            };
            this.var_4287.assign(param1);
        }

        public function update(param1:uint, param2:Number, param3:Number):void
        {
            var _loc4_:Vector3d;
            if (((!(this.var_3520 == null)) && (!(this.var_4287 == null))))
            {
                this.var_4297++;
                if (this.var_4298)
                {
                    this.var_4298 = false;
                    this.var_4287 = this.var_3520;
                    this.var_3520 = null;
                    return;
                };
                _loc4_ = Vector3d.dif(this.var_3520, this.var_4287);
                if (_loc4_.length <= param2)
                {
                    this.var_4287 = this.var_3520;
                    this.var_3520 = null;
                }
                else
                {
                    _loc4_.div(_loc4_.length);
                    if (_loc4_.length < (param2 * (var_4284 + 1)))
                    {
                        _loc4_.mul(param2);
                    }
                    else
                    {
                        if (this.var_4297 <= var_4284)
                        {
                            _loc4_.mul(param2);
                        }
                        else
                        {
                            _loc4_.mul(param3);
                        };
                    };
                    this.var_4287 = Vector3d.sum(this.var_4287, _loc4_);
                };
            };
        }

    }
}