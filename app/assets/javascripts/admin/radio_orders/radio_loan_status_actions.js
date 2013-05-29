RadioOrders.RadioLoanStatusActions = new Class({
  initialize: function(actionsElement) {
    this.actionsElement = actionsElement;
    this.submitButton = this.actionsElement.getElement(".submit-button");

    this.viewSelectHint();
  },

  viewPickupSubmit: function() {
    this.submitButton.set("value", this.submitButton.get("data-pickup-title"));
    this.actionsElement.removeClass("select-hint-active");
    this.actionsElement.addClass("submit-active");
  },

  viewReturnSubmit: function() {
    this.submitButton.set("value", this.submitButton.get("data-return-title"));
    this.actionsElement.removeClass("select-hint-active");
    this.actionsElement.addClass("submit-active");
  },

  viewSelectHint: function() {
    this.actionsElement.removeClass("submit-active");
    this.actionsElement.addClass("select-hint-active");
  }
});