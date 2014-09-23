<?php
    define('INCLUDE_CHECK',true);
    require_once('connect.php');
    $flow_info = $_POST["flow_info"];
    if(!$flow_info)
        $flow_info='default';
    $control_node = $_POST["control_node"];

    $is_show = $_POST["show"];
    $is_update = $_POST["update"];


    if($is_show){
        $sql_show="select control_node from meshsr_connection where flow_info='".mysql_real_escape_string($flow_info)."'";
        $query_show = mysql_query ($sql_show);
        $control_node=array();
        while($row = mysql_fetch_object($query_show)){
            $control_node = $row->control_node;
        }   
        header("Content-type","applicaton/json");
        echo json_encode($control_node);     
        exit;        
    }
    if($is_update){
        $sql_update="update meshsr_connection set control_node ='".$control_node."'  where flow_info='".mysql_real_escape_string($flow_info)."'";
        $query_update= mysql_query ($sql_update);  
        echo $sql_update;
        exit;        
    }
?>
