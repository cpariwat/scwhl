//= require_tree ./modules

(function() {
    this.App || (this.App = {});

    $( document ).ready(function() {
        App.Grid.init();
        App.SadCat.init();
    });
}).call(this);