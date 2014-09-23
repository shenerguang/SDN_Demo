/*Draw MeshSr Topo*/
function drawMeshTopo (Nodes,Connections) {
	$("#mesh_topo").html("");	
	jsPlumb.deleteEveryEndpoint();
	createNodes(Nodes);
	connectNodes(Connections);
}

function createDiv(nodeId,nodeX,nodeY,nodeType,nodeDes) {
	return '<div class="node '+nodeType+'" data-id="' + nodeId + '" data-toggle="popover" data-original-title="' +nodeId+ '" data-content="' +nodeDes+ '" style="left:'+nodeX/10+'%;bottom:'+nodeY/10+'%;"><strong>' 
	        + nodeId+ '</strong></div>'
}
function createNodes(Nodes) {
	
	if (Nodes == null) {
		return ;
	}
	var topoRegion = $('#mesh_topo');

	for (var i = 0; i < Nodes.length; i++) {
		var nodeId 	= Nodes[i].node_id;
		var nodeX	= Nodes[i].x;
		var nodeY	= Nodes[i].y;
		var nodeType = Nodes[i].type;
		var nodeDes	 = Nodes[i].des;
		
		// 自动生成并插入根节点的 DIV 
		var divStr = createDiv(nodeId,nodeX,nodeY,nodeType,nodeDes);
		topoRegion.append(divStr);
	};

}
function connectNodes (Connections) {
		jsPlumb.draggable(jsPlumb.getSelector(".node"), { grid: [5, 5] });	
		var shapes = jsPlumb.getSelector(".node");	
		var dis = {
			connector:"Straight",
			paintStyle:{ lineWidth:4, strokeStyle:"#aaaaaa", "dashstyle":"2 4"},
			endpoint:[ "Dot", { radius:3 } ],
			endpointStyle:{ fillStyle:"#aaaaaa" },
			container:"mesh_topo",
			anchors:[
				[ "Perimeter", { shape:"Rectangle" }],
				[ "Perimeter", { shape:"Rectangle" }]
			]
		};
		var con = {
			connector:"Straight",
			paintStyle:{ lineWidth:4, strokeStyle:"#7cc53a"},
			endpoint:[ "Dot", { radius:3 } ],
			endpointStyle:{ fillStyle:"#aaaaaa" },
			container:"mesh_topo",
			anchors:[
				[ "Perimeter", { shape:"Rectangle" }],
				[ "Perimeter", { shape:"Rectangle" }]
			]
		};			

		for (var m = 0; m < Connections.length; m++) {
			var beginNodeId = Connections[m].bid;
			var endNodeId = Connections[m].eid;
			var connectType = Connections[m].type;
			for (var i = 0; i < shapes.length; i++) {
				if(shapes[i].getAttribute("data-id")==beginNodeId)
					break;
			};
			for (var j = 0; j < shapes.length; j++) {
				if(shapes[j].getAttribute("data-id")==endNodeId)
					break;
			};
			switch (connectType) {
			    case "dis":	
					jsPlumb.connect({source:shapes[i],target:shapes[j]},dis);
					break;
				case "con":
					var currentconnection = jsPlumb.connect({source:shapes[i],target:shapes[j]},con);									
					break;
			    default:
			    	break;	
			    }			
		};
}
function initbutton (data) {
	var flow_list='';
	$("#flow_list").html("");
	$("#switch_list").html("");
	for (var i = 0; i < data.flow.length; i++) {
	  flow_list = '<li><a href="#" data-des="'+data.flow[i].des+'">'+data.flow[i].flow_info+'</a></li>'+flow_list;
	};
	$("#flow_list").html(flow_list);
	var switch_list='';
	for (var i = 0; i < data.nodes.length; i++) {
	  switch_list = '<li><a href="#" data-des="'+data.nodes[i].des+'">'+data.nodes[i].node_id+'</a></li>'+switch_list;
	};        
	$("#switch_list").html(switch_list);
}
function inittopo(data){
	var Nodes = data.nodes;
	var Connections = eval('(' + data.connections + ')');
	initbutton(data);
	drawMeshTopo(Nodes,Connections);
}

