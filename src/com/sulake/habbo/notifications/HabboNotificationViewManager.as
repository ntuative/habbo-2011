package com.sulake.habbo.notifications
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;

    public class HabboNotificationViewManager implements IUpdateReceiver 
    {

        private static const var_543:int = 78;
        private static const var_544:int = 4;

        private var _assetLibrary:IAssetLibrary;
        private var _windowManager:IHabboWindowManager;
        private var var_3898:Map;
        private var var_3899:Map;
        private var var_2844:IHabboToolbar;
        private var _disposed:Boolean = false;
        private var var_3918:Array;

        public function HabboNotificationViewManager(param1:IAssetLibrary, param2:IHabboWindowManager, param3:Map, param4:Map, param5:IHabboToolbar)
        {
            this._assetLibrary = param1;
            this._windowManager = param2;
            this.var_3898 = param3;
            this.var_3899 = param4;
            this.var_2844 = param5;
            this.var_3918 = new Array();
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function replaceIcon(param1:BadgeImageReadyEvent):void
        {
            var _loc2_:HabboNotificationItemView;
            for each (_loc2_ in this.var_3918)
            {
                _loc2_.replaceIcon(param1);
            };
        }

        public function dispose():void
        {
            var _loc1_:int = this.var_3918.length;
            var _loc2_:int;
            while (_loc2_ < _loc1_)
            {
                (this.var_3918.pop() as HabboNotificationItemView).dispose();
                _loc2_++;
            };
            this._disposed = true;
        }

        public function showItem(param1:HabboNotificationItem):Boolean
        {
            if (!this.isSpaceAvailable())
            {
                return (false);
            };
            var _loc2_:HabboNotificationItemView = new HabboNotificationItemView(this._assetLibrary.getAssetByName("layout_notification_xml"), this._windowManager, this.var_3898, this.var_3899, this.var_2844, param1);
            _loc2_.reposition(this.getNextAvailableVerticalPosition());
            this.var_3918.push(_loc2_);
            this.var_3918.sortOn("verticalPosition", Array.NUMERIC);
            return (true);
        }

        public function isSpaceAvailable():Boolean
        {
            return ((this.getNextAvailableVerticalPosition() + HabboNotificationItemView.var_542) < 540);
        }

        public function update(param1:uint):void
        {
            var _loc3_:HabboNotificationItemView;
            var _loc2_:int;
            _loc2_ = 0;
            while (_loc2_ < this.var_3918.length)
            {
                (this.var_3918[_loc2_] as HabboNotificationItemView).update(param1);
                _loc2_++;
            };
            _loc2_ = 0;
            while (_loc2_ < this.var_3918.length)
            {
                _loc3_ = (this.var_3918[_loc2_] as HabboNotificationItemView);
                if (_loc3_.ready)
                {
                    _loc3_.dispose();
                    this.var_3918.splice(_loc2_, 1);
                    _loc2_--;
                };
                _loc2_++;
            };
        }

        private function getNextAvailableVerticalPosition():int
        {
            var _loc3_:HabboNotificationItemView;
            if (this.var_3918.length == 0)
            {
                return (var_543);
            };
            var _loc1_:int = var_543;
            var _loc2_:int;
            while (_loc2_ < this.var_3918.length)
            {
                _loc3_ = (this.var_3918[_loc2_] as HabboNotificationItemView);
                if ((_loc1_ + HabboNotificationItemView.var_542) < _loc3_.verticalPosition)
                {
                    return (_loc1_);
                };
                _loc1_ = ((_loc3_.verticalPosition + HabboNotificationItemView.var_542) + var_544);
                _loc2_++;
            };
            return (_loc1_);
        }

    }
}