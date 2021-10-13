package com.sulake.habbo.widget.poll
{
    import com.sulake.habbo.widget.RoomWidgetBase;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.widget.events.RoomWidgetPollUpdateEvent;
    import flash.events.IEventDispatcher;
    import flash.events.Event;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;

    public class PollWidget extends RoomWidgetBase 
    {

        private var var_4897:Map;

        public function PollWidget(param1:IHabboWindowManager, param2:IAssetLibrary=null, param3:IHabboLocalizationManager=null)
        {
            super(param1, param2, param3);
            this.var_4897 = new Map();
        }

        override public function dispose():void
        {
            var _loc1_:int;
            var _loc2_:int;
            var _loc3_:PollSession;
            if (this.var_4897)
            {
                _loc1_ = this.var_4897.length;
                _loc2_ = 0;
                while (_loc2_ < _loc1_)
                {
                    _loc3_ = (this.var_4897.getWithIndex(0) as PollSession);
                    if (_loc3_ != null)
                    {
                        _loc3_.dispose();
                    };
                    _loc2_++;
                };
                this.var_4897 = null;
            };
            super.dispose();
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.addEventListener(RoomWidgetPollUpdateEvent.var_397, this.showPollOffer);
            param1.addEventListener(RoomWidgetPollUpdateEvent.var_61, this.showPollError);
            param1.addEventListener(RoomWidgetPollUpdateEvent.var_396, this.showPollContent);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.removeEventListener(RoomWidgetPollUpdateEvent.var_397, this.showPollOffer);
            param1.removeEventListener(RoomWidgetPollUpdateEvent.var_61, this.showPollError);
            param1.removeEventListener(RoomWidgetPollUpdateEvent.var_396, this.showPollContent);
        }

        private function showPollOffer(param1:Event):void
        {
            var _loc2_:int = RoomWidgetPollUpdateEvent(param1).id;
            var _loc3_:PollSession = (this.var_4897.getValue(_loc2_) as PollSession);
            var _loc4_:String = RoomWidgetPollUpdateEvent(param1).summary;
            if (!_loc3_)
            {
                _loc3_ = new PollSession(_loc2_, this);
                this.var_4897.add(_loc2_, _loc3_);
                _loc3_.showOffer(_loc4_);
            }
            else
            {
                Logger.log("Poll with given id already exists!");
                _loc3_.showOffer(_loc4_);
            };
        }

        private function showPollError(e:Event):void
        {
            windowManager.alert("${win_error}", RoomWidgetPollUpdateEvent(e).summary, 0, function (param1:IAlertDialog, param2:WindowEvent):void
            {
                param1.dispose();
            });
        }

        private function showPollContent(param1:Event):void
        {
            var _loc3_:int;
            var _loc4_:PollSession;
            var _loc2_:RoomWidgetPollUpdateEvent = (param1 as RoomWidgetPollUpdateEvent);
            if (_loc2_)
            {
                _loc3_ = _loc2_.id;
                _loc4_ = (this.var_4897.getValue(_loc3_) as PollSession);
                if (_loc4_)
                {
                    _loc4_.showContent(_loc2_.startMessage, _loc2_.endMessage, _loc2_.questionArray);
                };
            };
        }

        public function pollFinished(param1:int):void
        {
            var _loc2_:PollSession = (this.var_4897.getValue(param1) as PollSession);
            if (_loc2_)
            {
                _loc2_.showThanks();
                _loc2_.dispose();
                this.var_4897.remove(param1);
            };
        }

        public function pollCancelled(param1:int):void
        {
            var _loc2_:PollSession = (this.var_4897.getValue(param1) as PollSession);
            if (_loc2_)
            {
                _loc2_.dispose();
                this.var_4897.remove(param1);
            };
        }

    }
}