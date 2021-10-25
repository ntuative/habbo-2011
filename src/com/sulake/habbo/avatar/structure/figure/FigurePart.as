package com.sulake.habbo.avatar.structure.figure
{

    public class FigurePart implements IFigurePart
    {

        private var _id: int;
        private var _type: String;
        private var _breed: int = -1;
        private var _colorLayerIndex: int;
        private var _index: int;
        private var _paletteMap: int = -1;

        public function FigurePart(data: XML)
        {
            this._id = parseInt(data.@id);
            this._type = String(data.@type);
            this._index = parseInt(data.@index);
            this._colorLayerIndex = parseInt(data.@colorindex);

            var paletteMap: String = data.@palettemapid;

            if (paletteMap != "")
            {
                this._paletteMap = int(paletteMap);
            }


            var breed: String = data.@breed;

            if (breed != "")
            {
                this._breed = int(breed);
            }

        }

        public function dispose(): void
        {
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get type(): String
        {
            return this._type;
        }

        public function get breed(): int
        {
            return this._breed;
        }

        public function get colorLayerIndex(): int
        {
            return this._colorLayerIndex;
        }

        public function get index(): int
        {
            return this._index;
        }

        public function get paletteMap(): int
        {
            return this._paletteMap;
        }

    }
}
