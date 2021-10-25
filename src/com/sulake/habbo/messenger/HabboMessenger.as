package com.sulake.habbo.messenger
{

    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.messenger.domain.Conversations;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.sound.IHabboSoundManager;

    import iid.IIDHabboWindowManager;

    import com.sulake.iid.IIDHabboSoundManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboFriendList;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.habbo.messenger.domain.Conversation;
    import com.sulake.habbo.friendlist.IFriend;

    import flash.display.BitmapData;

    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.sound.HabboSoundTypesEnum;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.events.WindowMouseEvent;

    import flash.utils.Dictionary;

    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.communication.messages.incoming.friendlist.MessengerInitEvent;
    import com.sulake.habbo.messenger.domain.ConversationsDeps;
    import com.sulake.habbo.communication.messages.incoming.friendlist.NewConsoleMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.RoomInviteEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.InstantMessageErrorEvent;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.toolbar.events.HabboToolbarSetIconEvent;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import com.sulake.habbo.communication.messages.parser.friendlist.NewConsoleMessageMessageParser;
    import com.sulake.habbo.messenger.domain.Message;
    import com.sulake.habbo.communication.messages.parser.friendlist.RoomInviteMessageParser;
    import com.sulake.habbo.communication.messages.parser.friendlist.InstantMessageErrorMessageParser;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.*;
    import com.sulake.habbo.messenger.domain.*;

    import iid.*;

    public class HabboMessenger extends Component implements IHabboMessenger, IAvatarImageListener
    {

        public static const var_304: String = "face";

        private var _windowManager: IHabboWindowManager;
        private var _communication: IHabboCommunicationManager;
        private var _configuration: IHabboConfigurationManager;
        private var _localization: IHabboLocalizationManager;
        private var _friendList: IHabboFriendList;
        private var _avatarRenderer: IAvatarRenderManager;
        private var _conversations: Conversations;
        private var _messengerView: MessengerView;
        private var _toolbar: IHabboToolbar;
        private var _soundManager: IHabboSoundManager;

        public function HabboMessenger(ctx: IContext, flags: uint = 0, assets: IAssetLibrary = null)
        {
            super(ctx, flags, assets);

            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDHabboSoundManager(), this.onSoundManagerReady);
        }

        override public function dispose(): void
        {
            if (this._soundManager)
            {
                this._soundManager.release(new IIDHabboSoundManager());
                this._soundManager = null;
            }

            if (this._windowManager)
            {
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            }

            if (this._communication)
            {
                this._communication.release(new IIDHabboCommunicationManager());
                this._communication = null;
            }

            if (this._configuration)
            {
                this._configuration.release(new IIDHabboConfigurationManager());
                this._configuration = null;
            }

            if (this._localization)
            {
                this._localization.release(new IIDHabboLocalizationManager());
                this._localization = null;
            }

            if (this._friendList)
            {
                this._friendList.release(new IIDHabboFriendList());
                this._friendList = null;
            }

            if (this._avatarRenderer)
            {
                this._avatarRenderer.release(new IIDAvatarRenderManager());
                this._avatarRenderer = null;
            }

            if (this._toolbar)
            {
                this._toolbar.release(new IIDHabboToolbar());
                this._toolbar = null;
            }

            if (this._messengerView)
            {
                this._messengerView.dispose();
                this._messengerView = null;
            }

            super.dispose();
        }

        public function startConversation(id: int): void
        {
            var conversation: Conversation = this._conversations.addConversation(id);

            if (conversation == null)
            {
                Logger.log("No friend " + id + " found. Shouldn't happen");
            }
            else
            {
                this.setHabboToolbarIcon(true, false);
                this._conversations.setSelected(conversation);
                this._messengerView.openMessenger();
                this._messengerView.refresh();
            }

        }

        public function setFollowingAllowed(id: int, param2: Boolean): void
        {
            this._conversations.setFollowingAllowedAndUpdateView(id, param2);
        }

        public function setOnlineStatus(param1: int, param2: Boolean): void
        {
            this._conversations.setOnlineStatusAndUpdateView(param1, param2);
        }

        public function createConversation(id: int): Conversation
        {
            var friend: IFriend = this._friendList.getFriend(id);

            if (friend == null)
            {
                Logger.log("No friend found with: " + id);
                return null;
            }

            Logger.log("A FRIEND FOUND: " + friend.id + ", " + friend.name + ", " + friend.gender + ", " + friend.figure);

            return new Conversation(friend.id, friend.name, friend.figure, friend.followingAllowed);
        }

        public function getAvatarFaceBitmap(figure: String): BitmapData
        {
            var bitmap: BitmapData;
            var avatar: IAvatarImage = this._avatarRenderer.createAvatarImage(figure, AvatarScaleType.var_305, null, this);

            if (avatar)
            {
                bitmap = avatar.getImage(AvatarSetType.var_107, true);
                avatar.dispose();

                return bitmap;
            }

            return null;
        }

        public function send(message: IMessageComposer): void
        {
            this._communication.getHabboMainConnection(null).send(message);
        }

        public function playSendSound(): void
        {
            if (this._soundManager != null)
            {
                this._soundManager.playSound(HabboSoundTypesEnum.HBST_MESSAGE_SENT);
            }

        }

        public function openHabboWebPage(linkAlias: String, params: Dictionary, event: WindowEvent): void
        {
            params["predefined"] = this.getPageParam("url.prefix");

            var url: String = this.getVariable(linkAlias, params);
            var webWindowName: String = "habboMain";

            try
            {
                HabboWebTools.navigateToURL(url, webWindowName);
            }
            catch (e: Error)
            {
                Logger.log("GOT ERROR: " + e);
            }

            var wme: WindowMouseEvent = event as WindowMouseEvent;
        }

        public function getText(key: String): String
        {
            return this._localization.getKey(key, key);
        }

        private function getPageParam(url: String): String
        {
            var domain: String;
            if (url == "url.prefix")
            {
                domain = "d31.web.varoke.net";
                domain = this._configuration.getKey("url.prefix", domain);
                domain = domain.replace("http://", "");

                return domain.replace("https://", "");
            }

            return null;
        }

        private function getVariable(param1: String, param2: Dictionary): String
        {
            return this._configuration.getKey(param1, param1, param2);
        }

        private function onSoundManagerReady(param1: IID = null, param2: IUnknown = null): void
        {
            this._soundManager = (param2 as IHabboSoundManager);
        }

        private function onWindowManagerReady(param1: IID = null, param2: IUnknown = null): void
        {
            Logger.log("Messenger: window manager available " + [param1, param2]);
            this._windowManager = (param2 as IHabboWindowManager);
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationReady);
        }

        private function onCommunicationReady(param1: IID = null, param2: IUnknown = null): void
        {
            Logger.log("Messenger: communication available " + [param1, param2]);
            this._communication = (param2 as IHabboCommunicationManager);
            queueInterface(new IIDAvatarRenderManager(), this.onAvatarRenderedReady);
        }

        private function onAvatarRenderedReady(param1: IID = null, param2: IUnknown = null): void
        {
            Logger.log("Messenger: avatar renderer " + [param1, param2]);
            this._avatarRenderer = (param2 as IAvatarRenderManager);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationReady);
        }

        private function onConfigurationReady(param1: IID = null, param2: IUnknown = null): void
        {
            Logger.log("Friend list: configuration " + [param1, param2]);
            this._configuration = (param2 as IHabboConfigurationManager);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationReady);
        }

        private function onLocalizationReady(param1: IID = null, param2: IUnknown = null): void
        {
            Logger.log("Friend list: localization " + [param1, param2]);
            this._localization = (param2 as IHabboLocalizationManager);
            queueInterface(new IIDHabboToolbar(), this.onToolbarReady);
        }

        private function onToolbarReady(param1: IID = null, param2: IUnknown = null): void
        {
            this._toolbar = (IHabboToolbar(param2) as IHabboToolbar);
            queueInterface(new IIDHabboFriendList(), this.onFriendListReady);
        }

        private function onFriendListReady(param1: IID = null, param2: IUnknown = null): void
        {
            Logger.log("Messenger: friend list available " + [param1, param2]);
            this._friendList = (param2 as IHabboFriendList);
            this._communication.addHabboConnectionMessageEvent(new MessengerInitEvent(this.onMessengerInit));
        }

        private function onMessengerInit(event: IMessageEvent): void
        {
            this._conversations = new Conversations(new ConversationsDeps(this));
            this._messengerView = new MessengerView(this);

            this._communication.addHabboConnectionMessageEvent(new NewConsoleMessageEvent(this.onNewConsoleMessage));
            this._communication.addHabboConnectionMessageEvent(new RoomInviteEvent(this.onRoomInvite));
            this._communication.addHabboConnectionMessageEvent(new InstantMessageErrorEvent(this.onInstantMessageError));

            this._toolbar.events.addEventListener(HabboToolbarEvent.HTE_TOOLBAR_CLICK, this.onHabboToolbarEvent);
        }

        public function setHabboToolbarIcon(param1: Boolean, param2: Boolean): void
        {
            if (!param1)
            {
                this._toolbar.events.dispatchEvent(new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.var_306, HabboToolbarIconEnum.MESSENGER));
                return;
            }

            this._toolbar.events.dispatchEvent(new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.var_145, HabboToolbarIconEnum.MESSENGER));
            var _loc3_: HabboToolbarSetIconEvent = new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.var_176, HabboToolbarIconEnum.MESSENGER);
            _loc3_.iconState = param2 ? "1" : "0";
            this._toolbar.events.dispatchEvent(_loc3_);
        }

        private function onHabboToolbarEvent(param1: HabboToolbarEvent): void
        {
            if (param1.iconId != HabboToolbarIconEnum.MESSENGER)
            {
                return;
            }

            if (param1.type == HabboToolbarEvent.HTE_TOOLBAR_CLICK)
            {
                if (this._messengerView.isMessengerOpen())
                {
                    this._messengerView.close();
                }
                else
                {
                    this._messengerView.openMessenger();
                }

                this.setHabboToolbarIcon(true, false);
            }

        }

        private function onNewConsoleMessage(param1: IMessageEvent): void
        {
            var _loc2_: NewConsoleMessageMessageParser = (param1 as NewConsoleMessageEvent).getParser();
            Logger.log("Received console msg: " + _loc2_.messageText + ", " + _loc2_.senderId);
            var _loc3_: Message = new Message(Message.MESSAGE_NEW, _loc2_.senderId, _loc2_.messageText, Util.getFormattedNow());
            this.addMsg(_loc3_);
        }

        private function onRoomInvite(param1: IMessageEvent): void
        {
            var _loc2_: RoomInviteMessageParser = (param1 as RoomInviteEvent).getParser();
            var _loc3_: Message = new Message(Message.MESSAGE_ROOM_INVITE, _loc2_.senderId, this.getText("messenger.invitation") + " " + _loc2_.messageText, Util.getFormattedNow());
            this.addMsg(_loc3_);
        }

        private function addMsg(param1: Message): void
        {
            this._conversations.addMessageAndUpdateView(param1);
            if (!this._messengerView.isMessengerOpen())
            {
                if (this._soundManager != null)
                {
                    this._soundManager.playSound(HabboSoundTypesEnum.var_172);
                }

                this.setHabboToolbarIcon(true, true);
            }

        }

        private function onInstantMessageError(param1: IMessageEvent): void
        {
            var _loc2_: InstantMessageErrorMessageParser = (param1 as InstantMessageErrorEvent).getParser();
            var _loc3_: Message = new Message(Message.MESSAGE_ERROR, _loc2_.userId, this.getInstantMessageErrorText(_loc2_.errorCode), Util.getFormattedNow());
            this._conversations.addMessageAndUpdateView(_loc3_);
        }

        private function getInstantMessageErrorText(param1: int): String
        {
            if (param1 == 3)
            {
                return this.getText("messenger.error.receivermuted");
            }

            if (param1 == 4)
            {
                return this.getText("messenger.error.sendermuted");
            }

            if (param1 == 5)
            {
                return this.getText("messenger.error.offline");
            }

            if (param1 == 6)
            {
                return this.getText("messenger.error.notfriend");
            }

            if (param1 == 7)
            {
                return this.getText("messenger.error.busy");
            }

            return "Unknown im error " + param1;
        }

        public function refreshButton(param1: IWindowContainer, param2: String, param3: Boolean, param4: Function, param5: int): void
        {
            var _loc6_: IBitmapWrapperWindow = param1.findChildByName(param2) as IBitmapWrapperWindow;
            this.refreshButtonDir(_loc6_, param2, param3, param4, param5);
        }

        public function refreshButtonDir(param1: IBitmapWrapperWindow, param2: String, param3: Boolean, param4: Function, param5: int): void
        {
            if (!param3)
            {
                param1.visible = false;
            }
            else
            {
                this.prepareButton(param1, param2, param4, param5);
                param1.visible = true;
            }

        }

        private function prepareButton(param1: IBitmapWrapperWindow, param2: String, param3: Function, param4: int): void
        {
            param1.id = param4;
            if (param1.bitmap != null)
            {
                return;
            }

            param1.bitmap = this.getButtonImage(param2);
            param1.width = param1.bitmap.width;
            param1.height = param1.bitmap.height;
            param1.procedure = param3;
        }

        public function getButtonImage(param1: String): BitmapData
        {
            var _loc5_: BitmapData;
            var _loc2_: IAsset = assets.getAssetByName(param1 + "_png");
            var _loc3_: BitmapDataAsset = _loc2_ as BitmapDataAsset;
            Logger.log("GETTING ASSET: " + param1);
            var _loc4_: BitmapData = _loc3_.content as BitmapData;
            Logger.log("GOT ASSET: " + _loc2_ + ", " + _loc4_);
            _loc5_ = new BitmapData(_loc4_.width, _loc4_.height, true, 0);
            _loc5_.draw(_loc4_);
            return _loc5_;
        }

        public function getXmlWindow(param1: String): IWindow
        {
            var _loc2_: IAsset = assets.getAssetByName(param1 + "_xml");
            var _loc3_: XmlAsset = XmlAsset(_loc2_);
            return this._windowManager.buildFromXML(XML(_loc3_.content));
        }

        public function isEmbeddedMinimailEnabled(): Boolean
        {
            var _loc1_: String = this._configuration.getKey("client.minimail.embed.enabled");
            return _loc1_ == "true";
        }

        public function avatarImageReady(param1: String): void
        {
            if (this._messengerView)
            {
                this._messengerView.refresh();
            }

        }

        public function get windowManager(): IHabboWindowManager
        {
            return this._windowManager;
        }

        public function get conversations(): Conversations
        {
            return this._conversations;
        }

        public function get messengerView(): MessengerView
        {
            return this._messengerView;
        }

        public function get toolbar(): IHabboToolbar
        {
            return this._toolbar;
        }

    }
}
