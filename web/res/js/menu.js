$(function () {
    $('#btn-menu').click(function () {
        $('#sidebar').sidebar('setting', 'dimPage', false).sidebar('setting', 'transition', 'push').sidebar('toggle');
    });
});