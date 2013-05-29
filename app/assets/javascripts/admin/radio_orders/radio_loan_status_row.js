RadioOrders.RadioLoanStatusRow = new Class({
  Implements: Events,

  initialize: function(rowElement) {
    this.rowElement = rowElement;
    this.type = this.rowElement.get("data-status-row-type");

    if (this.type != "") {
      this.selectedCheckbox = this.rowElement.getElement('.select-row');

      this.selectedCheckbox.addEvent("click", this.onClick.bind(this));
    }
  },

  onClick: function() {
    this.fireEvent("selectedchange");
  },

  selected: function() {
    return this.type != "" ? this.selectedCheckbox.get("checked") : false;
  },

  disable: function() {
    if (this.type != "") {
      this.selectedCheckbox.set("checked", false);
      this.selectedCheckbox.set("disabled", true);
    }
  },

  enable: function() {
    if (this.type != "") this.selectedCheckbox.set("disabled", false);
  }
});