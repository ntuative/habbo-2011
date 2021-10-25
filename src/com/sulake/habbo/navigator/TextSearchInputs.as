package com.sulake.habbo.navigator
{

    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.navigator.domain.Tabs;

    public class TextSearchInputs
    {

        private var _navigator: HabboNavigator;
        private var _searchStr: TextFieldManager;
        private var _button: IButtonWindow;
        private var _unknown1: Boolean;

        public function TextSearchInputs(navigator: HabboNavigator, unknown: Boolean, container: IWindowContainer)
        {
            this._navigator = navigator;
            this._unknown1 = unknown;
            this._searchStr = new TextFieldManager(this._navigator, ITextFieldWindow(container.findChildByName("search_str")), 25, this.searchRooms, this._navigator.getText("navigator.search.info"));
            
            Util.setProc(container, "search_but", this.onSearchButtonClick);
        }

        private function onSearchButtonClick(event: WindowEvent, param2: IWindow): void
        {
            if (event.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            }

            this.searchRooms();
        }

        private function searchRooms(): void
        {
            var searchTerm: String = this._searchStr.getText();
            
            if (searchTerm == "")
            {
                return;
            }

            this._navigator.mainViewCtrl.startSearch(Tabs.TAB_SEARCH_PAGE, Tabs.SEARCH_TYPE_TEXT_SEARCH, searchTerm);
        }

        public function get searchStr(): TextFieldManager
        {
            return this._searchStr;
        }

    }
}
