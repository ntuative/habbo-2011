package com.sulake.room.renderer.cache
{

    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.utils.IRoomGeometry;

    public class RoomObjectLocationCacheItem
    {

        private var _roomObjectVariableAccurateZ: String = "";
        private var var_4015: int = -1;
        private var var_5008: int = -1;
        private var var_5009: Vector3d = new Vector3d();
        private var var_5010: Vector3d = null;
        private var _locationChanged: Boolean = false;

        public function RoomObjectLocationCacheItem(param1: String)
        {
            this._roomObjectVariableAccurateZ = param1;
            this.var_5010 = new Vector3d();
        }

        public function get locationChanged(): Boolean
        {
            return this._locationChanged;
        }

        public function dispose(): void
        {
            this.var_5010 = null;
        }

        public function getScreenLocation(param1: IRoomObject, param2: IRoomGeometry): IVector3d
        {
            var _loc5_: IVector3d;
            var _loc6_: Number;
            var _loc7_: Vector3d;
            var _loc8_: IVector3d;

            if (param1 == null || param2 == null)
            {
                return null;
            }

            var _loc3_: Boolean;
            var _loc4_: IVector3d = param1.getLocation();
            
            if (param2.updateId != this.var_4015 || param1.getUpdateID() != this.var_5008)
            {
                this.var_5008 = param1.getUpdateID();
                
                if (param2.updateId != this.var_4015 || _loc4_.x != this.var_5009.x || _loc4_.y != this.var_5009.y || _loc4_.z != this.var_5009.z)
                {
                    this.var_4015 = param2.updateId;
                    this.var_5009.assign(_loc4_);
                    _loc3_ = true;
                }

            }

            this._locationChanged = _loc3_;
            
            if (_loc3_)
            {
                _loc5_ = param2.getScreenPosition(_loc4_);
                if (_loc5_ == null)
                {
                    return null;
                }

                _loc6_ = param1.getModel().getNumber(this._roomObjectVariableAccurateZ);
                if (isNaN(_loc6_) || _loc6_ == 0)
                {
                    _loc7_ = new Vector3d(Math.round(_loc4_.x), Math.round(_loc4_.y), _loc4_.z);
                    if (_loc7_.x != _loc4_.x || _loc7_.y != _loc4_.y)
                    {
                        _loc8_ = param2.getScreenPosition(_loc7_);
                        this.var_5010.assign(_loc5_);
                        if (_loc8_ != null)
                        {
                            this.var_5010.z = _loc8_.z;
                        }

                    }
                    else
                    {
                        this.var_5010.assign(_loc5_);
                    }

                }
                else
                {
                    this.var_5010.assign(_loc5_);
                }

                this.var_5010.x = Math.round(this.var_5010.x);
                this.var_5010.y = Math.round(this.var_5010.y);
            }

            return this.var_5010;
        }

    }
}
