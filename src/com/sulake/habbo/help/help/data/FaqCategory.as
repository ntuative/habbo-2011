package com.sulake.habbo.help.help.data
{

    import com.sulake.core.utils.Map;

    public class FaqCategory
    {

        private var _categoryId: int;
        private var _categoryTitle: String;
        private var _description: String;
        private var _items: Map;
        private var _itemCount: int = 0;
        private var _timestamp: Date;

        public function FaqCategory(categoryId: int, categoryTitle: String)
        {
            this._items = new Map();
            this._categoryId = categoryId;
            this._categoryTitle = categoryTitle;
        }

        public function get categoryId(): int
        {
            return this._categoryId;
        }

        public function get categoryTitle(): String
        {
            return this._categoryTitle;
        }

        public function get description(): String
        {
            return this._description;
        }

        public function get itemCount(): int
        {
            if (this._items.length == 0)
            {
                return this._itemCount;
            }

            return this._items.length;
        }

        public function set description(param1: String): void
        {
            this._description = param1;
        }

        public function set itemCount(param1: int): void
        {
            this._itemCount = param1;
        }

        public function dispose(): void
        {
            if (this._items != null)
            {
                this._items.dispose();
                this._items = null;
            }

        }

        public function storeItem(questionId: int, questionText: String, param3: String = null): void
        {
            var item: FaqItem = this.getItem(questionId);
            
            if (item == null)
            {
                item = new FaqItem(questionId, questionText, this._items.length, this);
                this._items.add(questionId, item);
            }

        }

        public function storeItemAnswer(questionId: int, answer: String): void
        {
            var item: FaqItem = this.getItem(questionId);
            
            if (item != null)
            {
                item.answerText = answer;
            }

        }

        public function reset(): void
        {
            if (this._items != null)
            {
                this._items.reset();
            }

        }

        public function getItemByIndex(index: int): FaqItem
        {
            if (index >= this._items.length)
            {
                return null;
            }

            return this._items.getWithIndex(index);
        }

        public function getItemIdByIndex(index: int): int
        {
            var item: FaqItem = this.getItemByIndex(index);
            
            if (item == null)
            {
                return -1;
            }

            return item.questionId;
        }

        public function hasItem(id: int): Boolean
        {
            return this._items.getValue(id) != null;
        }

        public function getItem(id: int): FaqItem
        {
            return this._items.getValue(id);
        }

        public function getItemIndex(id: int): int
        {
            var item: FaqItem = this.getItem(id);
            
            if (item == null)
            {
                return -1;
            }

            return item.index;
        }

        public function getQuestionTitleArray(): Array
        {
            var item: FaqItem;
            var questions: Array = [];
            var i: int;

            while (i < this._items.length)
            {
                item = this._items.getWithIndex(i);
                questions.push(item.questionText);
                i++;
            }

            return questions;
        }

        public function hasContent(): Boolean
        {
            return this._items.length > 0 || this.hasUpdatedWithinHour();
        }

        public function setTimeStamp(): void
        {
            this._timestamp = new Date();
        }

        public function getAgeSeconds(): Number
        {
            if (this._timestamp == null)
            {
                return new Date().valueOf();
            }

            return (new Date().valueOf() - this._timestamp.valueOf()) / 1000;
        }

        private function hasUpdatedWithinHour(): Boolean
        {
            return this.getAgeSeconds() < 60 * 60;
        }

    }
}
