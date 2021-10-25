package com.sulake.habbo.avatar
{

    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.communication.messages.incoming.avatar.WardrobeMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.avatar.SaveWardrobeOutfitMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.avatar.GetWardrobeMessageComposer;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class AvatarEditorHandler
    {

        private var _communication: IHabboCommunicationManager;
        private var _controller: HabboAvatarEditor;

        public function AvatarEditorHandler(param1: HabboAvatarEditor, param2: IHabboCommunicationManager)
        {
            this._controller = param1;
            this._communication = param2;
            this._communication.addHabboConnectionMessageEvent(new WardrobeMessageEvent(this.onWardrobe));
            this._communication.addHabboConnectionMessageEvent(new UserRightsMessageEvent(this.onUserRights));
        }

        public function dispose(): void
        {
            this._communication = null;
            this._controller = null;
        }

        public function saveWardrobeOutfit(param1: int, param2: IOutfit): void
        {
            if (this._communication == null)
            {
                return;
            }

            var _loc3_: SaveWardrobeOutfitMessageComposer = new SaveWardrobeOutfitMessageComposer(param1, param2.figure, param2.gender);
            this._communication.getHabboMainConnection(null).send(_loc3_);
            _loc3_.dispose();
            _loc3_ = null;
        }

        public function getWardrobe(): void
        {
            if (this._communication == null)
            {
                return;
            }

            var _loc1_: GetWardrobeMessageComposer = new GetWardrobeMessageComposer();
            this._communication.getHabboMainConnection(null).send(_loc1_);
            _loc1_.dispose();
            _loc1_ = null;
        }

        private function onWardrobe(param1: WardrobeMessageEvent): void
        {
            if (param1 == null)
            {
                return;
            }

            if (this._controller && this._controller.wardrobe)
            {
                this._controller.wardrobe.updateSlots(param1.state, param1.outfits);
            }

        }

        private function onUserRights(param1: IMessageEvent): void
        {
            this._controller.update();
        }

    }
}
