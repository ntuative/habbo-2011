package com.sulake.habbo.avatar.cache
{

    import com.sulake.core.utils.Map;
    import com.sulake.habbo.avatar.actions.IActiveActionData;

    public class AvatarImageBodyPartCache
    {

        private var var_2422: Map;
        private var _action: IActiveActionData;
        private var _direction: int;
        private var _disposed: Boolean;

        public function AvatarImageBodyPartCache()
        {
            this.var_2422 = new Map();
        }

        public function setAction(param1: IActiveActionData, param2: int): void
        {
            if (this._action == null)
            {
                this._action = param1;
            }

            var _loc3_: AvatarImageActionCache = this.getActionCache(this._action);
            if (_loc3_ != null)
            {
                _loc3_.setLastAccessTime(param2);
            }

            this._action = param1;
        }

        public function dispose(): void
        {
            if (!this._disposed)
            {
                if (this.var_2422 == null)
                {
                    return;
                }

                Logger.log("[dispose]");
                if (this.var_2422)
                {
                    this.disposeActions(0, int.MAX_VALUE);
                    this.var_2422.dispose();
                    this.var_2422 = null;
                }

                this._disposed = true;
            }

        }

        public function disposeActions(param1: int, param2: int): void
        {
            var _loc3_: int;
            var _loc4_: AvatarImageActionCache;
            var _loc6_: String;
            if (this.var_2422 == null || this._disposed)
            {
                return;
            }

            var _loc5_: Array = this.var_2422.getKeys();
            for each (_loc6_ in _loc5_)
            {
                _loc4_ = (this.var_2422.getValue(_loc6_) as AvatarImageActionCache);
                if (_loc4_ != null)
                {
                    _loc3_ = _loc4_.getLastAccessTime();
                    if (param2 - _loc3_ >= param1)
                    {
                        Logger.log("[Disposing inactive: " + _loc6_ + "]");
                        _loc4_.dispose();
                        this.var_2422.remove(_loc6_);
                    }

                }

            }

        }

        public function getAction(): IActiveActionData
        {
            return this._action;
        }

        public function setDirection(param1: int): void
        {
            this._direction = param1;
        }

        public function getDirection(): int
        {
            return this._direction;
        }

        public function getActionCache(param1: IActiveActionData = null): AvatarImageActionCache
        {
            if (!this._action)
            {
                return null;
            }

            if (param1 == null)
            {
                param1 = this._action;
            }

            return this.var_2422.getValue(param1.id) as AvatarImageActionCache;
        }

        public function updateActionCache(param1: IActiveActionData, param2: AvatarImageActionCache): void
        {
            this.var_2422.add(param1.id, param2);
        }

        private function debugInfo(param1: String): void
        {
        }

    }
}
