package com.sulake.habbo.window.utils
{

    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IButtonWindow;

    public class AlertDialogWithLink extends AlertDialog implements IAlertDialogWithLink
    {

        protected var _linkTitle: String = "";
        protected var _linkUrl: String = "";

        public function AlertDialogWithLink(windowManager: IHabboWindowManager, layout: XML, title: String, summary: String, linkTitle: String, linkUrl: String, flags: uint, callback: Function)
        {
            super(windowManager, layout, title, summary, flags, callback);

            this.linkTitle = linkTitle;
            this.linkUrl = linkUrl;
        }

        override protected function dialogEventProc(event: WindowEvent, view: IWindow): void
        {
            if (event.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                switch (view.name)
                {
                    case "_alert_button_link":
                        HabboWebTools.navigateToURL(this._linkUrl, "_empty");
                        return;
                }

            }

            super.dialogEventProc(event, view);
        }

        public function set linkTitle(value: String): void
        {
            this._linkTitle = value;

            if (_window)
            {
                IButtonWindow(_window.findChildByTag("LINK")).caption = this._linkTitle;
            }

        }

        public function get linkTitle(): String
        {
            return this._linkTitle;
        }

        public function set linkUrl(value: String): void
        {
            this._linkUrl = value;
        }

        public function get linkUrl(): String
        {
            return this._linkUrl;
        }

    }
}
