package com.sulake.habbo.catalog.club
{
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;

    public class ClubGiftConfirmationDialog 
    {

        private var var_2607:Offer;
        private var _controller:ClubGiftController;
        private var _view:IFrameWindow;

        public function ClubGiftConfirmationDialog(param1:ClubGiftController, param2:Offer)
        {
            this.var_2607 = param2;
            this._controller = param1;
            this.showConfirmation();
        }

        public function dispose():void
        {
            this._controller = null;
            this.var_2607 = null;
            if (this._view)
            {
                this._view.dispose();
                this._view = null;
            };
        }

        public function showConfirmation():void
        {
            if (((!(this.var_2607)) || (!(this._controller))))
            {
                return;
            };
            this._view = (this.createWindow("club_gift_confirmation") as IFrameWindow);
            if (!this._view)
            {
                return;
            };
            this._view.procedure = this.windowEventHandler;
            this._view.center();
            var _loc1_:ITextWindow = (this._view.findChildByName("item_name") as ITextWindow);
            if (_loc1_)
            {
                _loc1_.text = this.getProductName();
            };
            var _loc2_:IWindowContainer = (this._view.findChildByName("image_border") as IWindowContainer);
            if (!_loc2_)
            {
                return;
            };
            if (!this.var_2607.productContainer)
            {
                return;
            };
            this.var_2607.productContainer.view = _loc2_;
            this.var_2607.productContainer.initProductIcon(this._controller.roomEngine);
        }

        private function getProductName():String
        {
            var _loc1_:IProductData;
            if ((((this.var_2607) && (this.var_2607.productContainer)) && (this.var_2607.productContainer.firstProduct)))
            {
                _loc1_ = this.var_2607.productContainer.firstProduct.productData;
                if (_loc1_)
                {
                    return (_loc1_.name);
                };
            };
            return ("");
        }

        private function windowEventHandler(param1:WindowEvent, param2:IWindow):void
        {
            if (((((!(param1)) || (!(param2))) || (!(this._controller))) || (!(this.var_2607))))
            {
                return;
            };
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            switch (param2.name)
            {
                case "select_button":
                    this._controller.confirmSelection(this.var_2607.localizationId);
                    return;
                case "header_button_close":
                case "cancel_button":
                    this._controller.closeConfirmation();
                    return;
            };
        }

        private function createWindow(param1:String):IWindow
        {
            if ((((!(this._controller)) || (!(this._controller.assets))) || (!(this._controller.windowManager))))
            {
                return (null);
            };
            var _loc2_:XmlAsset = (this._controller.assets.getAssetByName(param1) as XmlAsset);
            if (((!(_loc2_)) || (!(_loc2_.content))))
            {
                return (null);
            };
            var _loc3_:XML = (_loc2_.content as XML);
            if (!_loc3_)
            {
                return (null);
            };
            return (this._controller.windowManager.buildFromXML(_loc3_));
        }

    }
}