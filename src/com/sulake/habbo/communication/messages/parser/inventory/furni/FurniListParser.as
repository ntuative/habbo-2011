package com.sulake.habbo.communication.messages.parser.inventory.furni
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniData;

    public class FurniListParser implements IMessageParser
    {

        protected var _categoryType: String;
        protected var _totalFragments: int;
        protected var _fragmentNo: int;
        protected var _getFurni: Array;

        public function parse(param1: IMessageDataWrapper): Boolean
        {
            this._categoryType = param1.readString();
            this._totalFragments = param1.readInteger();
            this._fragmentNo = param1.readInteger();
            this._getFurni = [];
            var _loc2_: int = param1.readInteger();
            var _loc3_: int;
            while (_loc3_ < _loc2_)
            {
                this._getFurni.push(this.parseItem(param1));
                _loc3_++;
            }

            return true;
        }

        public function parseItem(data: IMessageDataWrapper): FurniData
        {
            var stripId: int = data.readInteger();
            var itemType: String = data.readString();
            var objId: int = data.readInteger();
            var classId: int = data.readInteger();
            var category: int = data.readInteger();
            var stuffData: String = data.readString();
            var isGroupable: Boolean = data.readBoolean();
            var isRecyclable: Boolean = data.readBoolean();
            var isTradeable: Boolean = data.readBoolean();
            var isSellable: Boolean = data.readBoolean();
            var expiryTime: int = data.readInteger();
            
            var furniData: FurniData = new FurniData(stripId, itemType, objId, classId, category, stuffData, isTradeable, isGroupable, isRecyclable, isSellable, expiryTime);
                        
            if (itemType == "S")
            {
                var slotId: String = data.readString();
                var extra: int = data.readInteger();

                furniData.setExtraData(slotId, extra);
            }

            return furniData;
        }

        public function flush(): Boolean
        {
            this._getFurni = null;

            return true;
        }

        public function get categoryType(): String
        {
            return this._categoryType;
        }

        public function get totalFragments(): int
        {
            return this._totalFragments;
        }

        public function get fragmentNo(): int
        {
            return this._fragmentNo;
        }

        public function getFurni(): Array
        {
            return this._getFurni;
        }

    }
}
