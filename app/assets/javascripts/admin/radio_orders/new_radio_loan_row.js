RadioOrders.NewRadioLoanRow = new Class({
  Extends: Form.NestedAttributesNewItemRow,

  initialize: function(sequence) {
    this.parent("admin/radio_orders/new_radio_loan_row", sequence);
  }
});