function initflow(data){
	if(data){
	  var data = eval('(' + data + ')');
	  var flow_html = '';
	  for (var i = 0; i < data.length; i++) {
	    //if(i==0||i==data.length-1)
	    //  flow_html = flow_html +'<tr><th>' + data[i].nid +'</th><th>' + data[i].meter +'</th></tr>';
	    //else
	      flow_html = flow_html +'<tr class="editable"><th>' + data[i].nid +'</th><th>' + data[i].meter +'</th></tr>';                 
	  }  

	  $("#flow_control").html(flow_html);     
	  // $("#node_control_container").removeClass("col-md-12").addClass("col-md-8");   
	  $("#flow_control_container").show();  
	}
	else{
	  // $("#node_control_container").removeClass("col-md-8").addClass("col-md-12");   
	  $("#flow_control_container").hide();            
	}
}

function topo_refresh(){
  $("#mesh_topo").html("");
  $.post("php/ptopo.php",inittopo,"json");
}
function topo_all(){
  $("#mesh_topo").html("");
  $.post("php/ptopo.php",{flow_info:'all'},inittopo,"json");
}
function topo_none(){
  $("#mesh_topo").html("");
  $.post("php/ptopo.php",{flow_info:'default'},inittopo,"json");
}   

function flow_update(){
	var json_result = '';
	var trs = $("#flow_control").find("tr");
	for (var i = 0; i < trs.length; i++) {
	  json_result = json_result+'{"nid":"'+ $(trs[i]).find("th:eq(0)").text()+'",';
	  json_result = json_result+'"meter":"'+ $(trs[i]).find("th:eq(1)").text()+'"},';           
	};
	json_result='['+json_result.substring(0,json_result.length-1)+']';
	$.ajax({     
	    type:"POST",     
	    dataType:"html",     
	    url:"php/pflow.php",
	    data:{flow_info:$("#active_flow").text(),update:1,control_node:json_result},  
	    success:function(data){     
	      alert("设置成功");
	    },      
	    error:function(data){   
	      alert("设置失败");  
	   }     
	         
});                
}
function flow_refresh(){
	$.post("php/pflow.php",{flow_info:$("#active_flow").text(),show:1},initflow,"json");  
}
function flow_cancel(){
	$.post("php/pflow.php",{flow_info:$("#active_flow").text(),show:1},initflow,"json");         
}

function click_update(){
	$("#flow_control").find(".editable").find("th:eq(1)").dblclick(function(){
	//$("#flow_control").find("th:eq(1)").dblclick(function(){		
	    var target = $(this);
	    var input_html = '<input class="mod_input" type="text" placeholder = "'+ $(target).text() +'">';
	    $(target).html(input_html);
	    $(target).find(".mod_input").focus();
	    $(target).find(".mod_input").keyup(function(e){
	      if(e.keyCode == 13){
	        $(target).html($(this).val());
	      }
	    });
	    $(document).click(function(){
	      $(target).html($(target).find(".mod_input").val());
	    });      
	  });  
}         
jsPlumb.bind("ready", function() {
	$.post("php/ptopo.php",inittopo,"json");
	// setInterval("location.reload()",6000);
	$("#topo_refresh").on("click",function(){
	  topo_refresh();
	});    
	$("#topo_all").on("click",function(){
	  topo_all();
	});  
	$("#topo_none").on("click",function(){
	  topo_none();
	});    
	$("#flow_update").on("click",function(e){
	  e.preventDefault();
	  flow_update();
	});     
	$("#flow_refresh").on("click",function(){
	  flow_refresh();
	}); 
	$("#flow_cancel").on("click",function(){
	  flow_cancel();
	});
	$(window).resize(function(){
	    jsPlumb.repaintEverything();
	});                                                        
});
$(document).ajaxComplete(function(){
	$("#flow_list").find("a").on("click",function () {
	  $("#active_flow").text($(this).text());
	  $("#mesh_topo").html("");
	  $.post("php/pflow.php",{flow_info:$(this).text(),show:1},initflow,"json");          
	  $("#mesh_topo").html("");
	  $.post("php/ptopo.php",{flow_info:$(this).text()},inittopo,"json");
	  $("#flow_des").text($(this).attr("data-des"));
	});

	$("#switch_list").find("a").on("click",function () {
	  $("#active_switch").text($(this).text());
	  $("#switch_des").text($(this).attr("data-des"));
	});

	$('.node').popover();

	click_update();
});  
