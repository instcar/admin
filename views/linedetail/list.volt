{# user/list.vot #}

{% extends "main.volt" %}

{% block style %}

        <link rel="stylesheet" href="/assets/css/jquery-ui-1.10.3.full.min.css" />
        <link rel="stylesheet" href="/assets/css/datepicker.css" />
        <link rel="stylesheet" href="/assets/css/ui.jqgrid.css" />
        <link rel="stylesheet" href="/assets/css/jquery-ui-1.10.3.full.min.css" />
        
    {{ super() }}

{% endblock %}


        
{% block page_content %}

<table id="grid-table"></table>

<div id="grid-pager"></div>

<script type="text/javascript">
    var $path_base = "/";//this will be used in gritter alerts containing images
</script>

{% endblock %}
{% block js_bottom %}
    {{ super() }}
<script src="/assets/js/date-time/bootstrap-datepicker.min.js"></script>
<script src="/assets/js/jqGrid/jquery.jqGrid.min.js"></script>
<script src="/assets/js/jqGrid/i18n/grid.locale-zh.js"></script>

        <script src="/assets/js/jquery-ui-1.10.3.full.min.js"></script>
        <script src="/assets/js/jquery.ui.touch-punch.min.js"></script>


    <!-- inline scripts related to this page -->
    <script type="text/javascript">            
            jQuery(function($) {
                var grid_selector = "#grid-table";
                var pager_selector = "#grid-pager";
            
                jQuery(grid_selector).jqGrid({
                    //direction: "rtl",
                    
                    //data: grid_data,
                    //datatype: "local",
                    url: '{{ url("admin/linedetail/dolist?lineid=")}}{{ lineid }}',
                    datatype: "json",
                    height: 'auto',
                    colNames:[' ', 'ID','聚点名称','前驱聚点','后驱聚点', '价钱','离前驱距离（里）','','','',''],
                    colModel:[
                        {name:'myac',index:'', width:80, fixed:true, sortable:false, resize:false,
                            formatter:'actions', 
                            formatoptions:{ 
                                keys:true,
                                
                                delOptions:{recreateForm: true, beforeShowForm:beforeDeleteCallback},
                                addOptions:{recreateForm: true, beforeShowForm:beforeAddCallback}
                                //editformbutton:true, editOptions:{recreateForm: true, beforeShowForm:beforeEditCallback}
                            }
                        },
                        {name:'id',index:'id', width:60, sorttype:"int", editable: false},
                        {name:'point_id_detail.name', editable:true,unformat: pointFormat},
                        {name:'pre_point_id_detail.name', editable:true,unformat: pointFormat},
                        {name:'post_point_id_detail.name', editable:true,unformat: pointFormat},
                        {name:'price', width:120, editable: true,editoptions:{size:"20",maxlength:"30"}},
                        {name:'distance', width:120, editable: true,editoptions:{size:"20",maxlength:"30"}},
                        {name:'line_id',hidden:true,hidedlg:true, editable: true},
                        {name:'point_id',hidden:true,hidedlg:true, editable: true},
                        {name:'pre_point_id',hidden:true,hidedlg:true, editable: true},
                        {name:'post_point_id',hidden:true,hidedlg:true, editable: true},
                    ], 
                    	
                    viewrecords : true,
                    rowNum:10,
                    rowList:[10,20,30],
                    pager : pager_selector,
                    altRows: true,
                    //toppager: true,
                    
                    multiselect: true,
                    //multikey: "ctrlKey",
                    multiboxonly: true,
            
                    loadComplete : function() {
                        var table = this;
                        setTimeout(function(){
                            styleCheckbox(table);
                            
                            updateActionIcons(table);
                            updatePagerIcons(table);
                            enableTooltips(table);
                        }, 0);
                    },
                    editurl: "{{ url("admin/linedetail/dosomething") }}",//nothing is saved
                    //caption: "聚点管理",
                    emptyrecords: "没有相关记录",  
            
                    autowidth: true,
                    
                    jsonReader: {
 
                        root: "data.list",
                         
                        total: "data.totalpages",
                         
                        page: "data.currpage",
                         
                        records: "data.total",
                         
                        repeatitems: false
                         
                        },
            
                });
             
                  
                //enable search/filter toolbar
                //jQuery(grid_selector).jqGrid('filterToolbar',{defaultSearch:true,stringResult:true})
            
                //switch element when editing inline
                function aceSwitch( cellvalue, options, cell ) {
                    setTimeout(function(){
                        $(cell) .find('input[type=checkbox]')
                                .wrap('<label class="inline" />')
                            .addClass('ace ace-switch ace-switch-5')
                            .after('<span class="lbl"></span>');
                    }, 0);
                }
                //enable datepicker
                function pickDate( cellvalue, options, cell ) {
                    setTimeout(function(){
                        $(cell) .find('input[type=text]')
                                .datepicker({format:'yyyy-mm-dd' , autoclose:true}); 
                    }, 0);
                }
            
                
                //navButtons
                jQuery(grid_selector).jqGrid('navGrid',pager_selector,
                    {   //navbar options
                        edit: true,
                        editicon : 'icon-pencil blue',
                        add: true,
                        addicon : 'icon-plus-sign purple',
                        del: true,
                        delicon : 'icon-trash red',
                        search: true,
                        searchicon : 'icon-search orange',
                        refresh: true,
                        refreshicon : 'icon-refresh green',
                        view: true,
                        viewicon : 'icon-zoom-in grey',
                    },
                    {
                        //edit record form
                        closeAfterEdit: true,
                        recreateForm: true,
                        beforeShowForm : function(e) {
                            var form = $(e[0]);
                            form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
                            style_edit_form(form);
                        }
                    },
                    {
                        //new record form
                        closeAfterAdd: true,
                        recreateForm: true,
                        viewPagerButtons: false,
                        beforeShowForm : function(e) {
                            var form = $(e[0]);
                            form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
                            style_edit_form(form);
                        }
                    },
                    {
                        //delete record form
                        recreateForm: true,
                        beforeShowForm : function(e) {
                            var form = $(e[0]);
                            if(form.data('styled')) return false;
                            
                            form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
                            style_delete_form(form);
                            
                            form.data('styled', true);
                        },
                        onClick : function(e) {
                            alert(1);
                        }
                    },
                    {
                        //search form
                        recreateForm: true,
                        afterShowSearch: function(e){
                            var form = $(e[0]);
                            form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
                            style_search_form(form);
                        },
                        afterRedraw: function(){
                            style_search_filters($(this));
                        }
                        ,
                        multipleSearch: true,
                        /**
                        multipleGroup:true,
                        showQuery: true
                        */
                    },
                    {
                        //view record form
                        recreateForm: true,
                        beforeShowForm: function(e){
                            var form = $(e[0]);
                            form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
                        }
                    }
                )
            
                function formatName(cellvalue, options, rowObject){
                    return '<a href="{{ url("admin/line/point") }}" >'+cellvalue+'</a>';
                }
                
                function style_edit_form(form) {
                    //enable datepicker on "sdate" field and switches for "stock" field
                    form.find('input[name=sdate]').datepicker({format:'yyyy-mm-dd' , autoclose:true})
                        .end().find('input[name=stock]')
                              .addClass('ace ace-switch ace-switch-5').wrap('<label class="inline" />').after('<span class="lbl"></span>');
            
                    //update buttons classes
                    var buttons = form.next().find('.EditButton .fm-button');
                    buttons.addClass('btn btn-sm').find('[class*="-icon"]').remove();//ui-icon, s-icon
                    buttons.eq(0).addClass('btn-primary').prepend('<i class="icon-ok"></i>');
                    buttons.eq(1).prepend('<i class="icon-remove"></i>')
                    
                    buttons = form.next().find('.navButton a');
                    buttons.find('.ui-icon').remove();
                    buttons.eq(0).append('<i class="icon-chevron-left"></i>');
                    buttons.eq(1).append('<i class="icon-chevron-right"></i>');     
                }
            
                function style_delete_form(form) {
                    var buttons = form.next().find('.EditButton .fm-button');
                    buttons.addClass('btn btn-sm').find('[class*="-icon"]').remove();//ui-icon, s-icon
                    buttons.eq(0).addClass('btn-danger').prepend('<i class="icon-trash"></i>');
                    buttons.eq(1).prepend('<i class="icon-remove"></i>')
                }
                
                function style_search_filters(form) {
                    form.find('.delete-rule').val('X');
                    form.find('.add-rule').addClass('btn btn-xs btn-primary');
                    form.find('.add-group').addClass('btn btn-xs btn-success');
                    form.find('.delete-group').addClass('btn btn-xs btn-danger');
                }
                function style_search_form(form) {
                    var dialog = form.closest('.ui-jqdialog');
                    var buttons = dialog.find('.EditTable')
                    buttons.find('.EditButton a[id*="_reset"]').addClass('btn btn-sm btn-info').find('.ui-icon').attr('class', 'icon-retweet');
                    buttons.find('.EditButton a[id*="_query"]').addClass('btn btn-sm btn-inverse').find('.ui-icon').attr('class', 'icon-comment-alt');
                    buttons.find('.EditButton a[id*="_search"]').addClass('btn btn-sm btn-purple').find('.ui-icon').attr('class', 'icon-search');
                }
                
                function beforeDeleteCallback(e) {
                    var form = $(e[0]);
                    if(form.data('styled')) return false;
                    
                    form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
                    style_delete_form(form);
                    
                    form.data('styled', true);
                }
                
                function beforeEditCallback(e) {
                    /*var form = $(e[0]);
                    form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
                    style_edit_form(form);*/
                	/*.autocomplete({
                        source: getPoint,
                        select: function( event, ui ) { 
                        	var id=  $(this).attr('id').replace("_detail.name","");
                        	$("#"+id).val(ui.item.id);
                        }
                    });*/
                }
                
                function beforeAddCallback(e){
                	console.log(e);
                }
            
            
            
                //it causes some flicker when reloading or navigating grid
                //it may be possible to have some custom formatter to do this as the grid is being created to prevent this
                //or go back to default browser checkbox styles for the grid
                function styleCheckbox(table) {
                /**
                    $(table).find('input:checkbox').addClass('ace')
                    .wrap('<label />')
                    .after('<span class="lbl align-top" />')
            
            
                    $('.ui-jqgrid-labels th[id*="_cb"]:first-child')
                    .find('input.cbox[type=checkbox]').addClass('ace')
                    .wrap('<label />').after('<span class="lbl align-top" />');
                */
                }
                
            
                //unlike navButtons icons, action icons in rows seem to be hard-coded
                //you can change them like this in here if you want
                function updateActionIcons(table) {
                    /**
                    var replacement = 
                    {
                        'ui-icon-pencil' : 'icon-pencil blue',
                        'ui-icon-trash' : 'icon-trash red',
                        'ui-icon-disk' : 'icon-ok green',
                        'ui-icon-cancel' : 'icon-remove red'
                    };
                    $(table).find('.ui-pg-div span.ui-icon').each(function(){
                        var icon = $(this);
                        var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
                        if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
                    })
                    */
                }
                
                //replace icons with FontAwesome icons like above
                function updatePagerIcons(table) {
                    var replacement = 
                    {
                        'ui-icon-seek-first' : 'icon-double-angle-left bigger-140',
                        'ui-icon-seek-prev' : 'icon-angle-left bigger-140',
                        'ui-icon-seek-next' : 'icon-angle-right bigger-140',
                        'ui-icon-seek-end' : 'icon-double-angle-right bigger-140'
                    };
                    $('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function(){
                        var icon = $(this);
                        var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
                        
                        if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
                    })
                }
            
                function enableTooltips(table) {
                    $('.navtable .ui-pg-button').tooltip({container:'body'});
                    $(table).find('.ui-pg-div').tooltip({container:'body'});
                }
            
                //var selr = jQuery(grid_selector).jqGrid('getGridParam','selrow');
            
                 //autocomplete
                 var availableTags = [
                    "ActionScript",
                    "AppleScript",
                    "Asp",
                    "BASIC",
                    "C",
                    "C++",
                    "Clojure",
                    "COBOL",
                    "ColdFusion",
                    "Erlang",
                    "Fortran",
                    "Groovy",
                    "Haskell",
                    "Java",
                    "JavaScript",
                    "Lisp",
                    "Perl",
                    "PHP",
                    "Python",
                    "朝阳",
                    "上地",
                    "中国"
                ];
                
                function getPoint( request, response) {  
                        $.ajax({  
                            url: "{{url('admin/point/search')}}",  
                              
                            dataType: "json",  
                            data: {               
                                wd: request.term 
                            },  
                            success:function(json){
                            	if( json.data.list ){
	                                response( $.map( json.data.list, function( name ) {  
	                                    return {  
	                                        label: name.name,  
	                                        value: name.name,
	                                        id:name.id
	                                    }  
	                                })); 
                            	}
                            }             
                                  
                        });  
                          
                }
                
                function pointFormat(cellvalue, options, cell){
                    setTimeout(function(){
                        $(cell) .find('input[type=text]').autocomplete({
                            source: getPoint,
                            select: function( event, ui ) { 
                            	var id=  $(this).attr('id').replace("_detail.name","");
                            	$("#"+id).val(ui.item.id);
                            }
                        }); 
                    }, 0);
                }
                
            
            
            });
    </script>

{% endblock %}
