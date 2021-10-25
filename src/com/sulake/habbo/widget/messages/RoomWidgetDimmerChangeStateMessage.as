package com.sulake.habbo.widget.messages
{

    public class RoomWidgetDimmerChangeStateMessage extends RoomWidgetMessage
    {

        public static const CHANGE_STATE: String = "RWCDSM_CHANGE_STATE";

        public function RoomWidgetDimmerChangeStateMessage()
        {
            super(RoomWidgetDimmerChangeStateMessage.CHANGE_STATE);
        }

    }
}
