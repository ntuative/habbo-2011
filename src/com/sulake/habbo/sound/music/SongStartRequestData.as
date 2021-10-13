package com.sulake.habbo.sound.music
{
    import flash.utils.getTimer;

    public class SongStartRequestData 
    {

        private var var_2941:int;
        private var var_4484:Number;
        private var var_4485:Number;
        private var var_4486:int;
        private var var_4487:Number;
        private var var_4488:Number;

        public function SongStartRequestData(param1:int, param2:Number, param3:Number, param4:Number=2, param5:Number=1)
        {
            this.var_2941 = param1;
            this.var_4484 = param2;
            this.var_4485 = param3;
            this.var_4487 = param4;
            this.var_4488 = param5;
            this.var_4486 = getTimer();
        }

        public function get songId():int
        {
            return (this.var_2941);
        }

        public function get startPos():Number
        {
            if (this.var_4484 < 0)
            {
                return (0);
            };
            return (this.var_4484 + ((getTimer() - this.var_4486) / 1000));
        }

        public function get playLength():Number
        {
            return (this.var_4485);
        }

        public function get fadeInSeconds():Number
        {
            return (this.var_4487);
        }

        public function get fadeOutSeconds():Number
        {
            return (this.var_4488);
        }

    }
}