package com.sulake.habbo.friendbar.data
{

    import com.sulake.core.runtime.IUnknown;

    import flash.events.IEventDispatcher;

    public interface IHabboFriendBarData extends IUnknown
    {

        function get events(): IEventDispatcher;

        function get numFriends(): int;

        function getFriendAt(param1: int): IFriendEntity;

        function getFriendByID(param1: int): IFriendEntity;

        function getFriendByName(param1: String): IFriendEntity;

        function followToRoom(param1: int): void;

        function startConversation(param1: int): void;

        function findNewFriends(): void;

    }
}
