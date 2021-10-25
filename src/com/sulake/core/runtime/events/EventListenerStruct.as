package com.sulake.core.runtime.events
{

    import flash.utils.Dictionary;

    public class EventListenerStruct
    {

        private var _callbacks: Dictionary;
        public var captures: Boolean;
        public var priority: int;
        public var useWeakRef: Boolean;

        public function EventListenerStruct(callback: Function, captures: Boolean = false, priority: int = 0, useWeakRef: Boolean = false)
        {
            this._callbacks = new Dictionary(useWeakRef);
            this.callback = callback;
            this.captures = captures;
            this.priority = priority;
            this.useWeakRef = useWeakRef;
        }

        public function set callback(cb: Function): void
        {
            var item: Object;

            for (item in this._callbacks)
            {
                this._callbacks[item] = null;
            }


            this._callbacks[cb] = null;
        }

        public function get callback(): Function
        {
            var item: Object;
            for (item in this._callbacks)
            {
                if (item != null)
                {
                    return item as Function;
                }
            }


            return null;
        }

    }
}
