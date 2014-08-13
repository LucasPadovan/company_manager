var observeAmountFields = function() {
    $('#subtotal, #iva, #other_concepts, #retencion').tooltip();
    $('#subtotal, #iva, #other_concepts, #retencion').on('change', calculateTotal);
    $('#subtotal, #iva, #other_concepts, #retencion').on('change', check_content);
}
var check_content = function(e) {
    if((/,/).test(this.value)) $('#'+this.id).tooltip('show');
}
var calculateTotal= function() {
    $('#total').val(( Number($('#subtotal').val()) + Number($('#iva').val()) + Number($('#other_concepts').val()) + Number($('#retencion').val()) )|| 0 )
}

var setDatePicker = function() {
    $('.datepicker').datepicker({
        format: 'dd/mm/yyyy'
      }
    );
}

var checkProductExistence = function(selector) {

}

var enableTooltips = function () {
  $("[rel='tooltip']").tooltip()
}

//var setTooltip = function () {
//    $('.btn-info, .btn-danger, .filter').tooltip();
//}
