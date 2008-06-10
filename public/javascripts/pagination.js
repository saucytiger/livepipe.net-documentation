if(typeof(Control) == "undefined")
	Control = {};
if(typeof(Object.Event) == "undefined")
	throw "Control.Pagination requires Object.Event to be loaded.";
Control.Paginator = Class.create({
    initialize: function(items,options){
        this.items = items;
        this.options = Object.extend({
            size: 10,
            onPageChange: Prototype.emptyFunction,
            onItemChange: Prototype.emptyFunction
        },options || {});
        this.setSize(this.options.size);
        this.page_index = 1;
        this.item_index = 0;
    },
    setSize: function(size){
        this.options.size = size;
        this.number_of_pages = Math.ceil(this.items.length / this.options.size);
    },
    pageIndexFromItemIndex: function(item_index){
        return Math.floor(((item_index || this.item_index) / this.options.size) + 1);
    },
    goToPage: function(page_index){
        this.page_index = page_index;
        this.triggerOnPageChange();
    },
    triggerOnPageChange: function(){
        this.notify('onPageChange',this.items.slice((this.page_index - 1) * this.options.size,((this.page_index - 1) * this.options.size) + this.options.size),this.page_index);
    },
    goToItem: function(item_index){
        this.item_index = item_index;
        this.notify('onItemChange',this.items[this.item_index],this.item_index);
        var new_page_index = this.pageIndexFromItemIndex(this.item_index);
        if(new_page_index != this.page_index)
            this.goToPage(new_page_index);
    },
    hasNextItem: function(){
        return this.item_index < this.items.length - 1;
    },
    hasPreviousItem: function(){
        return this.item_index >= 1;
    },
    nextItem: function(){
        if(!this.hasNextItem())
            return false;
        this.goToItem(this.item_index + 1);
        return true;
    },
    previousItem: function(){
        if(!this.hasPreviousItem())
            return false;
        this.goToItem(this.item_index - 1);
        return true;
    },
    hasNextPage: function(){
        return this.page_index < this.number_of_pages;
    },
    hasPreviousPage: function(){
        return this.page_index >= 2;
    },
    nextPage: function(){
        if(!this.hasNextPage())
            return false;
        this.goToPage(this.page_index + 1);
        return true;
    },
    previousPage: function(){
        if(!this.hasPreviousPage())
            return false;
        this.goToPage(this.page_index - 1);
        return true;
    }
});
Object.Event.extend(Control.Paginator);