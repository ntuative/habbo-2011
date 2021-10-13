package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.navigator.domain.Tabs;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.enum.*;

    public class RoomsTabPageDecorator implements ITabPageDecorator 
    {

        private var _navigator:HabboNavigator;
        private var var_3544:IDropMenuWindow;

        public function RoomsTabPageDecorator(param1:HabboNavigator)
        {
            this._navigator = param1;
        }

        public function refreshCustomContent(param1:IWindowContainer):void
        {
            var _loc2_:String = "rooms_header";
            var _loc3_:IWindowContainer = (param1.getChildByName(_loc2_) as IWindowContainer);
            if (this.var_3544 == null)
            {
                this.var_3544 = IDropMenuWindow(_loc3_.findChildByName("roomCtgFilter"));
                this.prepareRoomCategories();
            };
            _loc3_.visible = true;
        }

        public function tabSelected():void
        {
            if (this.var_3544 != null)
            {
                this.var_3544.selection = 0;
            };
        }

        public function refreshFooter(param1:IWindowContainer):void
        {
            this._navigator.officialRoomEntryManager.refreshAdFooter(param1);
        }

        public function navigatorOpenedWhileInTab():void
        {
            this.startSearch();
        }

        public function prepareRoomCategories():void
        {
            var _loc3_:FlatCategory;
            if (this.var_3544 == null)
            {
                return;
            };
            var _loc1_:Array = new Array();
            _loc1_.push(this._navigator.getText("navigator.navisel.popularrooms"));
            _loc1_.push(this._navigator.getText("navigator.navisel.highestscore"));
            var _loc2_:int = 100;
            for each (_loc3_ in this._navigator.data.visibleCategories)
            {
                _loc1_.push(_loc3_.nodeName);
            };
            this.var_3544.procedure = null;
            this.var_3544.populate(_loc1_);
            this.var_3544.selection = 0;
            this.var_3544.procedure = this.onChangeFilter;
        }

        private function onChangeFilter(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowEvent.var_560)
            {
                return;
            };
            this.startSearch();
        }

        private function startSearch():void
        {
            var _loc2_:FlatCategory;
            var _loc3_:int;
            var _loc1_:int = ((this.var_3544 == null) ? 0 : this.var_3544.selection);
            Logger.log(("Room filter changed: " + _loc1_));
            if (_loc1_ == 0)
            {
                this._navigator.mainViewCtrl.startSearch(Tabs.var_160, Tabs.var_839);
            }
            else
            {
                if (_loc1_ == 1)
                {
                    this._navigator.mainViewCtrl.startSearch(Tabs.var_160, Tabs.var_841);
                }
                else
                {
                    _loc2_ = this._navigator.data.visibleCategories[(_loc1_ - 2)];
                    if (_loc2_ == null)
                    {
                        Logger.log(((("No fc found: " + _loc1_) + ", ") + this._navigator.data.visibleCategories.length));
                        return;
                    };
                    _loc3_ = _loc2_.nodeId;
                    Logger.log(("Searching with catId: " + _loc3_));
                    this._navigator.mainViewCtrl.startSearch(Tabs.var_160, Tabs.var_839, ("" + _loc3_));
                };
            };
        }

    }
}