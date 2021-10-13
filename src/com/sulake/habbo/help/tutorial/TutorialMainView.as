package com.sulake.habbo.help.tutorial
{
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class TutorialMainView implements ITutorialUIView 
    {

        private var var_3486:TutorialUI;

        public function TutorialMainView(param1:IItemListWindow, param2:TutorialUI):void
        {
            var _loc6_:IWindow;
            super();
            this.var_3486 = param2;
            var _loc3_:IWindowContainer = (param2.buildXmlWindow("tutorial_front_page") as IWindowContainer);
            if (_loc3_ == null)
            {
                return;
            };
            _loc3_.procedure = this.windowProcedure;
            var _loc4_:IItemListWindow = (_loc3_.findChildByName("button_list") as IItemListWindow);
            var _loc5_:int;
            _loc6_ = _loc3_.findChildByName("container_name");
            if (this.var_3486.hasChangedName)
            {
                _loc4_.removeListItem(_loc6_);
            }
            else
            {
                this.setButtonStateNormal(_loc3_.findChildByName("button_name"));
                _loc5_ = (_loc5_ + _loc6_.width);
            };
            _loc6_ = _loc3_.findChildByName("container_looks");
            if (this.var_3486.hasChangedLooks)
            {
                _loc4_.removeListItem(_loc6_);
            }
            else
            {
                this.setButtonStateNormal(_loc3_.findChildByName("button_looks"));
                _loc5_ = (_loc5_ + _loc6_.width);
            };
            _loc6_ = _loc3_.findChildByName("container_guidebot");
            if (((this.var_3486.hasCalledGuideBot) || (!((this.var_3486.hasChangedName) || (this.var_3486.hasChangedLooks)))))
            {
                _loc4_.removeListItem(_loc6_);
            }
            else
            {
                this.setButtonStateNormal(_loc3_.findChildByName("button_guidebot"));
                _loc5_ = (_loc5_ + _loc6_.width);
            };
            _loc4_.width = _loc5_;
            _loc6_ = _loc3_.findChildByName("name_field");
            _loc6_.caption = this.var_3486.myName;
            param1.addListItem((_loc3_ as IWindow));
        }

        public function get view():IWindowContainer
        {
            return (null);
        }

        public function get id():String
        {
            return (TutorialUI.var_1427);
        }

        public function dispose():void
        {
        }

        private function setButtonStateNormal(param1:IWindow):void
        {
            var _loc3_:BitmapDataAsset;
            var _loc2_:IBitmapWrapperWindow = (param1 as IBitmapWrapperWindow);
            switch (param1.name)
            {
                case "button_name":
                    _loc3_ = BitmapDataAsset(this.var_3486.assets.getAssetByName("tutorial_button_changename"));
                    break;
                case "button_looks":
                    _loc3_ = BitmapDataAsset(this.var_3486.assets.getAssetByName("tutorial_button_changelooks"));
                    break;
                case "button_guidebot":
                    _loc3_ = BitmapDataAsset(this.var_3486.assets.getAssetByName("tutorial_button_guidebot"));
                    break;
            };
            if ((((!(_loc2_ == null)) && (!(_loc3_ == null))) && (!(_loc3_.content == null))))
            {
                _loc2_.bitmap = (_loc3_.content as BitmapData).clone();
            };
        }

        private function setButtonStateOver(param1:IWindow):void
        {
            var _loc3_:BitmapDataAsset;
            var _loc2_:IBitmapWrapperWindow = (param1 as IBitmapWrapperWindow);
            switch (param1.name)
            {
                case "button_name":
                    _loc3_ = BitmapDataAsset(this.var_3486.assets.getAssetByName("tutorial_button_changename_over"));
                    break;
                case "button_looks":
                    _loc3_ = BitmapDataAsset(this.var_3486.assets.getAssetByName("tutorial_button_changelooks_over"));
                    break;
                case "button_guidebot":
                    _loc3_ = BitmapDataAsset(this.var_3486.assets.getAssetByName("tutorial_button_guidebot_over"));
                    break;
            };
            if ((((!(_loc2_ == null)) && (!(_loc3_ == null))) && (!(_loc3_.content == null))))
            {
                _loc2_.bitmap = (_loc3_.content as BitmapData).clone();
            };
        }

        private function windowProcedure(param1:WindowEvent, param2:IWindow):void
        {
            switch (param2.name)
            {
                case "button_looks":
                    switch (param1.type)
                    {
                        case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
                            this.var_3486.showView(TutorialUI.var_1428);
                            break;
                        case WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER:
                            this.setButtonStateOver(param2);
                            break;
                        case WindowMouseEvent.var_626:
                            this.setButtonStateNormal(param2);
                            break;
                    };
                    return;
                case "button_name":
                    switch (param1.type)
                    {
                        case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
                            this.var_3486.showView(TutorialUI.var_303);
                            break;
                        case WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER:
                            this.setButtonStateOver(param2);
                            break;
                        case WindowMouseEvent.var_626:
                            this.setButtonStateNormal(param2);
                            break;
                    };
                    return;
                case "button_guidebot":
                    switch (param1.type)
                    {
                        case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
                            this.var_3486.showView(TutorialUI.var_1429);
                            break;
                        case WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER:
                            this.setButtonStateOver(param2);
                            break;
                        case WindowMouseEvent.var_626:
                            this.setButtonStateNormal(param2);
                            break;
                    };
                    return;
            };
        }

    }
}