package com.sulake.habbo.room.object.logic
{

    import com.sulake.room.object.logic.ObjectLogicBase;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.room.messages.RoomObjectMoveUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class MovingObjectLogic extends ObjectLogicBase
    {

        public static const var_1178: int = 500;
        private static var var_1179: Vector3d = new Vector3d();

        private var var_3993: Vector3d = new Vector3d();
        private var var_3041: Vector3d = new Vector3d();
        private var var_3994: int = 0;
        private var var_3995: int;
        private var var_3969: int = 500;

        protected function get lastUpdateTime(): int
        {
            return this.var_3994;
        }

        override public function dispose(): void
        {
            super.dispose();
            this.var_3041 = null;
            this.var_3993 = null;
        }

        protected function set moveUpdateInterval(param1: int): void
        {
            if (param1 <= 0)
            {
                param1 = 1;
            }

            this.var_3969 = param1;
        }

        override public function processUpdateMessage(param1: RoomObjectUpdateMessage): void
        {
            var _loc3_: IVector3d;
            if (param1 == null)
            {
                return;
            }

            super.processUpdateMessage(param1);
            var _loc2_: RoomObjectMoveUpdateMessage = param1 as RoomObjectMoveUpdateMessage;
            if (_loc2_ == null)
            {
                return;
            }

            if (object != null)
            {
                if (param1.loc != null)
                {
                    this.var_3041.assign(param1.loc);
                    _loc3_ = _loc2_.targetLoc;
                    this.var_3995 = this.var_3994;
                    this.var_3993.assign(_loc3_);
                    this.var_3993.sub(this.var_3041);
                }

            }

        }

        override public function update(param1: int): void
        {
            var _loc2_: int;
            if (this.var_3993.length > 0)
            {
                _loc2_ = param1 - this.var_3995;
                if (_loc2_ > this.var_3969)
                {
                    _loc2_ = this.var_3969;
                }

                var_1179.assign(this.var_3993);
                var_1179.mul(_loc2_ / Number(this.var_3969));
                var_1179.add(this.var_3041);
                if (object != null)
                {
                    object.setLocation(var_1179);
                }

                if (_loc2_ == this.var_3969)
                {
                    this.var_3993.x = 0;
                    this.var_3993.y = 0;
                    this.var_3993.z = 0;
                }

            }

            this.var_3994 = param1;
        }

    }
}
