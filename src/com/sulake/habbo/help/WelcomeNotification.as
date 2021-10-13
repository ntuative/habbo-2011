package com.sulake.habbo.help
{
    public class WelcomeNotification 
    {

        private var var_3517:String;
        private var var_3518:String;
        private var var_3519:String;

        public function WelcomeNotification(param1:String, param2:String, param3:String)
        {
            this.var_3517 = param1;
            this.var_3518 = param2;
            this.var_3519 = param3;
        }

        public function get targetIconId():String
        {
            return (this.var_3517);
        }

        public function get titleLocalizationKey():String
        {
            return (this.var_3518);
        }

        public function get descriptionLocalizationKey():String
        {
            return (this.var_3519);
        }

    }
}