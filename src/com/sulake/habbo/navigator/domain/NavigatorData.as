package com.sulake.habbo.navigator.domain
{

    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.habbo.communication.messages.incoming.navigator.MsgWithRequestId;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventData;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.habbo.communication.messages.incoming.navigator.PublicRoomShortData;

    import flash.utils.Dictionary;

    import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.PopularRoomTagsData;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultData;
    import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomsData;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
    import com.sulake.habbo.communication.messages.parser.navigator.FavouritesMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.*;
    import com.sulake.habbo.navigator.*;
    import com.sulake.habbo.communication.messages.parser.navigator.*;

    public class NavigatorData
    {

        private static const UNKNOWN_1: int = 10;

        private var _navigator: HabboNavigator;
        private var _messageData: MsgWithRequestId;
        private var _roomEventData: RoomEventData;
        private var _eventMod: Boolean;
        private var _roomPicker: Boolean;
        private var _currentRoomOwner: Boolean;
        private var _avatarId: int;
        private var _enteredGuestRoom: GuestRoomData;
        private var _enteredPublicSpace: PublicRoomShortData;
        private var _publicSpaceNodeId: int;
        private var _hcMember: Boolean;
        private var _createdFlatId: int;
        private var _hotRoomPopupOpen: Boolean;
        private var _homeRoomId: int;
        private var _settingsReceived: Boolean;
        private var _allCategories: Array = [];
        private var _visibleCategories: Array = [];
        private var _maximumFavourites: int;
        private var _favouritesLength: int;
        private var _favouriteIds: Dictionary = new Dictionary();
        private var _loading: Boolean;
        private var _currentRoomRating: int;
        private var _currentRoomIsStaffPick: Boolean;
        private var _adIndex: int = 0;

        public function NavigatorData(navigator: HabboNavigator)
        {
            this._navigator = navigator;
        }

        public function get canAddFavourite(): Boolean
        {
            return this._enteredGuestRoom != null && !this._currentRoomOwner;
        }

        public function get canEditRoomSettings(): Boolean
        {
            return this._enteredGuestRoom != null && this._currentRoomOwner;
        }

        public function onRoomEnter(parser: RoomEntryInfoMessageParser): void
        {
            this._enteredPublicSpace = null;
            this._enteredGuestRoom = null;
            this._currentRoomOwner = false;

            if (parser.guestRoom)
            {
                this._currentRoomOwner = parser.owner;
            }
            else
            {
                this._enteredPublicSpace = parser.publicSpace;
                this._roomEventData = null;
            }

        }

        public function onRoomExit(): void
        {
            if (this._roomEventData != null)
            {
                this._roomEventData.dispose();
                this._roomEventData = null;
            }

            if (this._enteredPublicSpace != null)
            {
                this._enteredPublicSpace.dispose();
                this._enteredPublicSpace = null;
            }

            if (this._enteredGuestRoom != null)
            {
                this._enteredGuestRoom.dispose();
                this._enteredGuestRoom = null;
            }

            this._currentRoomOwner = false;
        }

        public function set enteredRoom(data: GuestRoomData): void
        {
            if (this._enteredGuestRoom != null)
            {
                this._enteredGuestRoom.dispose();
            }

            this._enteredGuestRoom = data;
        }

        public function set roomEventData(data: RoomEventData): void
        {
            if (this._roomEventData != null)
            {
                this._roomEventData.dispose();
            }

            this._roomEventData = data;
        }

        public function get popularTagsArrived(): Boolean
        {
            return this._messageData != null && (this._messageData as PopularRoomTagsData) != null;
        }

        public function get guestRoomSearchArrived(): Boolean
        {
            return this._messageData != null && (this._messageData as GuestRoomSearchResultData) != null;
        }

        public function get officialRoomsArrived(): Boolean
        {
            return this._messageData != null && (this._messageData as OfficialRoomsData) != null;
        }

        public function set guestRoomSearchResults(data: GuestRoomSearchResultData): void
        {
            this.disposeCurrentMsg();
            this._messageData = data;
            this._loading = false;
        }

        public function set popularTags(data: PopularRoomTagsData): void
        {
            this.disposeCurrentMsg();
            this._messageData = data;
            this._loading = false;
        }

        public function set officialRooms(data: OfficialRoomsData): void
        {
            this.disposeCurrentMsg();
            this._messageData = data;
            this._loading = false;
        }

        private function disposeCurrentMsg(): void
        {
            if (this._messageData == null)
            {
                return;
            }

            this._messageData.dispose();
            this._messageData = null;
        }

        public function get guestRoomSearchResults(): GuestRoomSearchResultData
        {
            return this._messageData as GuestRoomSearchResultData;
        }

        public function get popularTags(): PopularRoomTagsData
        {
            return this._messageData as PopularRoomTagsData;
        }

        public function get officialRooms(): OfficialRoomsData
        {
            return this._messageData as OfficialRoomsData;
        }

        public function get roomEventData(): RoomEventData
        {
            return this._roomEventData;
        }

        public function get avatarId(): int
        {
            return this._avatarId;
        }

        public function get eventMod(): Boolean
        {
            return this._eventMod;
        }

        public function get roomPicker(): Boolean
        {
            return this._roomPicker;
        }

        public function get currentRoomOwner(): Boolean
        {
            return this._currentRoomOwner;
        }

        public function get enteredGuestRoom(): GuestRoomData
        {
            return this._enteredGuestRoom;
        }

        public function get enteredPublicSpace(): PublicRoomShortData
        {
            return this._enteredPublicSpace;
        }

        public function get hcMember(): Boolean
        {
            return this._hcMember;
        }

        public function get createdFlatId(): int
        {
            return this._createdFlatId;
        }

        public function get homeRoomId(): int
        {
            return this._homeRoomId;
        }

        public function get hotRoomPopupOpen(): Boolean
        {
            return this._hotRoomPopupOpen;
        }

        public function get currentRoomRating(): int
        {
            return this._currentRoomRating;
        }

        public function get publicSpaceNodeId(): int
        {
            return this._publicSpaceNodeId;
        }

        public function get settingsReceived(): Boolean
        {
            return this._settingsReceived;
        }

        public function get adIndex(): int
        {
            return this._adIndex;
        }

        public function get currentRoomIsStaffPick(): Boolean
        {
            return this._currentRoomIsStaffPick;
        }

        public function set avatarId(value: int): void
        {
            this._avatarId = value;
        }

        public function set createdFlatId(value: int): void
        {
            this._createdFlatId = value;
        }

        public function set hcMember(value: Boolean): void
        {
            this._hcMember = value;
        }

        public function set eventMod(value: Boolean): void
        {
            this._eventMod = value;
        }

        public function set roomPicker(value: Boolean): void
        {
            this._roomPicker = value;
        }

        public function set hotRoomPopupOpen(value: Boolean): void
        {
            this._hotRoomPopupOpen = value;
        }

        public function set homeRoomId(value: int): void
        {
            this._homeRoomId = value;
        }

        public function set currentRoomRating(value: int): void
        {
            this._currentRoomRating = value;
        }

        public function set publicSpaceNodeId(value: int): void
        {
            this._publicSpaceNodeId = value;
        }

        public function set settingsReceived(value: Boolean): void
        {
            this._settingsReceived = value;
        }

        public function set adIndex(value: int): void
        {
            this._adIndex = value;
        }

        public function set currentRoomIsStaffPick(value: Boolean): void
        {
            this._currentRoomIsStaffPick = value;
        }

        public function set categories(cats: Array): void
        {
            this._allCategories = cats;
            this._visibleCategories = [];
            
            var category: FlatCategory;
            
            for each (category in this._allCategories)
            {
                if (category.visible)
                {
                    this._visibleCategories.push(category);
                }

            }

        }

        public function get allCategories(): Array
        {
            return this._allCategories;
        }

        public function get visibleCategories(): Array
        {
            return this._visibleCategories;
        }

        public function onFavourites(parser: FavouritesMessageParser): void
        {
            this._maximumFavourites = parser.limit;
            this._favouritesLength = parser.favouriteRoomIds.length;
            this._favouriteIds = new Dictionary();
            
            var id: int;

            for each (id in parser.favouriteRoomIds)
            {
                this._favouriteIds[id] = "yes";
            }

        }

        public function favouriteChanged(id: int, favourite: Boolean): void
        {
            this._favouriteIds[id] = favourite ? "yes" : null;
            this._favouritesLength = this._favouritesLength + (favourite ? 1 : -1);
        }

        public function isCurrentRoomFavourite(): Boolean
        {
            var id: int = this._enteredGuestRoom.flatId;

            return this._favouriteIds[id] != null;
        }

        public function isCurrentRoomHome(): Boolean
        {
            if (this._enteredGuestRoom == null)
            {
                return false;
            }

            var id: int = this._enteredGuestRoom.flatId;

            return this._homeRoomId == id;
        }

        public function isRoomFavourite(id: int): Boolean
        {
            return this._favouriteIds[id] != null;
        }

        public function isFavouritesFull(): Boolean
        {
            return this._favouritesLength >= this._maximumFavourites;
        }

        public function startLoading(): void
        {
            this._loading = true;
        }

        public function isLoading(): Boolean
        {
            return this._loading;
        }

    }
}
