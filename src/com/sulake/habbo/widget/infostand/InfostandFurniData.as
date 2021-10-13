package com.sulake.habbo.widget.infostand
{
    import flash.display.BitmapData;
    import com.sulake.habbo.widget.events.RoomWidgetFurniInfoUpdateEvent;

    public class InfostandFurniData 
    {

        private var _id:int = 0;
        private var _category:int = 0;
        private var _name:String = "";
        private var var_2400:String = "";
        private var var_988:BitmapData;
        private var var_4415:int = -1;
        private var _offerId:int = -1;
        private var var_2836:String = "";

        public function set id(param1:int):void
        {
            this._id = param1;
        }

        public function set category(param1:int):void
        {
            this._category = param1;
        }

        public function set name(param1:String):void
        {
            this._name = param1;
        }

        public function set description(param1:String):void
        {
            this.var_2400 = param1;
        }

        public function set image(param1:BitmapData):void
        {
            this.var_988 = param1;
        }

        public function set catalogPageId(param1:int):void
        {
            this.var_4415 = param1;
        }

        public function set offerId(param1:int):void
        {
            this._offerId = param1;
        }

        public function set extraParam(param1:String):void
        {
            this.var_2836 = param1;
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get category():int
        {
            return (this._category);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get description():String
        {
            return (this.var_2400);
        }

        public function get image():BitmapData
        {
            return (this.var_988);
        }

        public function get catalogPageId():int
        {
            return (this.var_4415);
        }

        public function get offerId():int
        {
            return (this._offerId);
        }

        public function get extraParam():String
        {
            return (this.var_2836);
        }

        public function setData(param1:RoomWidgetFurniInfoUpdateEvent):void
        {
            this.id = param1.id;
            this.category = param1.category;
            this.name = param1.name;
            this.description = param1.description;
            this.image = param1.image;
            this.catalogPageId = param1.catalogPageId;
            this.offerId = param1.offerId;
            this.extraParam = param1.extraParam;
        }

    }
}