RadioOrders.RadioLoanStatusTable = new Class({
  initialize: function(tableElement, actions) {
    this.tableElement = tableElement;
    this.tableBodyElement = this.tableElement.getElement("tbody");
    this.actions = actions;
    this.rows = [];
    this.currentType = null;

    this.tableBodyElement.getElements("tr").each(function(rowElement) {
      var row = new RadioOrders.RadioLoanStatusRow(rowElement);

      row.addEvent("selectedchange", this.reflectSelections.bind(this));

      this.rows.push(row);
    }, this);

    this.reflectSelections();
  },

  reflectSelections: function() {
    if (!this.updateCurrentType()) return;

    this.updateRows();
    this.updateActions();
  },

  updateCurrentType: function() {
    var newType = null;

    this.rows.each(function(row) {
      if (row.selected()) {
        newType = row.type;
      }
    }, this);

    if (this.currentType != newType) {
      this.currentType = newType;
      return true;
    } else {
      return false;
    }
  },

  updateRows: function() {
    this.rows.each(function(row) {
      if (this.currentType == null || row.type == this.currentType) {
        row.enable();
      } else {
        row.disable();
      }
    }, this);
  },

  updateActions: function() {
    if (this.currentType == "pickup") {
      this.actions.viewPickupSubmit();
    } else if (this.currentType == "return") {
      this.actions.viewReturnSubmit();
    } else {
      this.actions.viewSelectHint();
    }
  }
});