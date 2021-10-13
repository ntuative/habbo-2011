package com.sulake.habbo.navigator.domain
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.EventsTabPageDecorator;
    import com.sulake.habbo.navigator.mainview.MainViewCtrl;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.RoomsTabPageDecorator;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.OfficialTabPageDecorator;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.MyRoomsTabPageDecorator;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.SearchTabPageDecorator;

    public class Tabs 
    {

        public static const var_163:int = 1;
        public static const var_160:int = 2;
        public static const var_162:int = 3;
        public static const var_161:int = 4;
        public static const var_164:int = 5;
        public static const var_839:int = 1;
        public static const var_841:int = 2;
        public static const var_836:int = 3;
        public static const var_840:int = 4;
        public static const var_166:int = 5;
        public static const var_835:int = 6;
        public static const var_837:int = 7;
        public static const var_842:int = 8;
        public static const var_165:int = 9;
        public static const var_920:int = 10;
        public static const var_838:int = 11;
        public static const var_834:int = 12;

        private var var_2809:Array;
        private var _navigator:HabboNavigator;

        public function Tabs(param1:HabboNavigator)
        {
            this._navigator = param1;
            this.var_2809 = new Array();
            this.var_2809.push(new Tab(this._navigator, var_163, var_834, new EventsTabPageDecorator(this._navigator), MainViewCtrl.var_828));
            this.var_2809.push(new Tab(this._navigator, var_160, var_839, new RoomsTabPageDecorator(this._navigator), MainViewCtrl.var_828));
            this.var_2809.push(new Tab(this._navigator, var_161, var_838, new OfficialTabPageDecorator(this._navigator), MainViewCtrl.var_831));
            this.var_2809.push(new Tab(this._navigator, var_162, var_166, new MyRoomsTabPageDecorator(this._navigator), MainViewCtrl.var_828));
            this.var_2809.push(new Tab(this._navigator, var_164, var_842, new SearchTabPageDecorator(this._navigator), MainViewCtrl.var_829));
            this.setSelectedTab(var_163);
        }

        public function onFrontPage():Boolean
        {
            return (this.getSelected().id == var_161);
        }

        public function get tabs():Array
        {
            return (this.var_2809);
        }

        public function setSelectedTab(param1:int):void
        {
            this.clearSelected();
            this.getTab(param1).selected = true;
        }

        public function getSelected():Tab
        {
            var _loc1_:Tab;
            for each (_loc1_ in this.var_2809)
            {
                if (_loc1_.selected)
                {
                    return (_loc1_);
                };
            };
            return (null);
        }

        private function clearSelected():void
        {
            var _loc1_:Tab;
            for each (_loc1_ in this.var_2809)
            {
                _loc1_.selected = false;
            };
        }

        public function getTab(param1:int):Tab
        {
            var _loc2_:Tab;
            for each (_loc2_ in this.var_2809)
            {
                if (_loc2_.id == param1)
                {
                    return (_loc2_);
                };
            };
            return (null);
        }

    }
}