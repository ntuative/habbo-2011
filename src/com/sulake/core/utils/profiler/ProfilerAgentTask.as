package com.sulake.core.utils.profiler
{

    import com.sulake.core.runtime.IDisposable;

    import flash.utils.getTimer;

    public class ProfilerAgentTask implements IDisposable
    {

        private var _name: String;
        private var _rounds: uint;
        private var _total: int;
        private var _latest: int;
        private var _average: Number;
        private var _caption: String;
        private var _running: Boolean;
        private var _disposed: Boolean = false;
        private var _children: Array;
        private var _lastUpdateMs: uint;

        public function ProfilerAgentTask(name: String, caption: String = "")
        {
            this._name = name;
            this._rounds = 0;
            this._average = 0;
            this._running = false;
            this._children = [];
            this._caption = caption;
        }

        public function dispose(): void
        {
            if (!this._disposed)
            {
                this._disposed = true;
            }

        }

        public function start(): void
        {
            if (!this._running)
            {
                this._lastUpdateMs = getTimer();
                this._running = true;
            }

        }

        public function stop(): void
        {
            if (this._running)
            {
                this._latest = getTimer() - this._lastUpdateMs;
                this._rounds++;
                this._total = this._total + this._latest;
                this._average = this._total / this._rounds;
                this._running = false;
            }

        }

        public function get name(): String
        {
            return this._name;
        }

        public function get rounds(): uint
        {
            return this._rounds;
        }

        public function get total(): int
        {
            return this._total;
        }

        public function get latest(): int
        {
            return this._latest;
        }

        public function get average(): Number
        {
            return this._average;
        }

        public function get caption(): String
        {
            return this._caption;
        }

        public function set caption(caption: String): void
        {
            this._caption = this.caption;
        }

        public function get running(): Boolean
        {
            return this._running;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get numSubTasks(): uint
        {
            return this._children.length;
        }

        public function addSubTask(param1: ProfilerAgentTask): void
        {
            if (this.getSubTaskByName(param1.name) != null)
            {
                throw new Error("Component profiler task with name \"" + param1.name + "\" already exists!");
            }

            this._children.push(param1);
        }

        public function removeSubTask(param1: ProfilerAgentTask): ProfilerAgentTask
        {
            var _loc2_: int = this._children.indexOf(param1);
            if (_loc2_ > -1)
            {
                this._children.splice(_loc2_, 1);
            }

            return param1;
        }

        public function getSubTaskAt(param1: uint): ProfilerAgentTask
        {
            return this._children[param1] as ProfilerAgentTask;
        }

        public function getSubTaskByName(param1: String): ProfilerAgentTask
        {
            var _loc4_: ProfilerAgentTask;
            var _loc2_: uint = this._children.length;
            var _loc3_: uint;
            while (_loc3_ < _loc2_)
            {
                _loc4_ = (this._children[_loc3_++] as ProfilerAgentTask);
                if (_loc4_.name == param1)
                {
                    return _loc4_;
                }

            }

            return null;
        }

    }
}
