// Create a SadCat Module with Immediately-Invoked-Function-Expressions
(function() {
    this.App || (this.App = {});

    var _isNotFetchable = function () {
        return (!$('.sad_cats.index')[0] || App.SadCat.atTheEnd);
    };

    var _retrieveSadCats = function (page) {
        if(_isNotFetchable()) return;

        $.ajax({
            type: "GET",
            url: "/list_cats",
            data: { page: page },
            success: function (result) {
                if(result.length > 0) {
                    $('#pinBoard').append(result);
                    App.SadCat.currentPage++;
                } else {
                    $('.spinner').hide();
                    App.SadCat.atTheEnd = true;
                }
            },
            error: function () {
                console.log('uh oh.. something went wrong')  ;
            }
        });
    };

    var _bindInfiniteScroll = function () {
        $(window).scroll(function() {
            if(_isNotFetchable()) return;

            if($(window).scrollTop() + $(window).height() == $(document).height()) {
                _retrieveSadCats(App.SadCat.currentPage);
            }
        });
    };

    // Public Methods
    App.SadCat = {
        currentPage: 1,
        atTheEnd: false,
        init: function () {
            _retrieveSadCats(App.SadCat.currentPage);
            _bindInfiniteScroll();
        }
    };

}).call(this);
