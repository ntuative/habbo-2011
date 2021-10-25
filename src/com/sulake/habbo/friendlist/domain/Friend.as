package com.sulake.habbo.friendlist.domain
{

    import com.sulake.habbo.friendlist.IFriend;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;

    import flash.display.BitmapData;

    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;

    public class Friend implements IFriend, IDisposable
    {

        public static const FEMALE: int = "F".charCodeAt(0);
        public static const MALE: int = "M".charCodeAt(0);

        private var _id: int;
        private var _name: String;
        private var _gender: int;
        private var _online: Boolean;
        private var _followingAllowed: Boolean;
        private var _figure: String;
        private var _motto: String;
        private var _lastAccess: String;
        private var _categoryId: int;
        private var _selected: Boolean;
        private var _disposed: Boolean;
        private var _view: IWindowContainer;
        private var _face: BitmapData;
        private var _realName: String;

        public function Friend(data: FriendData)
        {
            if (data == null)
            {
                return;
            }

            this._id = data.id;
            this._name = data.name;
            this._gender = data.gender;
            this._online = data.online;
            this._followingAllowed = data.followingAllowed && data.online;
            this._figure = data.figure;
            this._motto = data.motto;
            this._lastAccess = data.lastAccess;
            this._categoryId = data.categoryId;
            this._realName = data.realName;

            Logger.log("Creating friend: " + this.id + ", " + this.name + ", " + this.gender + ", " + this.online + ", " + this.followingAllowed + ", " + this.figure + ", " + this.categoryId);
        }

        public function dispose(): void
        {
            if (this._disposed)
            {
                return;
            }

            if (this._face != null)
            {
                this._face.dispose();
                this._face = null;
            }

            this._disposed = true;
            this._view = null;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get name(): String
        {
            return this._name;
        }

        public function get gender(): int
        {
            return this._gender;
        }

        public function get online(): Boolean
        {
            return this._online;
        }

        public function get followingAllowed(): Boolean
        {
            return this._followingAllowed;
        }

        public function get figure(): String
        {
            return this._figure;
        }

        public function get motto(): String
        {
            return this._motto;
        }

        public function get lastAccess(): String
        {
            return this._lastAccess;
        }

        public function get categoryId(): int
        {
            return this._categoryId;
        }

        public function get selected(): Boolean
        {
            return this._selected;
        }

        public function get view(): IWindowContainer
        {
            return this._view;
        }

        public function get face(): BitmapData
        {
            return this._face;
        }

        public function get realName(): String
        {
            return this._realName;
        }

        public function set id(value: int): void
        {
            this._id = value;
        }

        public function set name(value: String): void
        {
            this._name = value;
        }

        public function set gender(value: int): void
        {
            this._gender = value;
        }

        public function set online(value: Boolean): void
        {
            this._online = value;
        }

        public function set followingAllowed(value: Boolean): void
        {
            this._followingAllowed = value;
        }

        public function set figure(value: String): void
        {
            this._figure = value;
        }

        public function set motto(value: String): void
        {
            this._motto = value;
        }

        public function set lastAccess(value: String): void
        {
            this._lastAccess = value;
        }

        public function set categoryId(value: int): void
        {
            this._categoryId = value;
        }

        public function set selected(value: Boolean): void
        {
            this._selected = value;
        }

        public function set view(value: IWindowContainer): void
        {
            this._view = value;
        }

        public function set face(value: BitmapData): void
        {
            this._face = value;
        }

        public function set realName(value: String): void
        {
            this._realName = value;
        }

    }
}
