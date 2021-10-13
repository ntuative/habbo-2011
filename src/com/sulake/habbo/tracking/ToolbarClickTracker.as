package com.sulake.habbo.tracking
{
    import com.sulake.habbo.configuration.IHabboConfigurationManager;

    public class ToolbarClickTracker 
    {

        private var var_4613:IHabboTracking;
        private var var_3268:Boolean = false;
        private var var_4614:int = 0;
        private var var_4615:int = 0;

        public function ToolbarClickTracker(param1:IHabboTracking)
        {
            this.var_4613 = param1;
        }

        public function dispose():void
        {
            this.var_4613 = null;
        }

        public function configure(param1:IHabboConfigurationManager):void
        {
            this.var_3268 = Boolean(parseInt(param1.getKey("toolbar.tracking.enabled", "1")));
            this.var_4614 = parseInt(param1.getKey("toolbar.tracking.max.events", "100"));
        }

        public function track(param1:String):void
        {
            if (!this.var_3268)
            {
                return;
            };
            this.var_4615++;
            if (this.var_4615 <= this.var_4614)
            {
                this.var_4613.track("toolbar", param1);
            };
        }

    }
}