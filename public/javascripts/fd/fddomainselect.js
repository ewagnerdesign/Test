/**
* Domain -> CDASH select overlay
* @author Alexander Naumchuk
* @package FormDesigner
*/
var FDDomainSelect = $.inherit({},{
  //Domains cache with all data for passing to FDController
  domains: [],
  //All CDASH questions for selected domain
  cdashes: [],

  /**
  * Perform all initial operations
  * now only one instance of selector is available
  */
  init: function() {
    //Loading domains
    $.getJSON( Routes.getDomainsFdPath({format: "json"}), $.proxy(this, 'onDomainLoaded'));

    //Click on domain
    $("#dlDomainList a").live('click', $.proxy(this, 'onDomainClick'));

    //Handle select click
    $('#dlQuestionList a').live('click', $.proxy(this, 'onCdashClick'));

    //Quick Search
    $('#dlDomainSearch').keyup(function(event) {
      if (event.keyCode == 27 || $(this).val() == '') {
        event.stopPropagation();
        event.preventDefault();
        $(this).val('');
        //Show all
        $('#dlDomainList li').show();
      } else {
        filter('#dlDomainList a', $(this).val());
      }
    });

    $('#dlQuestionSearch').keyup(function(event) {
      if (event.keyCode == 27 || $(this).val() == '') {
        event.stopPropagation();
        event.preventDefault();
        $(this).val('');
        //Show all
        $('#dlQuestionList li').show();
      } else {
        filter('#dlQuestionList a', $(this).val());
      }
    });

    //Cleanup on close
    //$('#fdomainselect').overlay({api:true,});
    $('#fdomainselect').overlay({ api: true,
       expose: '#000',
      onClose: function(e) {
        $('#dlQuestionList li').remove();
        $('#dlDomainList li').show();
        $('#dlDomainSearch').val('');
        $('#dlQuestionSearch').val('');
      },
      onBeforeLoad: function() {
          FDDomainSelect.onBeforeLoad();
      },
      onLoad: function() {
        FDDomainSelect.onLoad();
      }
    });
    //filter results based on query
    function filter(selector, query) {
      query = $.trim(query); //trim white space
      query = query.replace(/ /gi, '|'); //add OR for regex query

      $(selector).each(function() {
        ($(this).text().search(new RegExp(query, "i")) < 0) ? $(this).parent().hide().removeClass('visible') : $(this).parent().show().addClass('visible');
      });
    }

  },

  getDomainById: function(domainId) {
    for(var i=0;i<this.domains.length;i++){
      if(this.domains[i].id == domainId){
        return this.domains[i];
      }
    }
    return false;
  },

  onDomainClick: function(event) {
    this.setSelectedDomain($(event.currentTarget));
  },

  /*
   * @description set selected domain and his CDASHES by active jQuery element or by selected domain id
   * @config check activeDomainControl for null value and use selectedDomainId param
   */
  setSelectedDomain: function(activeDomainControl, selectedDomainId) {
    selectedDomainId = selectedDomainId==undefined ? -1 : selectedDomainId;
    $("#dlDomain a").removeClass('rowselected');
    if(activeDomainControl == null){
        //set active control, searching index of elements in daomains array
        $("#dlDomain a[domain_id="+selectedDomainId+"]").addClass('rowselected');
    }
    else{
        selectedDomainId = activeDomainControl.attr('domain_id');
    }

    //cache in field selected domain id
    this.selectedDomainId = selectedDomainId;
    FDDomainSelect.updateDomainCdash(this.selectedDomainId);
  },

  //event before overlay displayed
  onBeforeLoad: function() {
      var activeControl = FDController.getActive();
      this.setSelectedDomain(null, activeControl.control.getDomainId());
  },
  //event when overlay completely displayed
  onLoad: function() {
      
  },

  //get CDASH using JSON
  getCdashData: function(url, callback, async) {
      async = async==undefined ? true : async;
      callback = callback || function(data){};

      // cache CDTM options by request url
      if( !FDDomainSelect.cacheCdtmOptions ){
          FDDomainSelect.cacheCdtmOptions={}
      }
      var result = null;
      var jthis = this;
      if( !FDDomainSelect.cacheCdtmOptions[url] ){
          $.ajax({
              url: url,
              dataType: 'json',
              success: function(data){
                            callback(data, jthis);
                            FDDomainSelect.cacheCdtmOptions[url] = data;
                            result = data;
                       },
              async: async
          });
      } else {
        result = FDDomainSelect.cacheCdtmOptions[url];
        callback(result, jthis);
      }
      if(!async){
        return result;
      }
  },

  onCdashClick: function(event) {
    var cdash = this.cdashes[$(event.currentTarget).data('cdash_ind')];
    FDController.setDomain(this.getDomainById(this.selectedDomainId), cdash);
    $('#fdomainselect').overlay().close();
  },

  updateDomainCdash: function(domain_id, cdash_question_id ){
      if(domain_id==-1){
          return;
      }
      var url = Routes.adminDomainCdashQuestionsPath(domain_id, {format: 'json'});
      this.getCdashData(url, FDDomainSelect.onCdashLoaded);
  },
    
  onCdashLoaded: function(data, obj) {
    //Clear list
    $('#dlQuestionList li').remove();
    //if()
    obj.cdashes = data;
    var root = $('#dlQuestionList');
    $.each(data,function(key,val){
      root.append(
        $('<li>').append(
          $('<a>').text(this.data_collection_field).data('question_id', this.id).data('cdash_ind', key).append(
            $('<img/>',{
              'src': '/images/icons/question-frame.png'
              }).attr('title',this.completion_instructions)
          )
        )
      );
    });

    //Init tooltip
    $("#dlQuestionList img").tooltip({
      effect: "fade",
      opacity: 0.7,
      tip: '.tooltip' ,
        position: 'center right'
    });
  },

  onDomainLoaded: function(data) {
    this.domains = data;
    //TODO: Remove this hardcode
    var root = $('#dlDomainList');
    $.each(data,function(key,val){
      root.append(
        $('<li>').append($('<a>').text(this.name).attr('domain_id', val.id).append(
            $('<img/>',{
              'src': '/images/icons/question-frame.png'
            }).attr('title',this.description)
          )
        )
      );
    });

    //Init tooltip, do it more flexible
    $("#dlDomainList img").tooltip({
      opacity: 0.7,
      tip: '.tooltip' ,
      lazy: true,
      position: 'center right'
    });
  }
});
