$(function () {
    $('form').bootstrapValidator({
        message: 'Vyplňte prosím',
        excluded: [':disabled']
    });
});