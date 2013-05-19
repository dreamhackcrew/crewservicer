FoodServices.NewDishRow = new Class({
  Extends: FoodServices.DishRow,

  initialize: function(sequence) {
    var markup = HandlebarsTemplates["admin/food_services/dish_list_item"]({
      sequence: sequence
    });

    var element = new Element("tr").set("html", markup);

    this.parent(element);
  }
});
