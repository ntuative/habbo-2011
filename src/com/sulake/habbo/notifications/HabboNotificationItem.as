package com.sulake.habbo.notifications
{

    public class HabboNotificationItem
    {

        private var _style: HabboNotificationItemStyle;
        private var _content: String;
        private var _notifications: HabboNotifications;

        public function HabboNotificationItem(conetnt: String, style: HabboNotificationItemStyle, notifications: HabboNotifications)
        {
            this._content = conetnt;
            this._style = style;
            this._notifications = notifications;
        }

        public function get style(): HabboNotificationItemStyle
        {
            return this._style;
        }

        public function get content(): String
        {
            return this._content;
        }

        public function dispose(): void
        {
            this._content = null;
            if (this._style != null)
            {
                this._style.dispose();
                this._style = null;
            }

            this._notifications = null;
        }

        public function ExecuteUiLinks(): void
        {
            var link: String;
            var links: Array = this._style.componentLinks;

            for each (link in links)
            {
                if (this._notifications != null)
                {
                    this._notifications.onExecuteLink(link);
                }

            }

        }

    }
}
