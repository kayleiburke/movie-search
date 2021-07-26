// set the size of all poster images equal to the heighth of the tallest poster
changePosterSizes = function(){
    var movie_posters = document.getElementsByClassName("movie-poster");
    var max_height = Math.max.apply(Math, Array.from(movie_posters).map(function(poster) { return poster.clientHeight; }));

    if (max_height > 0) {
        Array.from(movie_posters).forEach(function(poster) {
            var new_height = max_height + "px";
            poster.parentElement.style.height = new_height;
            poster.closest(".card").style.height = new_height;
        });
    }
};

$( document ).ready(function() {
    changePosterSizes();

    $(window).resize(function() {
        changePosterSizes();
    });
});
