package com.sulake.habbo.communication.messages.parser.room.engine
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.room.object.RoomPlaneParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FloorHeightMapMessageParser implements IMessageParser
    {

        private var _roomId: int = 0;
        private var _roomCategory: int = 0;
        private var _heightMap: Array = [];
        private var _width: int = 0;
        private var _height: int = 0;
        private var _scale: Number = 0;

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomCategory(): int
        {
            return this._roomCategory;
        }

        public function get width(): int
        {
            return this._width;
        }

        public function get height(): int
        {
            return this._height;
        }

        public function get scale(): Number
        {
            return this._scale;
        }

        public function getTileHeight(x: int, y: int): int
        {
            if (x < 0 || x >= this.width || y < 0 || y >= this.height)
            {
                return RoomPlaneParser.TILE_BLOCKED;
            }

            var tiles: Array = this._heightMap[y] as Array;

            return tiles[x];
        }

        public function flush(): Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._heightMap = [];
            this._width = 0;
            this._height = 0;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            var tileChar: String;

            if (data == null)
            {
                return false;
            }

            var unknown1: int;
            var unknown2: int;

            var heightmapRaw: String = data.readString();
            var rows: Array = heightmapRaw.split("\r");
            var j: int = 0;
            var i: int = 0;
            var tileState: int;
            var tiles: Array;
            var height: int = rows.length;
            var width: int;
            var columns: String;
            i = 0;

            while (i < height)
            {
                columns = (rows[i] as String);
                if (columns.length > width)
                {
                    width = columns.length;
                }

                i++;
            }

            this._heightMap = [];
            i = 0;

            while (i < height)
            {
                tiles = [];
                j = 0;
                
                while (j < width)
                {
                    tiles.push(RoomPlaneParser.TILE_BLOCKED);
                    j++;
                }

                this._heightMap.push(tiles);
                i++;
            }

            this._width = width;
            this._height = height;
            
            i = 0;

            while (i < rows.length)
            {
                tiles = (this._heightMap[i] as Array);
                columns = (rows[i] as String);

                if (columns.length > 0)
                {
                    j = 0;

                    while (j < columns.length)
                    {
                        tileChar = columns.charAt(j);

                        if (tileChar != "x" && tileChar != "X")
                        {
                            tileState = this.getHeightValue(tileChar);
                        }
                        else
                        {
                            tileState = RoomPlaneParser.TILE_BLOCKED;
                        }

                        tiles[j] = tileState;
                        j++;
                    }

                }

                i++;
            }

            if (this._width >= 20 || this._height >= 20)
            {
                this._scale = 32;
            }
            else
            {
                this._scale = 64;
            }

            return true;
        }

        private function getHeightValue(tileChar: String): int
        {
            var tile: int = parseInt(tileChar, 16);

            return tile % 10;
        }

    }
}
