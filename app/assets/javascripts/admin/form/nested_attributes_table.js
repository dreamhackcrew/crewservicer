Form.NestedAttributesTable = new Class({
  initialize: function(tableElement, newItemElement, newItemClass, sequenceStart) {
    this.itemRows = [];
    this.tableElement = tableElement;
    this.bodyElement = this.tableElement.getChildren("tbody")[0];
    this.newItemElement = newItemElement;
    this.newItemClass = newItemClass;
    this.newItemSequence = sequenceStart || 0;

    var editItemRows = this.bodyElement.getChildren("tr");
    editItemRows.each(function(editItemRow) {
      new Form.NestedAttributesItemRow(editItemRow)
    });

    this.newItemElement.addEvent("click", this.onAddItem.bind(this));
  },

  onAddItem: function(event) {
    event.preventDefault();

    var newItem = new this.newItemClass(this.newItemSequence++);
    this.itemRows.push(newItem);
    newItem.element.inject(this.bodyElement)
  }
});
