var FDControlId = $.inherit({
  prefixName: 'FDcontrol-',
  elemId:"",
  base:{
    internalId: "",
    controlId: "",
    virtualId: ""
  },

  __constructor: function(data) {
    this.base= $.extend(true, {}, this.base );

    this.load(data)
    this.elemId = this._buildElementId()
  },

  _buildElementId: function() {
//    return this.prefixName+ this.base.internalId;
     return  this.base.virtualId==""? this.prefixName+ this.base.internalId: this.base.virtualId;
//     return this.base.controlId=="" && this.base.virtualId==""?
//                 this.prefixName+ this.base.internalId:
//                 (
//                     this.base.virtualId==""?
//                         this.prefixName+ "s"+this.base.controlId:
//                         this.base.virtualId
//                  )
  },

  load: function(data) {
    if( typeof data == "object" ){
      this.base.internalId = data.internalId || "";
      this.base.controlId = data.controlId || "";
      this.base.virtualId = data.virtualId || "";
    }
    if( typeof data =="number" ){
      this.base.controlId = data;
    }
    this.base.internalId = FDController.generateId();
  },

  save: function() {
    return $.extend(true,{}, this.base);
  },

  domId: function() {
    return this.elemId;
  },

  isEqual: function(objectId) {
    return !!(
      objectId.controlId==this.base.controlId ||
           ( objectId.base && objectId.base.controlId==this.base.controlId )
    )
  }

})
