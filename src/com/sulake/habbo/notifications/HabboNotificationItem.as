package com.sulake.habbo.notifications
{
    public class HabboNotificationItem 
    {

        private var var_1025:HabboNotificationItemStyle;
        private var var_1997:String;
        private var var_3479:HabboNotifications;

        public function HabboNotificationItem(param1:String, param2:HabboNotificationItemStyle, param3:HabboNotifications)
        {
            this.var_1997 = param1;
            this.var_1025 = param2;
            this.var_3479 = param3;
        }

        public function get style():HabboNotificationItemStyle
        {
            return (this.var_1025);
        }

        public function get content():String
        {
            return (this.var_1997);
        }

        public function dispose():void
        {
            this.var_1997 = null;
            if (this.var_1025 != null)
            {
                this.var_1025.dispose();
                this.var_1025 = null;
            };
            this.var_3479 = null;
        }

        public function ExecuteUiLinks():void
        {
            var _loc2_:String;
            var _loc1_:Array = this.var_1025.componentLinks;
            for each (_loc2_ in _loc1_)
            {
                if (this.var_3479 != null)
                {
                    this.var_3479.onExecuteLink(_loc2_);
                };
            };
        }

    }
}