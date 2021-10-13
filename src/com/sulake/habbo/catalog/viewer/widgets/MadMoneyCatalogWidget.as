package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;

    public class MadMoneyCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private var var_2742:IButtonWindow;

        public function MadMoneyCatalogWidget(param1:IWindowContainer)
        {
            super(param1);
        }

        override public function dispose():void
        {
            super.dispose();
            if (this.var_2742 != null)
            {
                this.var_2742.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.eventProc);
                this.var_2742 = null;
            };
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            this.var_2742 = (_window.findChildByName("ctlg_madmoney_button") as IButtonWindow);
            if (this.var_2742 != null)
            {
            };
            return (true);
        }

        private function eventProc(event:WindowMouseEvent):void
        {
            page.viewer.catalog.windowManager.alert("TODO", "Fix in MadMoneyCatalogWidget.as", 0, function (param1:IAlertDialog, param2:WindowEvent):void
            {
                param1.dispose();
            });
        }

    }
}