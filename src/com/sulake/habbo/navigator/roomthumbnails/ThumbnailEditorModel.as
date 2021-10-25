package com.sulake.habbo.navigator.roomthumbnails
{

    import com.sulake.habbo.communication.messages.incoming.navigator.RoomThumbnailObjectData;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomThumbnailData;
    import com.sulake.habbo.navigator.Util;

    import flash.utils.Dictionary;

    public class ThumbnailEditorModel
    {

        public static const MODE_IMAGE_BACKGROUND: int = 1;
        public static const MODE_IMAGE_FOREGROUND: int = 2;
        public static const MODE_IMAGE_DEFAULT: int = 3; // TODO: Come back to this one

        private var _mode: int = 1;
        private var _selected: RoomThumbnailObjectData;
        private var _data: RoomThumbnailData;

        private function removeSelected(): void
        {
            var objects: Array = this._data.objects;

            if (this._selected == null)
            {
                return;
            }

            var removed: int = Util.remove(objects, this._selected);
            this._selected = null;

            if (objects.length > 0)
            {
                this._selected = objects[Math.min(removed, objects.length - 1)];
            }

        }

        private function addObject(id: int): void
        {
            Logger.log("New object pos: " + id);

            var thumbnail: RoomThumbnailObjectData = new RoomThumbnailObjectData();
            
            thumbnail.pos = id;
            thumbnail.imgId = 0;
            this._data.objects.push(thumbnail);
            this._selected = thumbnail;
            
            Logger.log("Object count after insert: " + this._data.objects.length);
        }

        public function setPos(id: int): void
        {
            this._selected = this.findByPos(id);

            if (this._selected == null)
            {
                this.addObject(id);
            }

        }

        public function setImg(id: int): void
        {
            if (this._mode == MODE_IMAGE_BACKGROUND)
            {
                this._data.bgImgId = id;
            }
            else
            {
                if (this._mode == MODE_IMAGE_FOREGROUND)
                {
                    this._data.frontImgId = id;
                }

            }

            if (this._mode == MODE_IMAGE_DEFAULT)
            {
                if (this._selected == null)
                {
                    return;
                }

                this._selected.imgId = id;
            }

        }

        public function getImgId(): int
        {
            if (this._mode == MODE_IMAGE_BACKGROUND)
            {
                return this._data.bgImgId;
            }

            if (this._mode == MODE_IMAGE_FOREGROUND)
            {
                return this._data.frontImgId;
            }

            return this._selected == null ? -1 : this._selected.imgId;
        }

        public function findByPos(position: int): RoomThumbnailObjectData
        {
            var thumbnailData: RoomThumbnailObjectData;

            for each (thumbnailData in this._data.objects)
            {
                if (thumbnailData.pos == position)
                {
                    return thumbnailData;
                }

            }

            return null;
        }

        public function getBlockedPositions(): Dictionary
        {
            var thumbnailData: RoomThumbnailObjectData;
            var positions: Dictionary = new Dictionary();

            for each (thumbnailData in this._data.objects)
            {
                if (thumbnailData.imgId > 0)
                {
                    positions[thumbnailData.pos] = "taken";
                }

            }

            return positions;
        }

        public function set data(value: RoomThumbnailData): void
        {
            this._data = value;
            this._mode = MODE_IMAGE_BACKGROUND;
            
            if (this._data.objects.length > 0)
            {
                this._selected = this._data.objects[0];
            }
            else
            {
                this._selected = null;
            }

        }

        public function set mode(param1: int): void
        {
            this._mode = param1;
        }

        public function set selected(param1: RoomThumbnailObjectData): void
        {
            this._selected = param1;
        }

        public function get mode(): int
        {
            return this._mode;
        }

        public function get selected(): RoomThumbnailObjectData
        {
            return this._selected;
        }

        public function get data(): RoomThumbnailData
        {
            return this._data;
        }

    }
}
