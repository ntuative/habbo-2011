package com.sulake.habbo.help.help.data
{

    public class FaqItem
    {

        private var _questionId: int;
        private var _questionText: String;
        private var _answerText: String;
        private var _index: int;
        private var _category: FaqCategory;
        private var _hasAnswer: Boolean = false;

        public function FaqItem(questionId: int, questionText: String, index: int, category: FaqCategory)
        {
            this._questionId = questionId;
            this._questionText = questionText;
            this._index = index;
            this._category = category;
        }

        public function get questionId(): int
        {
            return this._questionId;
        }

        public function get questionText(): String
        {
            return this._questionText;
        }

        public function get answerText(): String
        {
            return this._answerText;
        }

        public function get hasAnswer(): Boolean
        {
            return this._hasAnswer;
        }

        public function get index(): int
        {
            return this._index;
        }

        public function get category(): FaqCategory
        {
            return this._category;
        }

        public function set answerText(value: String): void
        {
            this._answerText = value;
            this._hasAnswer = true;
        }

    }
}
