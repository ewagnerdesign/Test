FDConnection.Tree = $.inherit({
  treeData: {},
  originalTreeData: {},

  options:{
     disabled:{}
  },

  showValidators: false,

  __constructor: function(container, options) {
    this.options = $.extend(true, {}, this.options);
    this.container = $(container);
    this.tree = this.container.find('.tree');
    this.container.find('.filter input').
            keyup($.proxy(this._filterInput, this));

    this.load(options)

    this._initData();

    this._initNodeExplodeEvent()
  },

  render: function() {
    this.tree.html('');
    this._render();
    this._renderEvents();
  },

  load: function(data) {
    if(!data){
      return;
    }
    var disabled = this.options.disabled
    $.each(data.disabled, $.proxy(function(index, controlDataId) {
      try{
        var controlId = FDController.getControlById( controlDataId.id ).elId
        disabled[controlId] = this._controlNode(controlId)

      }catch(err){
        $.error("can't load connection tree", err)
      }
    }, this));
  },

  //Disable tree node by id
  disableNode: function(disableControlId) {
    var rthis = this
    var disableControlNode = function(controlId, element) {
      $(element).addClass('disabled').draggable('disable')
      rthis.options.disabled[controlId]=$(element)
    }

    var controlNode = this._controlNode(disableControlId)

    // disable dropped control
    disableControlNode(disableControlId, controlNode)

    // disable childs
    var childs = controlNode.next('ul').find('.draggable:not(.disabled)')
    $.each(childs, function(index, child) {
      disableControlNode($(child).data('id'), child)
    })
  },

  //Enable tree node by id
  enableNode: function(enabledControlId) {
    var rthis = this;
    var enableControlNode = function(controlId, element) {
      $(element).removeClass('disabled').draggable('enable')
      delete rthis.options.disabled[controlId]
    }

    var controlNode = this._controlNode(enabledControlId)
    // enable deleted control
    enableControlNode(enabledControlId, controlNode)

    // enable deleted control childs
    var childs = controlNode.next('ul').find('.draggable.disabled')
    $.each(childs, function(index, child) {
      enableControlNode($(child).data('id'), child)
    })
  },

  removeControl: function(control){
    if( !this.options.disabled[control.id] ){
      return
    }
    delete this.options.disabled[control.id]
  },

  _controlNode: function(controlId) {
    return $('#'+controlId+'-node');
  },

  save: function() {
    var data = []
    $.each(this.options.disabled, function(controlId, value) {
      try{
        data.push({
           id: FDController.getControlById( controlId ).getId().save()
        })
      }catch(err){
        $.error("connection.tree.save", err)
      }
    })

    return {
        disabled: data
    }
  },

  /**
   * Quich tree filtering
   *
   * @param isAcceptedControlFn - function describe rules for filter tree
   */
  filter: function(isAcceptedControlFn) {
    this.treeData = $.extend(true, {}, this.originalTreeData )

    // recursive function for filtering tree
    var filterTree = function(treeData){
      var isDeleteNode = true;
      $.each(treeData, function(controlId, control) {
         if( isAcceptedControlFn(control) ||
               (  control.childs && !filterTree(control.childs) )
         ){
           isDeleteNode = false;
           return true;
         }
        delete treeData[controlId]
      });
      return isDeleteNode;
    }

    filterTree(this.treeData);
  },

  _buildTree: function(controlList){
    var data = {}
    if( !controlList ){
      return data;
    }
    var getControlStruct = function(instance, columns){
        return {
          elId: instance.elId,
          type: instance.options.type,
          title: instance.getTitle(),
          childs: columns || {}
        }
    }

    $.each( controlList, function(id, instance){
        // FIXME: chit-code for columns
        var childsData = {};
        if(instance.options.type=="column"){

          $.each(instance.columns, function(index, controlId) {
            var columnChilds = {};
            $.each(instance.children[controlId], function(j, controlChildId) {
              try{
                var controlChild = FDController.getControlById(controlChildId);
                if(!controlChild){
                  return true;
                }
              }catch(err){
                $.error('_buildTree', err)
                return true;
              }
               columnChilds[controlChildId] = getControlStruct( controlChild );
            });

            childsData[controlId] = {
              elId: controlId,
              type: "column",
              title: "Column "+(index+1),
              childs: columnChilds
            }

          });
        }
        data[id] = getControlStruct( instance, childsData )
    });

    return data;
  },

  _render: function() {
    var tree = this.tree;

    this._renderTree( this.treeData ).appendTo( tree );

    // set last class for all last li tags
    tree.find('li:last-child').each(function(){
      var className = 'last';
      if( $(this).hasClass('collapsable') ){
        className = "lastCollapsable";
        $(this).children('div.hitarea').
                addClass('lastCollapsable-hitarea')
      } else if( $(this).hasClass('expandable') ) {
        className = "lastExpandable"
        $(this).children('div.hitarea').
                addClass('lastExpandable-hitarea')

      }
      $(this).addClass(className)
    })

  },

  _initNodeExplodeEvent: function() {
    this.tree.delegate(
        '.hitarea', "click",
        function(event){
          $(this).toggleClass('collapsable-hitarea expandable-hitarea')

          if( $(this).hasClass('lastCollapsable-hitarea') ||
                  $(this).hasClass('lastExpandable-hitarea')
          ){
            $(this).toggleClass('lastCollapsable-hitarea lastExpandable-hitarea')
          }

          var parentNode = $(this).parent('li')
          parentNode.toggleClass('expandable collapsable')

          if( parentNode.hasClass('lastCollapsable') ||
                parentNode.hasClass('lastExpandable')
          ){
            parentNode.toggleClass('lastCollapsable lastExpandable')
          }

          $(this).children('ul').toggle();
        }
    )
  },

  _renderEvents: function() {
    // set tree nodes draggable
    this.tree.
        find(".draggable").
          draggable({
            opacity: 0.50,
            helper:'clone',
            cursor: 'crosshair',
            stop: function(event, ui) {
              $.each([FDConnection.Operational, FDConnection.Condition], function(index, conn) {
                  conn.droppableContainer.droppable('enable')
              });
            }
          });

    // disable disabled element
    this.tree.find(".draggable.disabled").draggable('disable')

    // disable text selection in a tree
    this.tree.disableSelection()
  },

  _renderTree: function(data, parentContainer ){
    var container= $('<ul>').addClass("controlTree");
    $.each(data, $.proxy(function(controlId, control) {
        container.append(
           this._renderNode( control )
        )
    }, this))

    return container;
  },

  _renderNode: function(node) {
    var nodeElement = $('<li>');

    this._renderNodeTitle( node ).
          addClass( "draggable" ).
          appendTo( nodeElement )

    if( !$.isEmptyObject(node.childs) ){
      nodeElement.addClass("collapsable")
      nodeElement.prepend('<div class="hitarea collapsable-hitarea"></div>')

      this._renderTree( node.childs ).
            appendTo( nodeElement )
    }

    return nodeElement;
  },

  _isDisabledNode: function(control) {
    return typeof this.options.disabled[control.elId]=="object"
  },

  _renderNodeTitle: function(node) {
    var title = $('<span>').
             text(node.title).
             addClass('control-icon').
             addClass( this._getIconClass(node) ).
             data('id', node.elId ).
             attr('id', node.elId+'-node' )
      if( this._isDisabledNode(node)){
        title.addClass("disabled")
      }
    return title;
  },

  //Update tree content based on updated controls list
  update: function(){
    this._initData();
    this.render();
  },

  activate: function() {
    // update controls tree
    this.update()
    FDConnection.Tree.show()
  },

  _getIconClass: function(node){
    return 'tool-'+node.type;
  },

  //Load controls tree from form designer
  _initData: function(){
    this.originalTreeData = this._buildTree( FDController.getControlStruct() )
    this.treeData = this.originalTreeData;
  },

   //Handle filtering field input
  _filterInput: function(e) {
    if (e.keyCode == 27 || $(e.target).val() == '') {
      e.stopPropagation();
      e.preventDefault();
      //Show all
      $(e.target).val('');
    }

    // filtering data by text query
    var query =  $(e.target).val();
    this.filter(function(control){
      return control.title.toString().search(new RegExp(query, "i")) > -1 ;
    })
    this.render();
  }

},{
  container: {},

  init: function() {
    this.container = $("#fdConnectionTreeControlPane")
  },

  deactivate: function() {
//    FDConnection.Tree.container.find(".draggable").
//        draggable({disabled: false})

//    FDConnection.Tree.container.find(".draggable").
//        draggable({disabled: true})
//    FDConnection.Tree.container.find(".filter").hide()
  },

  activate: function() {

  },

  show: function() {
    FDConnection.Tree.container.show();
//    FDConnection.Tree.container.find(".filter").show()
  },

  hide: function() {
    FDConnection.Tree.container.hide();
  }

})

$(document).ready(function(){
  $.proxy(FDConnection.Tree.init(), FDConnection.Tree)
})