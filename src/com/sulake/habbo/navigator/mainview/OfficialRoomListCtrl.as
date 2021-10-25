package com.sulake.habbo.navigator.mainview
{

    import com.sulake.habbo.navigator.IViewCtrl;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomEntryData;
    import com.sulake.core.window.components.*;
    import com.sulake.habbo.navigator.*;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.*;
    import com.sulake.core.window.enum.*;

    public class OfficialRoomListCtrl implements IViewCtrl
    {

        private var _navigator: HabboNavigator;
        private var _content: IWindowContainer;
        private var _itemList: IItemListWindow;

        public function OfficialRoomListCtrl(navigator: HabboNavigator): void
        {
            this._navigator = navigator;
        }

        public function dispose(): void
        {
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
            this._itemList.autoArrangeItems = false;
            
            var refreshed: Boolean;
            var entries: Array = this.getVisibleEntries();
            var i: int;
            
            while (true)
            {
                if (i < entries.length)
                {
                    this.refreshEntry(true, i, entries[i]);
                }
                else
                {
                    refreshed = this.refreshEntry(false, i, null);
                    
                    if (refreshed)
                    {
                        break;
                    }
                }

                i++;
            }

            this._itemList.autoArrangeItems = true;
        }

        private function getVisibleEntries(): Array
        {
            var entry: OfficialRoomEntryData;
            var entries: Array = this._navigator.data.officialRooms.entries;
            var visibleEntries: Array = [];
            var visibleIndex: int;

            for each (entry in entries)
            {
                if (entry.folderId > 0)
                {
                    if (entry.folderId == visibleIndex)
                    {
                        visibleEntries.push(entry);
                    }

                }
                else
                {
                    visibleIndex = entry.open ? entry.index : 0;
                    visibleEntries.push(entry);
                }

            }

            return visibleEntries;
        }

        private function refreshEntry(visible: Boolean, id: int, data: OfficialRoomEntryData): Boolean
        {
            var container: IWindowContainer = IWindowContainer(this._itemList.getListItemAt(id));
            
            if (container == null)
            {
                if (!visible)
                {
                    return true;
                }

                container = this._navigator.officialRoomEntryManager.createEntry(id);
                this._itemList.addListItem(container);
            }

            this._navigator.officialRoomEntryManager.refreshEntry(container, visible, id, data);
            
            return false;
        }

    }
}
