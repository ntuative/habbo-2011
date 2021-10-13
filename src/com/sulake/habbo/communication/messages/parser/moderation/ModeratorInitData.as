package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.communication.messages.incoming.moderation.OffenceCategoryData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ModeratorInitData implements IDisposable 
    {

        private var var_3239:Array;
        private var var_3241:Array;
        private var _issues:Array;
        private var var_3240:Array;
        private var var_3242:Boolean;
        private var var_3243:Boolean;
        private var var_3244:Boolean;
        private var var_3245:Boolean;
        private var var_3246:Boolean;
        private var var_3247:Boolean;
        private var var_3248:Boolean;
        private var _disposed:Boolean;

        public function ModeratorInitData(param1:IMessageDataWrapper)
        {
            var _loc2_:IssueInfoMessageParser = new IssueInfoMessageParser();
            this._issues = [];
            this.var_3239 = [];
            this.var_3241 = [];
            this.var_3240 = [];
            var _loc3_:int = param1.readInteger();
            var _loc4_:int;
            while (_loc4_ < _loc3_)
            {
                if (_loc2_.parse(param1))
                {
                    this._issues.push(_loc2_.issueData);
                };
                _loc4_++;
            };
            _loc3_ = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc3_)
            {
                this.var_3239.push(param1.readString());
                _loc4_++;
            };
            _loc3_ = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc3_)
            {
                this.var_3240.push(new OffenceCategoryData(param1));
                _loc4_++;
            };
            this.var_3242 = param1.readBoolean();
            this.var_3243 = param1.readBoolean();
            this.var_3244 = param1.readBoolean();
            this.var_3245 = param1.readBoolean();
            this.var_3246 = param1.readBoolean();
            this.var_3247 = param1.readBoolean();
            this.var_3248 = param1.readBoolean();
            _loc3_ = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc3_)
            {
                this.var_3241.push(param1.readString());
                _loc4_++;
            };
        }

        public function dispose():void
        {
            var _loc1_:OffenceCategoryData;
            if (this._disposed)
            {
                return;
            };
            this._disposed = true;
            this.var_3239 = null;
            this.var_3241 = null;
            this._issues = null;
            for each (_loc1_ in this.var_3240)
            {
                _loc1_.dispose();
            };
            this.var_3240 = null;
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get messageTemplates():Array
        {
            return (this.var_3239);
        }

        public function get roomMessageTemplates():Array
        {
            return (this.var_3241);
        }

        public function get issues():Array
        {
            return (this._issues);
        }

        public function get offenceCategories():Array
        {
            return (this.var_3240);
        }

        public function get cfhPermission():Boolean
        {
            return (this.var_3242);
        }

        public function get chatlogsPermission():Boolean
        {
            return (this.var_3243);
        }

        public function get alertPermission():Boolean
        {
            return (this.var_3244);
        }

        public function get kickPermission():Boolean
        {
            return (this.var_3245);
        }

        public function get banPermission():Boolean
        {
            return (this.var_3246);
        }

        public function get roomAlertPermission():Boolean
        {
            return (this.var_3247);
        }

        public function get roomKickPermission():Boolean
        {
            return (this.var_3248);
        }

    }
}