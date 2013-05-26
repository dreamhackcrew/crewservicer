Form.NestedAttributesNewItemRow = new Class({
  Extends: Form.NestedAttributesItemRow,

  initialize: function(templatePath, sequence) {
    var markup = HandlebarsTemplates[templatePath]({
      sequence: sequence
    });

    var element = new Element("tr").set("html", markup);

    this.parent(element);
  }
});
