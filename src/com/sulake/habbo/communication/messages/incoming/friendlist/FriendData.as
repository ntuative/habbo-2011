package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FriendData 
    {

        private var _id:int;
        private var _name:String;
        private var var_2071:int;
        private var var_2908:Boolean;
        private var var_2909:Boolean;
        private var var_2534:String;
        private var var_2465:int;
        private var var_2910:String;
        private var var_2911:String;
        private var var_2912:String;

        public function FriendData(param1:IMessageDataWrapper)
        {
            this._id = param1.readInteger();
            this._name = param1.readString();
            this.var_2071 = param1.readInteger();
            this.var_2908 = param1.readBoolean();
            this.var_2909 = param1.readBoolean();
            this.var_2534 = param1.readString();
            this.var_2465 = param1.readInteger();
            this.var_2910 = param1.readString();
            this.var_2911 = param1.readString();
            this.var_2912 = param1.readString();
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get gender():int
        {
            return (this.var_2071);
        }

        public function get online():Boolean
        {
            return (this.var_2908);
        }

        public function get followingAllowed():Boolean
        {
            return (this.var_2909);
        }

        public function get figure():String
        {
            return (this.var_2534);
        }

        public function get categoryId():int
        {
            return (this.var_2465);
        }

        public function get motto():String
        {
            return (this.var_2910);
        }

        public function get lastAccess():String
        {
            return (this.var_2911);
        }

        public function get realName():String
        {
            return (this.var_2912);
        }

    }
}