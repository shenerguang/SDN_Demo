<?php
    define('INCLUDE_CHECK',true);
    require_once('connect.php');
    $flow_info = $_POST["flow_info"];
    if(!$flow_info)
        $flow_info='default';

    $sql_nodes="select node_id,x,y,type,des from meshsr_node";
    $query_nodes = mysql_query ($sql_nodes);
    $nodes=array();
    while($row = mysql_fetch_object($query_nodes)){
        if($row->type == 0)
            $row->type = 'switch';
        else if($row->type == 1)
            $row->type ='host';         
        $nodes[]=$row;
    }   

    $sql_connection="select connect_info,des from meshsr_connection where flow_info='".mysql_real_escape_string($flow_info)."'";
    $query_connection = mysql_query ($sql_connection);
    $connection=array();
    while($row = mysql_fetch_object($query_connection)){
        $connection = $row->connect_info;
    }   

    $sql_flow="select flow_info,des from meshsr_connection order by id desc";
    $query_flow = mysql_query ($sql_flow);
    $flow=array();
    while($row = mysql_fetch_object($query_flow)){
        $flow[] = $row;
    }   

    $res=array();
    $res["nodes"]=$nodes;
    $res["connections"]=$connection;
    $res["flow"]=$flow;
    header("Content-type","applicaton/json");
    echo json_encode($res);     
    exit;
?>