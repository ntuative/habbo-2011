package com.sulake.habbo.friendlist
{

    import com.sulake.core.runtime.IUnknown;

    import flash.events.IEventDispatcher;
    import flash.utils.Dictionary;

    public interface IHabboFriendList extends IUnknown
    {

        function get events(): IEventDispatcher;

        function canBeAskedForAFriend(param1: int): Boolean;

        function askForAFriend(param1: int, param2: String): Boolean;

        function getFriend(param1: int): IFriend;

        function openFriendList(): void;

        function getFriendCount(param1: Boolean, param2: Boolean): int;

        function openHabboWebPage(param1: String, param2: Dictionary, param3: int, param4: int): void;

        function getFriendNames(): Array;

        function acceptFriendRequest(param1: int): void;

        function declineFriendRequest(param1: int): void;

    }
}
