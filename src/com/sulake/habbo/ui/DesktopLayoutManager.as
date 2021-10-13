package com.sulake.habbo.ui
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.widget.enums.RoomWidgetEnum;
    import flash.geom.Rectangle;

    public class DesktopLayoutManager 
    {

        private const var_4624:String = "room_view";
        private const var_4625:String = "room_widget";

        private var var_4626:IWindowContainer;
        private var var_4627:int = 50;
        private var var_4628:XML = null;

        public function dispose():void
        {
            if (this.var_4626 != null)
            {
                this.var_4626.dispose();
            };
        }

        public function setLayout(param1:XML, param2:IHabboWindowManager, param3:IHabboConfigurationManager):void
        {
            var _loc5_:IWindow;
            var _loc7_:int;
            if (((param1 == null) || (param2 == null)))
            {
                throw (new Error("Unable to set room desktop layout."));
            };
            this.var_4628 = param1.copy();
            this.var_4626 = (param2.buildFromXML(param1, 0) as IWindowContainer);
            if (this.var_4626 == null)
            {
                throw (new Error("Failed to build layout from XML."));
            };
            this.var_4626.width = this.var_4626.desktop.width;
            this.var_4626.height = this.var_4626.desktop.height;
            var _loc4_:IWindowContainer = (this.var_4626.desktop as IWindowContainer);
            _loc4_.addChildAt(this.var_4626, 0);
            if (param3)
            {
                if (param3.getKey("friendbar.enabled") == "true")
                {
                    this.var_4626.findChildByTag("room_widget_infostand").y = (this.var_4626.findChildByTag("room_widget_infostand").y - 32);
                };
                if (param3.getKey("roominfo.widget.enabled") == "1")
                {
                    this.var_4626.findChildByTag("room_widget_infostand").y = (this.var_4626.findChildByTag("room_widget_infostand").y - 32);
                };
            };
            var _loc6_:int;
            while (_loc6_ < this.var_4626.numChildren)
            {
                _loc5_ = this.var_4626.getChildAt(_loc6_);
                _loc7_ = ((WindowParam.var_677) || (WindowParam.var_676));
                if (_loc5_.testParamFlag(_loc7_))
                {
                    _loc5_.addEventListener(WindowEvent.var_583, this.trimContainer);
                };
                _loc6_++;
            };
        }

        private function trimContainer(param1:WindowEvent):void
        {
            var _loc2_:IWindowContainer = (param1.window as IWindowContainer);
            if (_loc2_ == null)
            {
                return;
            };
            if (_loc2_.numChildren != 1)
            {
                return;
            };
            var _loc3_:IWindow = _loc2_.getChildAt(0);
            if (_loc3_ == null)
            {
                return;
            };
            _loc2_.width = _loc3_.width;
            _loc2_.height = _loc3_.height;
        }

        public function addWidgetWindow(param1:String, param2:IWindow):Boolean
        {
            var _loc4_:String;
            var _loc7_:IWindowContainer;
            if (param2 == null)
            {
                return (false);
            };
            if (param1 == RoomWidgetEnum.CHAT_INPUT_WIDGET)
            {
                _loc7_ = (this.var_4626.getChildByName("background_widgets") as IWindowContainer);
                _loc7_.addChild(param2);
                return (true);
            };
            var _loc3_:Array = param2.tags;
            var _loc5_:int;
            while (_loc5_ < _loc3_.length)
            {
                if (String(_loc3_[_loc5_]).indexOf(this.var_4625) == 0)
                {
                    _loc4_ = (_loc3_[_loc5_] as String);
                    break;
                };
                _loc5_++;
            };
            if (_loc4_ == null)
            {
                return (false);
            };
            var _loc6_:IWindowContainer = (this.var_4626.getChildByTag(_loc4_) as IWindowContainer);
            if (_loc6_ == null)
            {
                return (false);
            };
            param2.x = 0;
            param2.y = 0;
            _loc6_.addChild(param2);
            _loc6_.width = param2.width;
            _loc6_.height = param2.height;
            return (true);
        }

        public function addRoomView(param1:IWindow):Boolean
        {
            if (param1 == null)
            {
                return (false);
            };
            var _loc2_:IWindowContainer = (this.var_4626.getChildByTag(this.var_4624) as IWindowContainer);
            if (_loc2_ == null)
            {
                return (false);
            };
            _loc2_.addChild(param1);
            return (true);
        }

        public function set toolbarOrientation(param1:String):void
        {
            var _loc2_:Rectangle = new Rectangle();
            switch (param1)
            {
                case "LEFT":
                    _loc2_.x = this.var_4627;
                    _loc2_.width = (this.var_4626.desktop.width - this.var_4627);
                    _loc2_.y = 0;
                    _loc2_.height = this.var_4626.desktop.height;
                    break;
                case "RIGHT":
                    _loc2_.x = 0;
                    _loc2_.width = (this.var_4626.desktop.width - this.var_4627);
                    _loc2_.y = 0;
                    _loc2_.height = this.var_4626.desktop.height;
                    break;
                case "TOP":
                    _loc2_.x = 0;
                    _loc2_.width = this.var_4626.desktop.width;
                    _loc2_.y = this.var_4627;
                    _loc2_.height = (this.var_4626.desktop.height - this.var_4627);
                    break;
                case "BOTTOM":
                    _loc2_.x = 0;
                    _loc2_.width = this.var_4626.desktop.width;
                    _loc2_.y = 0;
                    _loc2_.height = (this.var_4626.desktop.height - this.var_4627);
                    break;
            };
            if (!_loc2_.isEmpty())
            {
                this.var_4626.rectangle = _loc2_;
            };
        }

        public function set toolbarSize(param1:int):void
        {
            this.var_4627 = param1;
        }

        public function get var_1534():Rectangle
        {
            if (this.var_4626 == null)
            {
                return (null);
            };
            var _loc1_:IWindowContainer = (this.var_4626.findChildByTag(this.var_4624) as IWindowContainer);
            if (!_loc1_)
            {
                return (null);
            };
            var _loc2_:Rectangle = _loc1_.rectangle.clone();
            if (!_loc2_)
            {
                return (null);
            };
            _loc2_.offset(this.var_4626.x, this.var_4626.y);
            return (_loc2_);
        }

        public function getRoomView():IWindow
        {
            if (this.var_4626 == null)
            {
                return (null);
            };
            var _loc1_:IWindowContainer = (this.var_4626.findChildByTag(this.var_4624) as IWindowContainer);
            if (((!(_loc1_ == null)) && (_loc1_.numChildren > 0)))
            {
                return (_loc1_.getChildAt(0));
            };
            return (null);
        }

    }
}