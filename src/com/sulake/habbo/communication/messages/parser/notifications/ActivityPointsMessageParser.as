package com.sulake.habbo.communication.messages.parser.notifications
{

    import com.sulake.core.communication.messages.IMessageParser;

    import flash.utils.Dictionary;

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ActivityPointsMessageParser implements IMessageParser
    {

        private var _points: Dictionary;

        public function flush(): Boolean
        {
            this._points = new Dictionary();

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            var id: int;
            var balance: int;
            
            var activityPointCount: int = data.readInteger();
            var i: int;

            while (i < activityPointCount)
            {
                id = data.readInteger();
                balance = data.readInteger();
                
                this._points[id] = balance;
                i++;
            }

            return true;
        }

        public function get points(): Dictionary
        {
            return this._points;
        }

    }
}
