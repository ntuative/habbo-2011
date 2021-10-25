package com.sulake.habbo.friendlist.domain
{

    import com.sulake.habbo.friendlist.Util;

    public class FriendRequests
    {

        private var _deps: IFriendRequestsDeps;
        private var _requests: Array = [];
        private var _limit: int;
        private var _clubLimit: int;
        private var _vipLimit: int;

        public function FriendRequests(deps: IFriendRequestsDeps, limit: int, clubLimit: int, vipLimit: int)
        {
            this._deps = deps;
            this._limit = limit;
            this._clubLimit = clubLimit;
            this._vipLimit = vipLimit;
        }

        public function clearAndUpdateView(clearAll: Boolean): void
        {
            var request: FriendRequest;

            var removal: FriendRequest;
            var requestsToRemove: Array = [];

            for each (request in this._requests)
            {
                if (!clearAll || request.state != FriendRequest.FRIEND_STATE_PENDING)
                {
                    requestsToRemove.push(request);
                }

            }

            for each (removal in requestsToRemove)
            {
                Util.remove(this._requests, removal);

                if (this._deps.view != null)
                {
                    this._deps.view.removeRequest(removal);
                }

                removal.dispose();
            }

            this.refreshShading();
        }

        public function acceptFailed(param1: String): void
        {
            var request: FriendRequest = this.each(param1);
            
            if (request == null)
            {
                Logger.log("No friedrequest found " + param1 + " when error received");
                
                return;
            }

            request.state = FriendRequest.FRIEND_STATE_FAILED;
            this._deps.view.refreshRequestEntry(request);
        }

        public function addRequest(request: FriendRequest): void
        {
            this._requests.push(request);
        }

        public function addRequestAndUpdateView(request: FriendRequest): void
        {
            this._requests.push(request);
            this._deps.view.addRequest(request);
        }

        public function getRequest(id: int): FriendRequest
        {
            var request: FriendRequest;

            for each (request in this._requests)
            {
                if (request.requestId == id)
                {
                    return request;
                }

            }

            return null;
        }

        public function each(name: String): FriendRequest
        {
            var request: FriendRequest;

            for each (request in this._requests)
            {
                if (request.requesterName == name)
                {
                    return request;
                }

            }

            return null;
        }

        public function refreshShading(): void
        {
            var request: FriendRequest;
            var shaded: Boolean = true;

            for each (request in this._requests)
            {
                shaded = !shaded;
                this._deps.view.refreshShading(request, shaded);
            }

        }

        public function getCountOfOpenRequests(): int
        {
            var request: FriendRequest;
            var total: int;

            for each (request in this.requests)
            {
                if (request.state == FriendRequest.FRIEND_STATE_PENDING)
                {
                    total++;
                }

            }

            return total;
        }

        public function get requests(): Array
        {
            return this._requests;
        }

        public function get limit(): int
        {
            return this._limit;
        }

        public function get clubLimit(): int
        {
            return this._clubLimit;
        }

        public function get vipLimit(): int
        {
            return this._vipLimit;
        }

        public function set limit(value: int): void
        {
            this._limit = value;
        }

    }
}
