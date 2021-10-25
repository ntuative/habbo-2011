package com.sulake.habbo.friendbar.view.tabs
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;

    public interface ITab extends IDisposable
    {

        function get window(): IWindowContainer;

        function get selected(): Boolean;

        function get recycled(): Boolean;

        function select(): void;

        function deselect(): void;

        function recycle(): void;

    }
}
