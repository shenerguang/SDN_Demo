<!doctype html>
<html>
    <head>
        
        <title>Xi'an Jiaotong University|MeshSr</title>
		    <meta http-equiv="content-type" content="text/html;charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="author" content="VTHINKXIE">        
        <link rel="stylesheet" href="styles/bootstrap.css">		
        <link rel="stylesheet" href="styles/main.css">
        <link rel="stylesheet" href="styles/fonts.css">
        <link rel="shortcut icon" href="favicon.ico">
    </head>
    <body>   
        <div class="navbar navbar-fixed-top scroll-hide" role="navigation">
          <div class="container-fluid">
            <div class="navbar-header">
              <a class="navbar-brand" href="#"><img src="images/logo.png" height="35" alt=""></a>
              <div class="navbar-option">
                <i class="glyphicon glyphicon-wrench"></i>
                 <i class="glyphicon glyphicon glyphicon-globe"></i>
              </div>              
            </div>
          </div>
        </div>
        <div class="main container-fluid">
            <div class="row full-height">
              <div class="col-md-2">
                  <div class="widget-container control">
                    <div class="btn-group btn-control">
                      <button type="button" class="btn btn-success btn-control dropdown-toggle" data-toggle="dropdown" id="active_flow">
                        Active Flow
                        <span class="caret"></span>
                      </button>
                      <ul class="dropdown-menu btn-control" id="flow_list">                             
                      </ul>
                    </div>    
                    <div class="widget-content" id="flow_des" style="height:40%;">
                    </div>
                    <div class="widget-container table" id="flow_control_container" style="display:none;"> 
                      <div class="widget-container-header">
                        <h1>Flow Control</h1>
                        <div class="option">
                          <i class="glyphicon glyphicon-refresh" id="flow_refresh"></i>
                          <i class="glyphicon glyphicon glyphicon-floppy-disk" id="flow_update"></i>
                          <i class="glyphicon glyphicon glyphicon-floppy-remove" id="flow_cancel"></i>
                        </div>                      
                      </div>
                      <table class="table display">
                        <thead> 
                          <tr>
                            <th>Node Id</th>
                            <th>Meter</th>
                          </tr> 
                        </thead> 
                        <tbody id="flow_control">                                        
                        </tbody>       
                      </table>
                    </div>                                                       
                  </div>
                  <div class="widget-container control">
                    <div class="btn-group btn-control">
                      <button type="button" class="btn btn-success btn-control dropdown-toggle" data-toggle="dropdown" id="active_switch">
                        Active Switch
                        <span class="caret"></span>
                      </button>
                      <ul class="dropdown-menu btn-control" id="switch_list">
                      </ul>
                    </div>
                    <div class="widget-content" id="switch_des">
                    </div>                            
                  </div>
              </div>                   
              <div class="col-md-10">              
                <div class="widget-container topo">
                  <div class="widget-container-header">
                    <h1>Connection Topology</h1>
                    <div class="option">
                      <i class="glyphicon glyphicon-refresh" id="topo_refresh"></i>
                      <i class="glyphicon glyphicon-eye-close" id="topo_none"></i>
                      <i class="glyphicon glyphicon-eye-open" id="topo_all"></i>
                    </div>
                  </div>
                  <div id="mesh_topo"></div>                    
                </div>  
                <div class="row">
                  <div class="col-md-12" id="node_control_container">
                    <div class="widget-container table">
                      <div class="widget-container-header">
                        <h1>Node Control</h1>
                        <div class="option">
                          <i class="glyphicon glyphicon-refresh"></i>
                          <i class="glyphicon glyphicon glyphicon-floppy-disk"></i>
                          <i class="glyphicon glyphicon glyphicon-floppy-remove"></i>
                        </div>                                 
                      </div>
                      <table class="table display">
                        <thead> 
                          <tr>
                            <th>Index One</th>
                            <th>Index Two</th>
                            <th>Index Three</th>
                          </tr> 
                        </thead> 
                        <tbody> 
                          <tr>
                            <th>Index One</th>
                            <th>Index Two</th>
                            <th>Index Three</th>
                          </tr> 
                          <tr>
                            <th>Index One</th>
                            <th>Index Two</th>
                            <th>Index Three</th>
                          </tr> 
                          <tr>
                            <th>Index One</th>
                            <th>Index Two</th>
                            <th>Index Three</th>
                          </tr>
                        </tbody>    
                      </table>
                    </div>                
                  </div>
                </div>              
              </div>       
            </div>

        </div>

	
        
        <!-- DEP -->
	    <script src="scripts/lib/jquery-1.9.0.js"></script>
		<script src="scripts/lib/jquery-ui-1.9.2-min.js"></script>
        <script src="scripts/lib/jquery.ui.touch-punch.min.js"></script>        
        <script src="scripts/lib/bootstrap.min.js"></script>
		<!-- /DEP -->

				
		<!-- JS -->
		<!-- support lib for bezier stuff -->
		<script src="scripts/lib/jsBezier-0.6.js"></script>     
        <!-- jsplumb geom functions -->   
        <script src="scripts/lib/jsplumb-geom-0.1.js"></script>
		<!-- jsplumb util -->
		<script src="scripts/src/util.js"></script>
        <!-- base DOM adapter -->
		<script src="scripts/src/dom-adapter.js"></script>        
		<!-- main jsplumb engine -->
		<script src="scripts/src/jsPlumb.js"></script>
        <!-- endpoint -->
		<script src="scripts/src/endpoint.js"></script>                
        <!-- connection -->
		<script src="scripts/src/connection.js"></script>
        <!-- anchors -->
		<script src="scripts/src/anchors.js"></script>        
		<!-- connectors, endpoint and overlays  -->
		<script src="scripts/src/defaults.js"></script>
        <!-- bezier connectors -->
        <script src="scripts/src/connectors-bezier.js"></script>
		<!-- state machine connectors -->
		<script src="scripts/src/connectors-statemachine.js"></script>
        <!-- flowchart connectors -->
		<script src="scripts/src/connectors-flowchart.js"></script>
        <script src="scripts/src/connector-editors.js"></script>
		<!-- SVG renderer -->
		<script src="scripts/src/renderers-svg.js"></script>
		<!-- canvas renderer -->
		<script src="scripts/src/renderers-canvas.js"></script>
		<!-- vml renderer -->
		<script src="scripts/src/renderers-vml.js"></script>
        
        <!-- jquery jsPlumb adapter -->
		<script src="scripts/src/jquery.jsPlumb.js"></script>
		<!-- /JS -->
		
		<!--  demo code -->
		<script src="scripts/setup.js"></script>
    </body>
</html>
