package com.sulake.habbo.room.object.visualization.furniture
{

    import flash.geom.Vector3D;

    import com.sulake.room.object.visualization.utils.IGraphicAsset;

    public class FurnitureParticleSystemParticle
    {

        private var _x: Number;
        private var var_2497: Number;
        private var var_2498: Number;
        private var var_4099: Number;
        private var var_4100: Number;
        private var var_4101: Number;
        private var var_4102: Boolean = false;
        private var _direction: Vector3D;
        private var var_3329: int = 0;
        private var var_4103: int;
        private var var_4104: Boolean = false;
        private var var_4105: Boolean = false;
        private var var_4106: Number;
        private var _alphaMultiplier: Number = 1;
        private var _frames: Array;

        public function get fade(): Boolean
        {
            return this.var_4105;
        }

        public function get alphaMultiplier(): Number
        {
            return this._alphaMultiplier;
        }

        public function get direction(): Vector3D
        {
            return this._direction;
        }

        public function get age(): int
        {
            return this.var_3329;
        }

        public function init(param1: Number, param2: Number, param3: Number, param4: Vector3D, param5: Number, param6: Number, param7: int, param8: Boolean = false, param9: Array = null, param10: Boolean = false): void
        {
            this._x = param1;
            this.var_2497 = param2;
            this.var_2498 = param3;
            this._direction = new Vector3D(param4.x, param4.y, param4.z);
            this._direction.scaleBy(param5);
            this.var_4099 = this._x - this._direction.x * param6;
            this.var_4100 = this.var_2497 - this._direction.y * param6;
            this.var_4101 = this.var_2498 - this._direction.z * param6;
            this.var_3329 = 0;
            this.var_4102 = false;
            this.var_4103 = param7;
            this.var_4104 = param8;
            this._frames = param9;
            this.var_4105 = param10;
            this._alphaMultiplier = 1;
            this.var_4106 = 0.5 + Math.random() * 0.5;
        }

        public function update(): void
        {
            this.var_3329++;
            if (this.var_3329 == this.var_4103)
            {
                this.ignite();
            }

            if (this.var_4105)
            {
                if (this.var_3329 / this.var_4103 > this.var_4106)
                {
                    this._alphaMultiplier = (this.var_4103 - this.var_3329) / (this.var_4103 * (1 - this.var_4106));
                }

            }

        }

        public function getAsset(): IGraphicAsset
        {
            if (this._frames && this._frames.length > 0)
            {
                return this._frames[(this.var_3329 % this._frames.length)];
            }

            return null;
        }

        protected function ignite(): void
        {
        }

        public function get isEmitter(): Boolean
        {
            return this.var_4104;
        }

        public function get isAlive(): Boolean
        {
            return this.var_3329 <= this.var_4103;
        }

        public function dispose(): void
        {
            this._direction = null;
        }

        public function get x(): Number
        {
            return this._x;
        }

        public function get y(): Number
        {
            return this.var_2497;
        }

        public function get z(): Number
        {
            return this.var_2498;
        }

        public function set x(param1: Number): void
        {
            this._x = param1;
        }

        public function set y(param1: Number): void
        {
            this.var_2497 = param1;
        }

        public function set z(param1: Number): void
        {
            this.var_2498 = param1;
        }

        public function get lastX(): Number
        {
            return this.var_4099;
        }

        public function set lastX(param1: Number): void
        {
            this.var_4102 = true;
            this.var_4099 = param1;
        }

        public function get lastY(): Number
        {
            return this.var_4100;
        }

        public function set lastY(param1: Number): void
        {
            this.var_4102 = true;
            this.var_4100 = param1;
        }

        public function get lastZ(): Number
        {
            return this.var_4101;
        }

        public function set lastZ(param1: Number): void
        {
            this.var_4102 = true;
            this.var_4101 = param1;
        }

        public function get hasMoved(): Boolean
        {
            return this.var_4102;
        }

        public function toString(): String
        {
            return [this._x, this.var_2497, this.var_2498].toString();
        }

    }
}
