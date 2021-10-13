package com.sulake.habbo.room.object.visualization.furniture
{
    public class FurnitureBottleVisualization extends AnimatedFurnitureVisualization 
    {

        private static const var_1477:int = 20;
        private static const var_1476:int = 9;
        private static const var_1475:int = -1;

        private var var_4067:Array = new Array();
        private var var_2132:Boolean = false;

        override protected function setAnimation(param1:int):void
        {
            if (param1 == -1)
            {
                if (!this.var_2132)
                {
                    this.var_2132 = true;
                    this.var_4067 = new Array();
                    this.var_4067.push(var_1475);
                    return;
                };
            };
            if (((param1 >= 0) && (param1 <= 7)))
            {
                if (this.var_2132)
                {
                    this.var_2132 = false;
                    this.var_4067 = new Array();
                    this.var_4067.push(var_1477);
                    this.var_4067.push((var_1476 + param1));
                    this.var_4067.push(param1);
                    return;
                };
                super.setAnimation(param1);
            };
        }

        override protected function updateAnimation(param1:Number):int
        {
            if (super.getLastFramePlayed(0))
            {
                if (this.var_4067.length > 0)
                {
                    super.setAnimation(this.var_4067.shift());
                };
            };
            return (super.updateAnimation(param1));
        }

    }
}