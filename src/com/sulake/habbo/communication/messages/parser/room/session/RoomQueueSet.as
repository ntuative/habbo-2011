package com.sulake.habbo.communication.messages.parser.room.session
{

    import com.sulake.core.utils.Map;

    public class RoomQueueSet
    {

        private var _name: String;
        private var _target: int;
        private var _queues: Map;

        public function RoomQueueSet(name: String, target: int)
        {
            this._name = name;
            this._target = target;
            this._queues = new Map();
        }

        public function get name(): String
        {
            return this._name;
        }

        public function get target(): int
        {
            return this._target;
        }

        public function get queueTypes(): Array
        {
            return this._queues.getKeys();
        }

        public function getQueueSize(param1: String): int
        {
            return this._queues.getValue(param1);
        }

        public function addQueue(param1: String, param2: int): void
        {
            this._queues.add(param1, param2);
        }

    }
}
