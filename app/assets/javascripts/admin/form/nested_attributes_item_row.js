Form.NestedAttributesItemRow = new Class({
  initialize: function(element) {
    this.element = element;

    this.inputElements = this.element.getElements("input[type=text],input[type=checkbox]:not(.destroy)");
    this.destroyCheckbox = this.element.getElements(".destroy")[0];

    this.destroyCheckbox.addEvent("click", this.onDestroyClick.bind(this));
  },

  onDestroyClick: function() {
    this.reflectDestroy();
  },

  reflectDestroy: function() {
    var destroyed = this.destroyCheckbox.get("checked");

    this.inputElements.each(function(input) {
      input.set("disabled", destroyed);
    }, this);

    if (destroyed) {
      this.element.addClass("destroy");
    } else {
      this.element.removeClass("destroy");
    }
  }
});
