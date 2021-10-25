package com.sulake.habbo.widget.chooser
{

    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.widget.messages.RoomWidgetRequestWidgetMessage;
    import com.sulake.habbo.widget.events.RoomWidgetChooserContentEvent;
    import com.sulake.habbo.widget.events.RoomWidgetRoomObjectUpdateEvent;

    import flash.events.IEventDispatcher;

    public class UserChooserWidget extends ChooserWidgetBase
    {

        private const var_4692: int = 0;
        private const var_4693: int = 1;

        private var _userChooser: ChooserView;

        public function UserChooserWidget(param1: IHabboWindowManager, param2: IAssetLibrary = null, param3: IHabboLocalizationManager = null)
        {
            super(param1, param2, param3);
        }

        override public function get state(): int
        {
            if (this._userChooser != null && this._userChooser.isOpen())
            {
                return this.var_4693;
            }

            return this.var_4692;
        }

        override public function initialize(param1: int = 0): void
        {
            var _loc2_: RoomWidgetRequestWidgetMessage;
            super.initialize(param1);
            if (param1 == this.var_4693)
            {
                _loc2_ = new RoomWidgetRequestWidgetMessage(RoomWidgetRequestWidgetMessage.REQUEST_USER_CHOOSER);
                messageListener.processWidgetMessage(_loc2_);
            }

        }

        override public function dispose(): void
        {
            if (this._userChooser != null)
            {
                this._userChooser.dispose();
                this._userChooser = null;
            }

            super.dispose();
        }

        override public function registerUpdateEvents(param1: IEventDispatcher): void
        {
            if (param1 == null)
            {
                return;
            }

            param1.addEventListener(RoomWidgetChooserContentEvent.var_1266, this.onChooserContent);
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1260, this.onUpdateUserChooser);
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1267, this.onUpdateUserChooser);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1: IEventDispatcher): void
        {
            if (param1 == null)
            {
                return;
            }

            param1.removeEventListener(RoomWidgetChooserContentEvent.var_1266, this.onChooserContent);
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1260, this.onUpdateUserChooser);
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1267, this.onUpdateUserChooser);
        }

        private function onChooserContent(param1: RoomWidgetChooserContentEvent): void
        {
            if (param1 == null || param1.items == null)
            {
                return;
            }

            if (this._userChooser == null)
            {
                this._userChooser = new ChooserView(this, "${widget.chooser.user.title}");
            }

            this._userChooser.populate(param1.items, false);
        }

        private function onUpdateUserChooser(param1: RoomWidgetRoomObjectUpdateEvent): void
        {
            if (this._userChooser == null || !this._userChooser.isOpen())
            {
                return;
            }

            var _loc2_: RoomWidgetRequestWidgetMessage = new RoomWidgetRequestWidgetMessage(RoomWidgetRequestWidgetMessage.REQUEST_USER_CHOOSER);
            messageListener.processWidgetMessage(_loc2_);
        }

    }
}
