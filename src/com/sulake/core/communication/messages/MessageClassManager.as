package com.sulake.core.communication.messages
{
    import flash.utils.Dictionary;
    import flash.utils.describeType;
    import flash.events.*;
    import flash.xml.*;

    public class MessageClassManager implements IMessageClassManager 
    {

        private var var_2149:Dictionary;
        private var var_2150:Dictionary;
        private var _messageComposerInterface:String = "com.sulake.core.communication.messages::IMessageComposer";
        private var _messageEventInterface:String = "com.sulake.core.communication.messages::IMessageEvent";

        public function MessageClassManager()
        {
            this.var_2149 = new Dictionary();
            this.var_2150 = new Dictionary();
        }

        public function registerMessages(param1:IMessageConfiguration):Boolean
        {
            var _loc2_:String;
            for (_loc2_ in param1.events)
            {
                this.registerMessageEvent(parseInt(_loc2_), param1.events[_loc2_]);
            };
            for (_loc2_ in param1.composers)
            {
                this.registerMessageComposer(parseInt(_loc2_), param1.composers[_loc2_]);
            };
            return (true);
        }

        private function registerMessageComposer(param1:int, param2:Class):Boolean
        {
            var _loc5_:XML;
            var _loc3_:XML = describeType(param2);
            var _loc4_:Boolean;
            for each (_loc5_ in _loc3_..implementsInterface)
            {
                if (_loc5_.@type == this._messageComposerInterface)
                {
                    _loc4_ = true;
                    break;
                };
            };
            if (_loc4_)
            {
                this.var_2149[param1] = param2;
                return (true);
            };
            throw (new Error((("Invalid Message Composer class defined for message id: " + param1) + "!")));
        }

        private function registerMessageEvent(param1:int, param2:Class):Boolean
        {
            var _loc5_:String;
            var _loc6_:Array;
            var _loc3_:XML = describeType(param2);
            var _loc4_:Boolean = true;
            if (_loc3_..implementsInterface.@type != this._messageEventInterface)
            {
                throw (new Error(((("Invalid Message Event class defined for message id: " + param1) + "! Implements: ") + _loc3_..implementsInterface.@type)));
            };
            if (_loc4_)
            {
                _loc5_ = _loc3_.@name;
                if (this.var_2150[param1] == null)
                {
                    this.var_2150[param1] = [param2];
                }
                else
                {
                    _loc6_ = this.var_2150[param1];
                    _loc6_.push(param2);
                };
            };
            return (_loc4_);
        }

        public function getMessageComposerID(param1:IMessageComposer):int
        {
            var _loc3_:String;
            var _loc4_:Class;
            var _loc2_:int = -1;
            for (_loc3_ in this.var_2149)
            {
                _loc4_ = (this.var_2149[_loc3_] as Class);
                if ((param1 is _loc4_))
                {
                    _loc2_ = parseInt(_loc3_);
                    break;
                };
            };
            return (_loc2_);
        }

        public function getMessageEventClasses(param1:int):Array
        {
            var _loc2_:Array = this.var_2150[param1];
            if (_loc2_ != null)
            {
                return (_loc2_);
            };
            return ([]);
        }

        public function toString():String
        {
            var _loc1_:String = "";
            var _loc2_:String = "";
            _loc1_ = (_loc1_ + "Registered Message Composer Classes: \n");
            for (_loc2_ in this.var_2149)
            {
                _loc1_ = (_loc1_ + (((_loc2_ + " -> ") + this.var_2149[_loc2_]) + "\n"));
            };
            _loc1_ = (_loc1_ + "Registered Message Event Classes: \n");
            for (_loc2_ in this.var_2150)
            {
                _loc1_ = (_loc1_ + (((_loc2_ + " -> ") + this.var_2150[_loc2_]) + "\n"));
            };
            return (_loc1_);
        }

    }
}