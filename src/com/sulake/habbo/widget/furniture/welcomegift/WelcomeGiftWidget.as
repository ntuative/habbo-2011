package com.sulake.habbo.widget.furniture.welcomegift
{

    import com.sulake.habbo.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.BitmapDataAsset;

    import flash.display.BitmapData;

    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.widget.messages.RoomWidgetFurniActionMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetChangeEmailMessage;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.habbo.widget.events.RoomWidgetWelcomeGiftUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetChangeEmailResultEvent;

    import flash.events.IEventDispatcher;

    public class WelcomeGiftWidget extends RoomWidgetBase
    {

        private const var_4777: String = "welcome_gift_email_unverified";
        private const var_4778: String = "welcome_gift_email_verified";
        private const var_4779: String = "welcome_gift_email_change";
        private const var_4780: int = 4;

        private var var_978: Boolean = false;
        private var _view: IWindowContainer;
        private var var_3316: String;
        private var var_4781: String;
        private var var_3317: Boolean;
        private var var_4734: Boolean;
        private var _furniId: int;
        private var var_4782: String;

        public function WelcomeGiftWidget(param1: IHabboWindowManager, param2: IAssetLibrary, param3: IHabboLocalizationManager)
        {
            super(param1, param2, param3);
        }

        override public function get disposed(): Boolean
        {
            return this.var_978;
        }

        override public function dispose(): void
        {
            if (this.var_978)
            {
                return;
            }

            if (this._view)
            {
                this._view.dispose();
            }

            super.dispose();
            this.var_978 = true;
        }

        private function createMainView(): void
        {
            if (this._view)
            {
                this._view.dispose();
            }

            this._view = (this.createView("welcome_gift_widget") as IWindowContainer);
            this._view.center();
            this.setBitmap("image_bg", "yellow_highlight");
            this.setBitmap("gift_image", "giftbox_full");
            if (this.var_3317)
            {
                this.setViewState(this.var_4778);
            }
            else
            {
                this.setViewState(this.var_4777);
            }

        }

        private function createView(param1: String): IWindow
        {
            var _loc2_: XmlAsset = assets.getAssetByName(param1) as XmlAsset;
            if (!_loc2_)
            {
                return null;
            }

            return windowManager.buildFromXML(_loc2_.content as XML);
        }

        private function disposeView(): void
        {
            if (this._view)
            {
                this._view.dispose();
                this._view = null;
            }

        }

        private function setViewState(param1: String): void
        {
            var _loc6_: ITextFieldWindow;
            var _loc2_: IWindowContainer = this._view.findChildByName("state_content") as IWindowContainer;
            while (_loc2_.numChildren > 0)
            {
                _loc2_.removeChildAt(0);
            }

            var _loc3_: IWindow = this.createView(param1);
            if (!_loc3_)
            {
                Logger.log("invalid welcome gift widget state: " + param1);
                return;
            }

            _loc2_.addChild(_loc3_);
            _loc2_.height = _loc3_.height;
            switch (param1)
            {
                case this.var_4777:
                    this.addClickHandler(this._view.findChildByName("edit"), this.changeEmail);
                    this.setBitmap("email_icon", "email_icon");
                    this.setCaption("title", "${welcome.gift.title.email.unverified}");
                    this.setCaption("text", "${welcome.gift.text.email.unverified}");
                    this._view.findChildByName("edit_text").visible = this.var_4734;
                    this._view.findChildByName("edit").setParamFlag(WindowParam.var_593, this.var_4734);
                    break;
                case this.var_4778:
                    this.setBitmap("email_icon", "ok_icon");
                    this.setCaption("title", "${welcome.gift.title.email.verified}");
                    this.setCaption("text", "${welcome.gift.text.email.verified}");
                    break;
                case this.var_4779:
                    this.addClickHandler(this._view.findChildByName("cancel_email_change"), this.cancelEmailChange);
                    this.addClickHandler(this._view.findChildByName("save_email"), this.saveEmail);
                    this.setBitmap("email_icon", "email_icon");
                    this.setButtonState("save_email", this.var_4734);
                    _loc6_ = (this._view.findChildByName("email_input") as ITextFieldWindow);
                    _loc6_.caption = this.var_3316;
                    _loc6_.focus();
                    _loc6_.setSelection(0, int.MAX_VALUE);
                    break;
            }

            var _loc4_: IWindow = this._view.findChildByName("email");
            if (_loc4_)
            {
                _loc4_.caption = this.var_3316;
            }

            var _loc5_: IWindow = this._view.findChildByName("open");
            if (_loc5_)
            {
                if (this.var_3317)
                {
                    _loc5_.enable();
                }
                else
                {
                    _loc5_.disable();
                }

            }

            this.addClickHandler(this._view.findChildByName("close"), this.close);
            this.addClickHandler(this._view.findChildByTag("close"), this.close);
            this.addClickHandler(this._view.findChildByName("open"), this.openGift);
            this.var_4782 = param1;
        }

        private function setCaption(param1: String, param2: String): void
        {
            if (!this._view)
            {
                return;
            }

            var _loc3_: IWindow = this._view.findChildByName(param1);
            if (_loc3_)
            {
                _loc3_.caption = param2;
            }

        }

        private function setBitmap(param1: String, param2: String): void
        {
            var _loc3_: IBitmapWrapperWindow = this._view.findChildByName(param1) as IBitmapWrapperWindow;
            var _loc4_: BitmapDataAsset = _assets.getAssetByName(param2) as BitmapDataAsset;
            if (!_loc3_ || !_loc4_)
            {
                return;
            }

            var _loc5_: BitmapData = _loc4_.content as BitmapData;
            if (_loc3_.bitmap)
            {
                _loc3_.bitmap.dispose();
            }

            _loc3_.bitmap = _loc5_.clone();
        }

        private function addClickHandler(param1: IWindow, param2: Function): void
        {
            if (param1)
            {
                param1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, param2);
            }

        }

        private function close(param1: WindowMouseEvent): void
        {
            this.disposeView();
        }

        private function changeEmail(param1: WindowMouseEvent): void
        {
            this.setViewState(this.var_4779);
        }

        private function openGift(param1: WindowMouseEvent): void
        {
            messageListener.processWidgetMessage(new RoomWidgetFurniActionMessage(RoomWidgetFurniActionMessage.var_1238, this._furniId, 0));
            this.disposeView();
        }

        private function cancelEmailChange(param1: WindowMouseEvent): void
        {
            this.setViewState(this.var_3317 ? this.var_4778 : this.var_4777);
        }

        private function saveEmail(param1: WindowMouseEvent): void
        {
            if (!this.var_4734)
            {
                return;
            }

            var _loc2_: ITextFieldWindow = this._view.findChildByName("email_input") as ITextFieldWindow;
            this._view.findChildByName("cancel_email_change").setParamFlag(WindowParam.var_593, false);
            this.setButtonState("save_email", false);
            _loc2_.editable = false;
            _loc2_.selectable = false;
            this.var_4781 = _loc2_.text;
            messageListener.processWidgetMessage(new RoomWidgetChangeEmailMessage(this.var_4781));
        }

        private function setButtonState(param1: String, param2: Boolean): void
        {
            if (!this._view)
            {
                return;
            }

            var _loc3_: IButtonWindow = this._view.findChildByName(param1) as IButtonWindow;
            if (_loc3_)
            {
                if (param2)
                {
                    _loc3_.enable();
                }
                else
                {
                    _loc3_.disable();
                }

            }

        }

        override public function registerUpdateEvents(param1: IEventDispatcher): void
        {
            if (!param1)
            {
                return;
            }

            param1.addEventListener(RoomWidgetWelcomeGiftUpdateEvent.var_1239, this.updateEventHandler);
            param1.addEventListener(RoomWidgetChangeEmailResultEvent.var_1240, this.emailChangeHandler);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1: IEventDispatcher): void
        {
            if (param1 == null)
            {
                return;
            }

            param1.removeEventListener(RoomWidgetWelcomeGiftUpdateEvent.var_1239, this.updateEventHandler);
            param1.removeEventListener(RoomWidgetChangeEmailResultEvent.var_1240, this.emailChangeHandler);
        }

        private function updateEventHandler(param1: RoomWidgetWelcomeGiftUpdateEvent): void
        {
            switch (param1.type)
            {
                case RoomWidgetWelcomeGiftUpdateEvent.var_1239:
                    this.var_3316 = param1.email;
                    this.var_3317 = param1.isVerified;
                    this.var_4734 = param1.allowEmailChange;
                    if (param1.requestedByUser)
                    {
                        this._furniId = param1.furniId;
                        this.createMainView();
                    }
                    else
                    {
                        this.updateView();
                    }

                    return;
            }

        }

        private function updateView(): void
        {
            if (!this._view)
            {
                return;
            }

            if (this.var_3317)
            {
                this.setViewState(this.var_4778);
            }
            else
            {
                this.setViewState(this.var_4777);
            }

        }

        private function emailChangeHandler(param1: RoomWidgetChangeEmailResultEvent): void
        {
            if (param1.result == 0)
            {
                this.var_3316 = this.var_4781;
                this.setViewState(this.var_4777);
            }
            else
            {
                if (param1.result == this.var_4780)
                {
                    this.var_4734 = false;
                }

                this.showEmailChangeError(param1.result);
            }

        }

        private function showEmailChangeError(param1: int): void
        {
            this.setViewState(this.var_4779);
            var _loc2_: IWindow = this._view.findChildByName("email_input_container");
            _loc2_.color = 0xFFFF8888;
            this.setCaption("email_input", this.var_4781);
            this.setCaption("email_change_instructions", "$" + "{welcome.gift.email.error." + param1 + "}");
        }

    }
}
