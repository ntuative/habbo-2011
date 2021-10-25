package com.sulake.habbo.room.object.visualization.furniture
{

    public class FurnitureScoreBoardVisualization extends AnimatedFurnitureVisualization
    {

        private static const var_1469: String = "ones_sprite";
        private static const var_1470: String = "tens_sprite";
        private static const var_1471: String = "hundreds_sprite";
        private static const var_1472: String = "thousands_sprite";

        override public function get animationId(): int
        {
            return 0;
        }

        override protected function getFrameNumber(param1: int, param2: int): int
        {
            var _loc3_: String = getSpriteTag(param1, direction, param2);
            var _loc4_: int = super.animationId;
            switch (_loc3_)
            {
                case var_1469:
                    return _loc4_ % 10;
                case var_1470:
                    return (_loc4_ / 10) % 10;
                case var_1471:
                    return (_loc4_ / 100) % 10;
                case var_1472:
                    return (_loc4_ / 1000) % 10;
                default:
                    return super.getFrameNumber(param1, param2);
            }

        }

    }
}
