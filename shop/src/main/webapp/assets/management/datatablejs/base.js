(function($, window){

	$.fn.DatatableExt = function(_config){
		var defaults = {
           "processing": true,
           "serverSide": true,
           "ajax": "listData",
           "language":  "/shop/assets/management/datatablejs/Chinese.json",
           "columns": [{}],
           "aoColumnDefs" : [{}],
           "className" : "",
           "chosen" : true,
           "ids" : "",
           "targets":"",
           //tfoot的回调函数
           "footerCallback":null,
           //行被创建时回调函数
           "createdRow":null,	
           //表格每次重绘回调函数
           "drawCallback":null,	
           //数字格式化时的回调函数formatNumber不定时一讲
           "formatNumber":null, 	
           //表格Header显示时的回调函数
           "headerCallback":null,	
           //表格状态信息改变的回调函数
           "infoCallback":null,	
           //初始化结束后的回调函数s
           "initComplete":null,	
           //表格绘制前的回调函数
           "preDrawCallback":null,	
           //表格行(Row)绘制的回调函数
           "rowCallback":null,	
           //该回调函数定义了从哪里和如何读取保存的状态
           "stateLoadCallback":null,
           //状态加载完成之后的回调函数
           "stateLoaded":null,	
           //状态加载完成之后，对数据处理的回调函数
           "stateLoadParams":null,	
           //该回调函数定义了状态该存储在什么地方及如何存储
           "stateSaveCallback":null,
           //对状态进行存储时，对数据处理的回调函数
           "stateSaveParams":null,
           
           "searchCall":null
       };
		
		var _oSelf = this,
    	$this = $(this);
		this.config = $.extend(defaults, _config);
		var table = null;
		this.table = function(){
			if(table != null){
				return table;
			}
		}
		var _init = function(){
			if(_oSelf.config.className != ""){
				table = 
					$this.DataTable({
					   "sPaginationType": "full_numbers",
				       "processing": _oSelf.config.processing,
				       "serverSide": _oSelf.config.serverSide,
				       "language": {
				           "url": _oSelf.config.language
				       },
				       "ajax": {
				           "url": _oSelf.config.ajax,
				           "type": "POST",
				           "data": function(d){
				        	  return _formatData(d);
				           }
				       },
				       "columns":_oSelf.config.columns,
				       "aoColumnDefs": _oSelf.config.aoColumnDefs,
//				       //tfoot的回调函数
//			           "footerCallback":_oSelf.config.footerCallback,
//			           //行被创建时回调函数
//			           "createdRow":_oSelf.config.createdRow,	
			           //表格每次重绘回调函数
			           "drawCallback":_oSelf.config.drawCallback,	
//			           //数字格式化时的回调函数formatNumber不定时一讲
//			           "formatNumber":_oSelf.config.formatNumber, 	
//			           //表格Header显示时的回调函数
//			           "headerCallback":_oSelf.config.headerCallback,	
//			           //表格状态信息改变的回调函数
//			           "infoCallback":_oSelf.config.infoCallback,	
			           //初始化结束后的回调函数s
			           "initComplete":_oSelf.config.initComplete,	
//			           //表格绘制前的回调函数
//			           "preDrawCallback":_oSelf.config.preDrawCallback,	
//			           //表格行(Row)绘制的回调函数
//			           "rowCallback":_oSelf.config.rowCallback,	
//			           //该回调函数定义了从哪里和如何读取保存的状态
//			           "stateLoadCallback":_oSelf.config.stateLoadCallback,
//			           //状态加载完成之后的回调函数
//			           "stateLoaded":_oSelf.config.stateLoaded,	
//			           //状态加载完成之后，对数据处理的回调函数
//			           "stateLoadParams":_oSelf.config.stateLoadParams,	
//			           //该回调函数定义了状态该存储在什么地方及如何存储
//			           "stateSaveCallback":_oSelf.config.stateSaveCallback,
//			           //对状态进行存储时，对数据处理的回调函数
//			           "stateSaveParams":_oSelf.config.stateSaveParams
					});
				if(_oSelf.config.chosen){
					_checkAll();	
				}
				_search();
			}
		}
		
		var _search = function(){
			var targets = _oSelf.config.targets.split(',');
			var ids = _oSelf.config.ids.split(',');
			$.each(targets,function(colIdx){
				$(ids[colIdx]).change( function() {
					 table.columns(targets[colIdx]).search($(this).val()).draw();
				});	
			});
			$.each(targets,function(colIdx){
				$(ids[colIdx]).keyup( function() {
					 table.columns(targets[colIdx]).search($(this).val()).draw();
				});	
			});
		}
		
		var _formatData = function(d){
		   var columns = d.columns;
     	   var data = new Object();
     	   data.draw = d.draw;
     	   data.start = d.start;
     	   data.length = d.length;
     	   data.orderName = columns[d.order[0].column].data;
     	   data.orderDir = d.order[0].dir;
     	   data.search = d.search.value;
     	   var obj = new Object();
     	   for(var i = 0; i < columns.length; i++){
     		   var name = columns[i].data;
     		   var value = columns[i].search.value;
     		   if(name != "" && name != null){
     			   obj[name] = value;
     		   }
     	   }
     	   data.searchObj = JSON.stringify(obj);
     	   data.className = _oSelf.config.className;
		       return data;
		}
		
		var _checkAll = function(){
			var checkAll = "#" + $this.attr("id")+" #checkAll";
			var checkbox = "#" + $this.attr("id")+" input[type=checkbox]";
			$this.each(function() {
				return $(checkAll).click(function() {
					if ($(checkAll).is(":checked")) {
						return $(checkbox).each(function() {
							return $(this).prop("checked", true);
						});
					} else {
						return $(checkbox).each(function() {
							return $(this).prop("checked", false);
						});
					}
				});
			});
		}
		
		_init();
		
		return this;
	}
	
})(jQuery,window)