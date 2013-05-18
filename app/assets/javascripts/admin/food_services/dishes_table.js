FoodServices.DishesTable = new Class({
  initialize: function(tableElement, newDishElement, sequenceStart) {
    this.dishRows = [];
    this.tableElement = tableElement;
    this.bodyElement = this.tableElement.getChildren("tbody")[0];
    this.newDishElement = newDishElement;
    this.newDishSequence = sequenceStart || 0;

    var editDishRows = $$("#dishes tbody tr");
    editDishRows.each(function(editDishRow) {
      new FoodServices.DishRow(editDishRow)
    });

    this.newDishElement.addEvent("click", this.onAddDish.bind(this));
  },

  onAddDish: function(event) {
    event.preventDefault();

    var newItem = new FoodServices.NewDishRow(this.newDishSequence++);
    this.dishRows.push(newItem);
    newItem.element.inject(this.bodyElement)
  }
});