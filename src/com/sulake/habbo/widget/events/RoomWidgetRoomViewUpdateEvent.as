package com.sulake.habbo.widget.events
{
    import flash.geom.Rectangle;
    import flash.geom.Point;

    public class RoomWidgetRoomViewUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1327:String = "RWRVUE_ROOM_VIEW_SIZE_CHANGED";
        public static const var_1329:String = "RWRVUE_ROOM_VIEW_SCALE_CHANGED";
        public static const var_1328:String = "RWRVUE_ROOM_VIEW_POSITION_CHANGED";

        private var var_4714:Rectangle;
        private var var_4715:Point;
        private var _scale:Number = 0;

        public function RoomWidgetRoomViewUpdateEvent(param1:String, param2:Rectangle=null, param3:Point=null, param4:Number=0, param5:Boolean=false, param6:Boolean=false)
        {
            super(param1, param5, param6);
            this.var_4714 = param2;
            this.var_4715 = param3;
            this._scale = param4;
        }

        public function get rect():Rectangle
        {
            if (this.var_4714 != null)
            {
                return (this.var_4714.clone());
            };
            return (null);
        }

        public function get positionDelta():Point
        {
            if (this.var_4715 != null)
            {
                return (this.var_4715.clone());
            };
            return (null);
        }

        public function get scale():Number
        {
            return (this._scale);
        }

    }
}