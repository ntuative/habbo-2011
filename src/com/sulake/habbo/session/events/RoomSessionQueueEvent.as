package com.sulake.habbo.session.events
{

    import com.sulake.core.utils.Map;
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionQueueEvent extends RoomSessionEvent
    {

        public static const var_393: String = "RSQE_QUEUE_STATUS";
        public static const var_1548: String = "c";
        public static const var_1549: String = "d";
        public static const var_1550: int = 2;
        public static const var_1551: int = 1;

        private var _name: String;
        private var _target: int;
        private var var_3332: Map;
        private var var_3542: Boolean;
        private var var_4409: String;

        public function RoomSessionQueueEvent(param1: IRoomSession, param2: String, param3: int, param4: Boolean = false, param5: Boolean = false, param6: Boolean = false)
        {
            super(var_393, param1, param5, param6);
            this._name = param2;
            this._target = param3;
            this.var_3332 = new Map();
            this.var_3542 = param4;
        }

        public function get isActive(): Boolean
        {
            return this.var_3542;
        }

        public function get queueSetName(): String
        {
            return this._name;
        }

        public function get queueSetTarget(): int
        {
            return this._target;
        }

        public function get queueTypes(): Array
        {
            return this.var_3332.getKeys();
        }

        public function getQueueSize(param1: String): int
        {
            return this.var_3332.getValue(param1);
        }

        public function addQueue(param1: String, param2: int): void
        {
            this.var_3332.add(param1, param2);
        }

    }
}
