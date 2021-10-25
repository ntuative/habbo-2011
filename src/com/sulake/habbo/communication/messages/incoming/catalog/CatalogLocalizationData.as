package com.sulake.habbo.communication.messages.incoming.catalog
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CatalogLocalizationData
    {

        private var _images: Array;
        private var _texts: Array;

        public function CatalogLocalizationData(data: IMessageDataWrapper)
        {
            this._images = [];
            this._texts = [];

            var imageCount: int = data.readInteger();
            var i: int;

            while (i < imageCount)
            {
                this._images.push(data.readString());
                i++;
            }


            var textsCount: int = data.readInteger();
            var j: int;

            while (j < textsCount)
            {
                this._texts.push(data.readString());
                j++;
            }

        }

        public function get images(): Array
        {
            return this._images;
        }

        public function get texts(): Array
        {
            return this._texts;
        }

    }
}
