$(function() {

    setTimeout(function() {
        $(".cuadro").css('transform', 'translateY(0)');
    }, 50);

    setTimeout(function() {
        $(".cuadro").css('filter', 'opacity(100%)');
        $("body").css('overflow', 'show');
        
    }, 50);

    $('#btnEnviar').click(function() {
        $(this).addClass("loading");
    });
});