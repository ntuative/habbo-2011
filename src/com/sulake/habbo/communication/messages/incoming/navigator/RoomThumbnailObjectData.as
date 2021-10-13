package com.sulake.habbo.communication.messages.incoming.navigator
{
    public class RoomThumbnailObjectData 
    {

        private var var_3018:int;
        private var var_3019:int;

        public function getCopy():RoomThumbnailObjectData
        {
            var _loc1_:RoomThumbnailObjectData = new RoomThumbnailObjectData();
            _loc1_.var_3018 = this.var_3018;
            _loc1_.var_3019 = this.var_3019;
            return (_loc1_);
        }

        public function set pos(param1:int):void
        {
            this.var_3018 = param1;
        }

        public function set imgId(param1:int):void
        {
            this.var_3019 = param1;
        }

        public function get pos():int
        {
            return (this.var_3018);
        }

        public function get imgId():int
        {
            return (this.var_3019);
        }

    }
}