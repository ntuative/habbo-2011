package com.sulake.habbo.room.object.visualization.room
{

    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.WallRasterizer;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.FloorRasterizer;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.WallAdRasterizer;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.animated.LandscapeRasterizer;
    import com.sulake.habbo.room.object.visualization.room.mask.PlaneMaskManager;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.IPlaneRasterizer;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;

    public class RoomVisualizationData implements IRoomObjectVisualizationData
    {

        private var var_4265: WallRasterizer;
        private var var_4266: FloorRasterizer;
        private var var_4267: WallAdRasterizer;
        private var var_4268: LandscapeRasterizer;
        private var var_4236: PlaneMaskManager;
        private var var_2047: Boolean = false;

        public function RoomVisualizationData()
        {
            this.var_4265 = new WallRasterizer();
            this.var_4266 = new FloorRasterizer();
            this.var_4267 = new WallAdRasterizer();
            this.var_4268 = new LandscapeRasterizer();
            this.var_4236 = new PlaneMaskManager();
        }

        public function get initialized(): Boolean
        {
            return this.var_2047;
        }

        public function get floorRasterizer(): IPlaneRasterizer
        {
            return this.var_4266;
        }

        public function get wallRasterizer(): IPlaneRasterizer
        {
            return this.var_4265;
        }

        public function get wallAdRasterizr(): WallAdRasterizer
        {
            return this.var_4267;
        }

        public function get landscapeRasterizer(): IPlaneRasterizer
        {
            return this.var_4268;
        }

        public function get maskManager(): PlaneMaskManager
        {
            return this.var_4236;
        }

        public function dispose(): void
        {
            if (this.var_4265 != null)
            {
                this.var_4265.dispose();
                this.var_4265 = null;
            }

            if (this.var_4266 != null)
            {
                this.var_4266.dispose();
                this.var_4266 = null;
            }

            if (this.var_4267 != null)
            {
                this.var_4267.dispose();
                this.var_4267 = null;
            }

            if (this.var_4268 != null)
            {
                this.var_4268.dispose();
                this.var_4268 = null;
            }

            if (this.var_4236 != null)
            {
                this.var_4236.dispose();
                this.var_4236 = null;
            }

        }

        public function clearCache(): void
        {
            if (this.var_4265 != null)
            {
                this.var_4265.clearCache();
            }

            if (this.var_4266 != null)
            {
                this.var_4266.clearCache();
            }

            if (this.var_4268 != null)
            {
                this.var_4268.clearCache();
            }

        }

        public function initialize(param1: XML): Boolean
        {
            var _loc7_: XML;
            var _loc8_: XML;
            var _loc9_: XML;
            var _loc10_: XML;
            var _loc11_: XML;
            this.reset();
            if (param1 == null)
            {
                return false;
            }

            var _loc2_: XMLList = param1.wallData;
            if (_loc2_.length() > 0)
            {
                _loc7_ = _loc2_[0];
                this.var_4265.initialize(_loc7_);
            }

            var _loc3_: XMLList = param1.floorData;
            if (_loc3_.length() > 0)
            {
                _loc8_ = _loc3_[0];
                this.var_4266.initialize(_loc8_);
            }

            var _loc4_: XMLList = param1.wallAdData;
            if (_loc4_.length() > 0)
            {
                _loc9_ = _loc4_[0];
                this.var_4267.initialize(_loc9_);
            }

            var _loc5_: XMLList = param1.landscapeData;
            if (_loc5_.length() > 0)
            {
                _loc10_ = _loc5_[0];
                this.var_4268.initialize(_loc10_);
            }

            var _loc6_: XMLList = param1.maskData;
            if (_loc6_.length() > 0)
            {
                _loc11_ = _loc6_[0];
                this.var_4236.initialize(_loc11_);
            }

            return true;
        }

        public function initializeAssetCollection(param1: IGraphicAssetCollection): void
        {
            if (this.var_2047)
            {
                return;
            }

            this.var_4265.initializeAssetCollection(param1);
            this.var_4266.initializeAssetCollection(param1);
            this.var_4267.initializeAssetCollection(param1);
            this.var_4268.initializeAssetCollection(param1);
            this.var_4236.initializeAssetCollection(param1);
            this.var_2047 = true;
        }

        protected function reset(): void
        {
        }

    }
}
