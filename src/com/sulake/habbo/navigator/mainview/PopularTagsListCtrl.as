package com.sulake.habbo.navigator.mainview
{

    import com.sulake.habbo.navigator.IViewCtrl;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.navigator.TagRenderer;
    import com.sulake.habbo.communication.messages.incoming.navigator.PopularTagData;
    import com.sulake.habbo.navigator.Util;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.*;
    import com.sulake.habbo.navigator.*;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.*;
    import com.sulake.core.window.enum.*;

    public class PopularTagsListCtrl implements IViewCtrl
    {

        private var _navigator: HabboNavigator;
        private var _content: IWindowContainer;
        private var _itemList: IItemListWindow;
        private var _unknown1: int;
        private var _tagRenderer: TagRenderer;

        public function PopularTagsListCtrl(navigator: HabboNavigator): void
        {
            this._navigator = navigator;
            this._tagRenderer = new TagRenderer(this._navigator);
        }

        public function dispose(): void
        {
            if (this._tagRenderer)
            {
                this._tagRenderer.dispose();
                this._tagRenderer = null;
            }

        }

        public function set content(value: IWindowContainer): void
        {
            this._content = value;
            this._itemList = IItemListWindow(this._content.findChildByName("item_list"));
        }

        public function get content(): IWindowContainer
        {
            return this._content;
        }

        public function refresh(): void
        {
            var tagData: PopularTagData;
            var tags: Array = this._navigator.data.popularTags.tags;
            var item: IWindowContainer = IWindowContainer(this._itemList.getListItemAt(0));
            
            if (item == null)
            {
                item = IWindowContainer(this._navigator.getXmlWindow("grs_popular_tag_row"));
                this._itemList.addListItem(item);
            }

            Util.hideChildren(item);
            var i: int;

            while (i < this._navigator.data.popularTags.tags.length)
            {
                tagData = this._navigator.data.popularTags.tags[i];
                this._tagRenderer.refreshTag(item, i, tagData.tagName);
                i++;
            }

            Util.layoutChildrenInArea(item, item.width, 18, 3);
            item.height = Util.getLowestPoint(item);
            this._content.findChildByName("no_tags_found").visible = tags.length < 1;
        }

        private function refreshTagName(container: IWindowContainer, data: PopularTagData): void
        {
            var childName: String = "txt";
            var textWindow: ITextWindow = ITextWindow(container.findChildByName(childName));
            
            if (data == null)
            {
                return;
            }

            textWindow.visible = true;
            textWindow.text = data.tagName;
        }

    }
}
