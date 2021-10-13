package com.sulake.habbo.room.object.visualization.furniture
{
    public class FurnitureValRandomizerVisualization extends AnimatedFurnitureVisualization 
    {

        private static const var_1477:int = 20;
        private static const var_1476:int = 10;
        private static const var_1474:int = 31;
        private static const var_1475:int = 32;
        private static const var_1473:int = 30;

        private var var_4067:Array = new Array();
        private var var_2132:Boolean = false;

        public function FurnitureValRandomizerVisualization()
        {
            super.setAnimation(var_1473);
        }

        override protected function setAnimation(param1:int):void
        {
            if (param1 == 0)
            {
                if (!this.var_2132)
                {
                    this.var_2132 = true;
                    this.var_4067 = new Array();
                    this.var_4067.push(var_1474);
                    this.var_4067.push(var_1475);
                    return;
                };
            };
            if (((param1 > 0) && (param1 <= var_1476)))
            {
                if (this.var_2132)
                {
                    this.var_2132 = false;
                    this.var_4067 = new Array();
                    if (direction == 2)
                    {
                        this.var_4067.push(((var_1477 + 5) - param1));
                        this.var_4067.push(((var_1476 + 5) - param1));
                    }
                    else
                    {
                        this.var_4067.push((var_1477 + param1));
                        this.var_4067.push((var_1476 + param1));
                    };
                    this.var_4067.push(var_1473);
                    return;
                };
                super.setAnimation(var_1473);
            };
        }

        override protected function updateAnimation(param1:Number):int
        {
            if (super.getLastFramePlayed(11))
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