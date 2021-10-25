package com.sulake.habbo.communication.messages.parser.room.session
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomQueueStatusMessageParser implements IMessageParser
    {

        private var _roomId: int = 0;
        private var _roomCategory: int = 0;
        private var _queueSets: Map = new Map();
        private var _activeTarget: int = 0;

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomCategory(): int
        {
            return this._roomCategory;
        }

        public function get activeTarget(): int
        {
            return this._activeTarget;
        }

        public function flush(): Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._queueSets.reset();

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            var queueCount: int;
            var roomQueue: RoomQueueSet;
            var name: String;
            var target: int;
            var j: int;
            this._queueSets.reset();

            var queueSetCount: int = data.readInteger();
            var i: int;
            
            while (i < queueSetCount)
            {
                name = data.readString();
                target = data.readInteger();

                if (i == 0)
                {
                    this._activeTarget = target;
                }

                roomQueue = new RoomQueueSet(name, target);

                queueCount = data.readInteger();
                j = 0;

                while (j < queueCount)
                {
                    roomQueue.addQueue(data.readString(), data.readInteger());
                    j++;
                }

                this._queueSets.add(roomQueue.target, roomQueue);

                i++;
            }

            return true;
        }

        public function getQueueSetTargets(): Array
        {
            return this._queueSets.getKeys();
        }

        public function getQueueSet(param1: int): RoomQueueSet
        {
            return this._queueSets.getValue(param1) as RoomQueueSet;
        }

    }
}
