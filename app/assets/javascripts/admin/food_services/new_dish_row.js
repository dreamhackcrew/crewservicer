FoodServices.NewDishRow = new Class({
  Extends: Form.NestedAttributesNewItemRow,

  initialize: function(sequence) {
    this.parent("admin/food_services/new_dish_row", sequence);
  }
});
