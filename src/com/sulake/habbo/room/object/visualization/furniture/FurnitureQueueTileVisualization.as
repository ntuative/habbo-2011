package com.sulake.habbo.room.object.visualization.furniture
{

    public class FurnitureQueueTileVisualization extends AnimatedFurnitureVisualization
    {

        private static const var_1475: int = 3;
        private static const var_1479: int = 2;
        private static const var_1480: int = 1;
        private static const var_1481: int = 15;

        private var var_4067: Array = [];
        private var var_4134: int;

        override protected function setAnimation(param1: int): void
        {
            if (param1 == var_1479)
            {
                this.var_4067 = [];
                this.var_4067.push(var_1480);
                this.var_4134 = var_1481;
            }
            
            super.setAnimation(param1);
        }

        override protected function updateAnimation(param1: Number): int
        {
            if (this.var_4134 > 0)
            {
                this.var_4134--;
            }
            
            if (this.var_4134 == 0)
            {
                if (this.var_4067.length > 0)
                {
                    super.setAnimation(this.var_4067.shift());
                }
                
            }
            
            return super.updateAnimation(param1);
        }

    }
}
