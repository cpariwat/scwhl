(function () {
    this.App || (this.App = {});

    var _initGrid = function () {
        $('#pinBoard').pinterest_grid({
            no_columns: 2,
            padding_x: 20,
            padding_y: 10,
            margin_bottom: 50,
            single_column_breakpoint: 700
        });
    };

    // Public Methods
    App.Grid = {
        init: function () {
            _initGrid();
        }
    }
}).call(this);
