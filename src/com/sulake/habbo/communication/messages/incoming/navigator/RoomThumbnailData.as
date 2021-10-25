package com.sulake.habbo.communication.messages.incoming.navigator
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomThumbnailData implements IDisposable
    {

        private var _bgImgId: int;
        private var _frontImgId: int;
        private var _objects: Array = [];
        private var _disposed: Boolean;

        public function RoomThumbnailData(data: IMessageDataWrapper)
        {
            super();

            if (data == null)
            {
                return;
            }

            this._bgImgId = data.readInteger();
            this._frontImgId = data.readInteger();
            
            var thumbnailObjectData: RoomThumbnailObjectData;
            var thumbnailObjectCount: int = data.readInteger();
            var i: int;

            while (i < thumbnailObjectCount)
            {
                thumbnailObjectData = new RoomThumbnailObjectData();
                thumbnailObjectData.pos = data.readInteger();
                thumbnailObjectData.imgId = data.readInteger();
                this._objects.push(thumbnailObjectData);
                i++;
            }

            if (this._bgImgId == 0)
            {
                this.setDefaults();
            }

        }

        private function setDefaults(): void
        {
            this._bgImgId = 1;
            this._frontImgId = 0;
            
            var thumbnailObjectData: RoomThumbnailObjectData = new RoomThumbnailObjectData();
            
            thumbnailObjectData.pos = 4;
            thumbnailObjectData.imgId = 1;
            
            this._objects.push(thumbnailObjectData);
        }

        public function getCopy(): RoomThumbnailData
        {
            var thumbnailData: RoomThumbnailData = new RoomThumbnailData(null);
            
            thumbnailData._bgImgId = this._bgImgId;
            thumbnailData._frontImgId = this._frontImgId;
            
            var thumbnailObject: RoomThumbnailObjectData;
            
            for each (thumbnailObject in this._objects)
            {
                thumbnailData._objects.push(thumbnailObject.getCopy());
            }

            return thumbnailData;
        }

        public function dispose(): void
        {
            if (this._disposed)
            {
                return;
            }

            this._disposed = true;
            this._objects = null;
        }

        public function getAsString(): String
        {
            var str: * = this._frontImgId + ";";
            str = str + (this._bgImgId + ";");
            
            var thumbnailObjectData: RoomThumbnailObjectData;
            
            for each (thumbnailObjectData in this._objects)
            {
                str = str + (thumbnailObjectData.imgId + "," + thumbnailObjectData.pos + ";");
            }

            return str;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get bgImgId(): int
        {
            return this._bgImgId;
        }

        public function get frontImgId(): int
        {
            return this._frontImgId;
        }

        public function get objects(): Array
        {
            return this._objects;
        }

        public function set bgImgId(param1: int): void
        {
            this._bgImgId = param1;
        }

        public function set frontImgId(param1: int): void
        {
            this._frontImgId = param1;
        }

    }
}
