package com.sulake.habbo.widget.furniture.placeholder
{

    import com.sulake.habbo.widget.RoomWidgetBase;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.widget.events.RoomWidgetShowPlaceholderEvent;

    import flash.events.IEventDispatcher;

    public class PlaceholderWidget extends RoomWidgetBase
    {

        private var _view: PlaceholderView;

        public function PlaceholderWidget(param1: IHabboWindowManager, param2: IAssetLibrary = null, param3: IHabboLocalizationManager = null)
        {
            super(param1, param2, param3);
        }

        override public function dispose(): void
        {
            if (this._view != null)
            {
                this._view.dispose();
                this._view = null;
            }

            super.dispose();
        }

        override public function registerUpdateEvents(param1: IEventDispatcher): void
        {
            if (param1 == null)
            {
                return;
            }

            param1.addEventListener(RoomWidgetShowPlaceholderEvent.var_1264, this.onShowEvent);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1: IEventDispatcher): void
        {
            if (param1 == null)
            {
                return;
            }

            param1.removeEventListener(RoomWidgetShowPlaceholderEvent.var_1264, this.onShowEvent);
        }

        private function onShowEvent(param1: RoomWidgetShowPlaceholderEvent): void
        {
            this.showInterface();
        }

        private function showInterface(): void
        {
            if (this._view == null)
            {
                this._view = new PlaceholderView(assets, windowManager);
            }

            this._view.showWindow();
        }

        private function hideInterface(): void
        {
            if (this._view != null)
            {
                this._view.dispose();
                this._view = null;
            }

        }

    }
}
