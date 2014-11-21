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

var updateRecipeTotals = function() {
  var
      lowestCostTarget  = document.getElementById('lowestCost')
    , highestCostTarget = document.getElementById('highestCost')
    , lowestValues      = document.querySelectorAll('[data-lowest-value]')
    , highestValues     = document.querySelectorAll('[data-lowest-value]')
    , lowestCost        = 0.0
    , highestCost       = 0.0

  for (i = 0; element = lowestValues[i++];)  lowestCost  += Number(element.getAttribute('data-lowest-value'))
  for (i = 0; element = highestValues[i++];) highestCost += Number(element.getAttribute('data-lowest-value'))

  lowestCostTarget.innerHTML  = lowestCost
  highestCostTarget.innerHTML = highestCost
}

//var setTooltip = function () {
//    $('.btn-info, .btn-danger, .filter').tooltip();
//}
