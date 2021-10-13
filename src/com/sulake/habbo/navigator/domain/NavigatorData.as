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

        private static const var_3719:int = 10;

        private var _navigator:HabboNavigator;
        private var var_3720:MsgWithRequestId;
        private var var_3721:RoomEventData;
        private var var_3722:Boolean;
        private var var_3723:Boolean;
        private var _currentRoomOwner:Boolean;
        private var var_2916:int;
        private var var_3724:GuestRoomData;
        private var var_3725:PublicRoomShortData;
        private var var_3726:int;
        private var var_3727:Boolean;
        private var var_3728:int;
        private var var_3729:Boolean;
        private var var_3257:int;
        private var var_3730:Boolean;
        private var var_2558:Array = new Array();
        private var var_3731:Array = new Array();
        private var var_3732:int;
        private var var_3733:int;
        private var _favouriteIds:Dictionary = new Dictionary();
        private var var_3734:Boolean;
        private var var_3735:int;
        private var var_3736:Boolean;
        private var var_3737:int = 0;

        public function NavigatorData(param1:HabboNavigator)
        {
            this._navigator = param1;
        }

        public function get canAddFavourite():Boolean
        {
            return ((!(this.var_3724 == null)) && (!(this._currentRoomOwner)));
        }

        public function get canEditRoomSettings():Boolean
        {
            return ((!(this.var_3724 == null)) && (this._currentRoomOwner));
        }

        public function onRoomEnter(param1:RoomEntryInfoMessageParser):void
        {
            this.var_3725 = null;
            this.var_3724 = null;
            this._currentRoomOwner = false;
            if (param1.guestRoom)
            {
                this._currentRoomOwner = param1.owner;
            }
            else
            {
                this.var_3725 = param1.publicSpace;
                this.var_3721 = null;
            };
        }

        public function onRoomExit():void
        {
            if (this.var_3721 != null)
            {
                this.var_3721.dispose();
                this.var_3721 = null;
            };
            if (this.var_3725 != null)
            {
                this.var_3725.dispose();
                this.var_3725 = null;
            };
            if (this.var_3724 != null)
            {
                this.var_3724.dispose();
                this.var_3724 = null;
            };
            this._currentRoomOwner = false;
        }

        public function set enteredRoom(param1:GuestRoomData):void
        {
            if (this.var_3724 != null)
            {
                this.var_3724.dispose();
            };
            this.var_3724 = param1;
        }

        public function set roomEventData(param1:RoomEventData):void
        {
            if (this.var_3721 != null)
            {
                this.var_3721.dispose();
            };
            this.var_3721 = param1;
        }

        public function get popularTagsArrived():Boolean
        {
            return ((!(this.var_3720 == null)) && (!((this.var_3720 as PopularRoomTagsData) == null)));
        }

        public function get guestRoomSearchArrived():Boolean
        {
            return ((!(this.var_3720 == null)) && (!((this.var_3720 as GuestRoomSearchResultData) == null)));
        }

        public function get officialRoomsArrived():Boolean
        {
            return ((!(this.var_3720 == null)) && (!((this.var_3720 as OfficialRoomsData) == null)));
        }

        public function set guestRoomSearchResults(param1:GuestRoomSearchResultData):void
        {
            this.disposeCurrentMsg();
            this.var_3720 = param1;
            this.var_3734 = false;
        }

        public function set popularTags(param1:PopularRoomTagsData):void
        {
            this.disposeCurrentMsg();
            this.var_3720 = param1;
            this.var_3734 = false;
        }

        public function set officialRooms(param1:OfficialRoomsData):void
        {
            this.disposeCurrentMsg();
            this.var_3720 = param1;
            this.var_3734 = false;
        }

        private function disposeCurrentMsg():void
        {
            if (this.var_3720 == null)
            {
                return;
            };
            this.var_3720.dispose();
            this.var_3720 = null;
        }

        public function get guestRoomSearchResults():GuestRoomSearchResultData
        {
            return (this.var_3720 as GuestRoomSearchResultData);
        }

        public function get popularTags():PopularRoomTagsData
        {
            return (this.var_3720 as PopularRoomTagsData);
        }

        public function get officialRooms():OfficialRoomsData
        {
            return (this.var_3720 as OfficialRoomsData);
        }

        public function get roomEventData():RoomEventData
        {
            return (this.var_3721);
        }

        public function get avatarId():int
        {
            return (this.var_2916);
        }

        public function get eventMod():Boolean
        {
            return (this.var_3722);
        }

        public function get roomPicker():Boolean
        {
            return (this.var_3723);
        }

        public function get currentRoomOwner():Boolean
        {
            return (this._currentRoomOwner);
        }

        public function get enteredGuestRoom():GuestRoomData
        {
            return (this.var_3724);
        }

        public function get enteredPublicSpace():PublicRoomShortData
        {
            return (this.var_3725);
        }

        public function get hcMember():Boolean
        {
            return (this.var_3727);
        }

        public function get createdFlatId():int
        {
            return (this.var_3728);
        }

        public function get homeRoomId():int
        {
            return (this.var_3257);
        }

        public function get hotRoomPopupOpen():Boolean
        {
            return (this.var_3729);
        }

        public function get currentRoomRating():int
        {
            return (this.var_3735);
        }

        public function get publicSpaceNodeId():int
        {
            return (this.var_3726);
        }

        public function get settingsReceived():Boolean
        {
            return (this.var_3730);
        }

        public function get adIndex():int
        {
            return (this.var_3737);
        }

        public function get currentRoomIsStaffPick():Boolean
        {
            return (this.var_3736);
        }

        public function set avatarId(param1:int):void
        {
            this.var_2916 = param1;
        }

        public function set createdFlatId(param1:int):void
        {
            this.var_3728 = param1;
        }

        public function set hcMember(param1:Boolean):void
        {
            this.var_3727 = param1;
        }

        public function set eventMod(param1:Boolean):void
        {
            this.var_3722 = param1;
        }

        public function set roomPicker(param1:Boolean):void
        {
            this.var_3723 = param1;
        }

        public function set hotRoomPopupOpen(param1:Boolean):void
        {
            this.var_3729 = param1;
        }

        public function set homeRoomId(param1:int):void
        {
            this.var_3257 = param1;
        }

        public function set currentRoomRating(param1:int):void
        {
            this.var_3735 = param1;
        }

        public function set publicSpaceNodeId(param1:int):void
        {
            this.var_3726 = param1;
        }

        public function set settingsReceived(param1:Boolean):void
        {
            this.var_3730 = param1;
        }

        public function set adIndex(param1:int):void
        {
            this.var_3737 = param1;
        }

        public function set currentRoomIsStaffPick(param1:Boolean):void
        {
            this.var_3736 = param1;
        }

        public function set categories(param1:Array):void
        {
            var _loc2_:FlatCategory;
            this.var_2558 = param1;
            this.var_3731 = new Array();
            for each (_loc2_ in this.var_2558)
            {
                if (_loc2_.visible)
                {
                    this.var_3731.push(_loc2_);
                };
            };
        }

        public function get allCategories():Array
        {
            return (this.var_2558);
        }

        public function get visibleCategories():Array
        {
            return (this.var_3731);
        }

        public function onFavourites(param1:FavouritesMessageParser):void
        {
            var _loc2_:int;
            this.var_3732 = param1.limit;
            this.var_3733 = param1.favouriteRoomIds.length;
            this._favouriteIds = new Dictionary();
            for each (_loc2_ in param1.favouriteRoomIds)
            {
                this._favouriteIds[_loc2_] = "yes";
            };
        }

        public function favouriteChanged(param1:int, param2:Boolean):void
        {
            this._favouriteIds[param1] = ((param2) ? "yes" : null);
            this.var_3733 = (this.var_3733 + ((param2) ? 1 : -1));
        }

        public function isCurrentRoomFavourite():Boolean
        {
            var _loc1_:int = this.var_3724.flatId;
            return (!(this._favouriteIds[_loc1_] == null));
        }

        public function isCurrentRoomHome():Boolean
        {
            if (this.var_3724 == null)
            {
                return (false);
            };
            var _loc1_:int = this.var_3724.flatId;
            return (this.var_3257 == _loc1_);
        }

        public function isRoomFavourite(param1:int):Boolean
        {
            return (!(this._favouriteIds[param1] == null));
        }

        public function isFavouritesFull():Boolean
        {
            return (this.var_3733 >= this.var_3732);
        }

        public function startLoading():void
        {
            this.var_3734 = true;
        }

        public function isLoading():Boolean
        {
            return (this.var_3734);
        }

    }
}