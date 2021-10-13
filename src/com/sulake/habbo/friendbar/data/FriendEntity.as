package com.sulake.habbo.friendbar.data
{
    public class FriendEntity implements IFriendEntity 
    {

        private var _id:int;
        private var _name:String;
        private var var_2071:int;
        private var var_2908:Boolean;
        private var var_3379:Boolean;
        private var var_2534:String;
        private var var_2465:int;
        private var var_2910:String;
        private var var_2911:String;
        private var var_2912:String;

        public function FriendEntity(param1:int, param2:String, param3:String, param4:String, param5:int, param6:Boolean, param7:Boolean, param8:String, param9:int, param10:String)
        {
            this._id = param1;
            this._name = param2;
            this.var_2912 = param3;
            this.var_2910 = param4;
            this.var_2071 = param5;
            this.var_2908 = param6;
            this.var_3379 = param7;
            this.var_2534 = param8;
            this.var_2465 = param9;
            this.var_2911 = param10;
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

        public function get allowFollow():Boolean
        {
            return (this.var_3379);
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

        public function set name(param1:String):void
        {
            this._name = param1;
        }

        public function set gender(param1:int):void
        {
            this.var_2071 = param1;
        }

        public function set online(param1:Boolean):void
        {
            this.var_2908 = param1;
        }

        public function set allowFollow(param1:Boolean):void
        {
            this.var_3379 = param1;
        }

        public function set figure(param1:String):void
        {
            this.var_2534 = param1;
        }

        public function set categoryId(param1:int):void
        {
            this.var_2465 = param1;
        }

        public function set motto(param1:String):void
        {
            this.var_2910 = param1;
        }

        public function set lastAccess(param1:String):void
        {
            this.var_2911 = param1;
        }

        public function set realName(param1:String):void
        {
            this.var_2912 = param1;
        }

    }
}