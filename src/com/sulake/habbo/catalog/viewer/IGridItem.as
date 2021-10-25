package com.sulake.habbo.catalog.viewer
{

    import com.sulake.core.window.IWindowContainer;

    public interface IGridItem
    {

        function get view(): IWindowContainer;

        function set view(param1: IWindowContainer): void;

        function set grid(param1: IItemGrid): void;

        function dispose(): void;

        function activate(): void;

        function deActivate(): void;

    }
}
