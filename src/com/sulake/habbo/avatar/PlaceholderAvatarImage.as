package com.sulake.habbo.avatar
{

    import com.sulake.core.utils.Map;
    import com.sulake.habbo.avatar.alias.AssetAliasCollection;
    import com.sulake.habbo.avatar.cache.AvatarImageCache;

    import flash.display.BitmapData;

    import com.sulake.habbo.avatar.enum.AvatarAction;

    public class PlaceholderAvatarImage extends AvatarImage
    {

        internal static var var_986: Map = new Map();

        public function PlaceholderAvatarImage(param1: AvatarStructure, param2: AssetAliasCollection, param3: AvatarFigureContainer, param4: String)
        {
            super(param1, param2, param3, param4);
        }

        override public function dispose(): void
        {
            var _loc1_: AvatarImageCache;
            if (!_disposed)
            {
                _structure = null;
                _assets = null;
                var_2422 = null;
                var_977 = null;
                _figure = null;
                _avatarSpriteData = null;
                var_2390 = null;
                if (!var_987 && var_988)
                {
                    var_988.dispose();
                }

                var_988 = null;
                _loc1_ = getCache();
                if (_loc1_)
                {
                    _loc1_.dispose();
                    _loc1_ = null;
                }

                _canvasOffsets = null;
                _disposed = true;
            }

        }

        override protected function getFullImage(param1: String): BitmapData
        {
            return var_986[param1];
        }

        override protected function cacheFullImage(param1: String, param2: BitmapData): void
        {
            var_986[param1] = param2;
        }

        override public function appendAction(param1: String, ..._args): Boolean
        {
            var _loc3_: String;
            if (_args != null && _args.length > 0)
            {
                _loc3_ = _args[0];
            }

            switch (param1)
            {
                case AvatarAction.var_971:
                    switch (_loc3_)
                    {
                        case AvatarAction.var_947:
                        case AvatarAction.var_948:
                        case AvatarAction.var_944:
                        case AvatarAction.var_982:
                        case AvatarAction.var_976:
                        case AvatarAction.var_949:
                            super.appendAction.apply(null, [param1].concat(_args));
                            break;
                    }

                    break;
                case AvatarAction.var_974:
                case AvatarAction.DANCE:
                case AvatarAction.WAVE:
                case AvatarAction.var_983:
                case AvatarAction.var_984:
                case AvatarAction.var_985:
                    super.addActionData.apply(null, [param1].concat(_args));
                    break;
            }

            return true;
        }

        override public function isPlaceholder(): Boolean
        {
            return true;
        }

    }
}
