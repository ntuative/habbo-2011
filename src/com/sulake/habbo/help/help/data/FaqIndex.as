package com.sulake.habbo.help.help.data
{

    import com.sulake.core.utils.Map;

    public class FaqIndex
    {

        private var _categoryUrgent: FaqCategory;
        private var _categoryNormal: FaqCategory;
        private var _categorySearchResults: FaqCategory;
        private var _categories: Map;
        private var _lastUpdatedQuestionId: int;
        private var _lastUpdatedCategoryId: int;

        public function FaqIndex()
        {
            this._categoryUrgent = new FaqCategory(-999, "${help.faq.title.urgent}");
            this._categoryNormal = new FaqCategory(-9999, "${help.faq.title.normal}");
            this._categorySearchResults = new FaqCategory(-99999, "${help.faq.title.searchresults}");
            this._categories = new Map();
        }

        public function get lastUpdatedQuestionId(): int
        {
            return this._lastUpdatedQuestionId;
        }

        public function get lastUpdatedCategoryId(): int
        {
            return this._lastUpdatedCategoryId;
        }

        public function dispose(): void
        {
            var i: int;
            var category: FaqCategory;

            if (this._categories != null)
            {
                i = 0;

                while (i < this._categories.length)
                {
                    category = this._categories.getWithIndex(i);
                    category.dispose();
                    i++;
                }

                this._categories.dispose();
                this._categories = null;
            }

            this._categoryUrgent.dispose();
            this._categoryNormal.dispose();
            this._categorySearchResults.dispose();
        }

        public function getCategory(id: int, title: String = null, param3: Boolean = false): FaqCategory
        {
            var category: FaqCategory = this._categories.getValue(id);
            
            if (category != null || !param3)
            {
                return category;
            }

            category = new FaqCategory(id, title);
            this._categories.add(id, category);

            return category;
        }

        public function getItem(id: int, categoryId: int = -1): FaqItem
        {
            if (categoryId < 0)
            {
                return this.findItem(id);
            }

            var category: FaqCategory = this.getCategory(categoryId);
            
            if (category == null)
            {
                return null;
            }

            return category.getItem(id);
        }

        public function storeAnswerText(questionId: int, answer: String): void
        {
            var category: FaqCategory;

            if (this._categoryUrgent.hasItem(questionId))
            {
                this._categoryUrgent.getItem(questionId).answerText = answer;
            }

            if (this._categoryNormal.hasItem(questionId))
            {
                this._categoryNormal.getItem(questionId).answerText = answer;
            }

            if (this._categorySearchResults.hasItem(questionId))
            {
                this._categorySearchResults.getItem(questionId).answerText = answer;
            }

            var i: int;

            while (i < this._categories.length)
            {
                category = this._categories.getWithIndex(i);

                if (category.hasItem(questionId))
                {
                    category.getItem(questionId).answerText = answer;
                }

                i++;
            }

        }

        public function getFrontPageUrgentCategory(): FaqCategory
        {
            return this._categoryUrgent;
        }

        public function getFrontPageNormalCategory(): FaqCategory
        {
            return this._categoryNormal;
        }

        public function getSearchResultCategory(): FaqCategory
        {
            return this._categorySearchResults;
        }

        public function getCategoryCount(): int
        {
            return this._categories.length;
        }

        public function getCategoryByIndex(index: int): FaqCategory
        {
            if (index >= this._categories.length)
            {
                return null;
            }

            return this._categories.getWithIndex(index);
        }

        public function getCategoryTitleArray(): Array
        {
            var category: FaqCategory;
            var titles: Array = [];
            var i: int;

            while (i < this._categories.length)
            {
                category = this._categories.getWithIndex(i);

                if (category != null)
                {
                    titles.push(category.categoryTitle);
                }

                i++;
            }

            return titles;
        }

        private function findItem(id: int): FaqItem
        {
            var category: FaqCategory;

            if (this._categoryUrgent.hasItem(id))
            {
                return this._categoryUrgent.getItem(id);
            }

            if (this._categoryNormal.hasItem(id))
            {
                return this._categoryNormal.getItem(id);
            }

            if (this._categorySearchResults.hasItem(id))
            {
                return this._categorySearchResults.getItem(id);
            }

            var i: int;

            while (i < this._categories.length)
            {
                category = this._categories.getWithIndex(i);
                
                if (category.hasItem(id))
                {
                    return category.getItem(id);
                }

                i++;
            }

            return null;
        }

    }
}
