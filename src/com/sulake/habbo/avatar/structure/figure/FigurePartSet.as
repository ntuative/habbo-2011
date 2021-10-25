package com.sulake.habbo.avatar.structure.figure
{

    public class FigurePartSet implements IFigurePartSet
    {

        private var _type: String;
        private var _id: int;
        private var _gender: String;
        private var _clubLevel: int;
        private var _isColorable: Boolean;
        private var _isSelectable: Boolean;
        private var _parts: Array;
        private var _hiddenLayers: Array;

        public function FigurePartSet(data: XML, type: String)
        {
            super();
            this._type = type;
            this._id = parseInt(data.@id);
            this._gender = String(data.@gender);
            this._clubLevel = parseInt(data.@club);
            this._isColorable = Boolean(parseInt(data.@colorable));
            this._isSelectable = Boolean(parseInt(data.@selectable));
            this._parts = [];
            this._hiddenLayers = [];

            var part: XML;
            var layer: XML;
            var figurePart: FigurePart;
            var partTypeIndex: int;

            for each (part in data.part)
            {
                figurePart = new FigurePart(part);
                partTypeIndex = this.indexOfPartType(figurePart);
                if (partTypeIndex != -1)
                {
                    this._parts.splice(partTypeIndex, 0, figurePart);
                }
                else
                {
                    this._parts.push(figurePart);
                }

            }

            for each (layer in data.hiddenlayers.layer)
            {
                this._hiddenLayers.push(String(layer.@parttype));
            }

        }

        public function dispose(): void
        {
            var part: FigurePart;

            for each (part in this._parts)
            {
                part.dispose();
            }


            this._parts = null;
            this._hiddenLayers = null;
        }

        private function indexOfPartType(figurePart: FigurePart): int
        {
            var part: FigurePart;
            var i: int;

            while (i < this._parts.length)
            {
                part = this._parts[i];

                if (part.type == figurePart.type && part.index < figurePart.index)
                {
                    return i;
                }


                i++;
            }


            return -1;
        }

        public function getPart(type: String, id: int): IFigurePart
        {
            var part: FigurePart;

            for each (part in this._parts)
            {
                if (part.type == type && part.id == id)
                {
                    return part;
                }

            }


            return null;
        }

        public function get type(): String
        {
            return this._type;
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get gender(): String
        {
            return this._gender;
        }

        public function get clubLevel(): int
        {
            return this._clubLevel;
        }

        public function get isColorable(): Boolean
        {
            return this._isColorable;
        }

        public function get isSelectable(): Boolean
        {
            return this._isSelectable;
        }

        public function get parts(): Array
        {
            return this._parts;
        }

        public function get hiddenLayers(): Array
        {
            return this._hiddenLayers;
        }

    }
}
