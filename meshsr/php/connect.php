<?php
error_reporting(E_ALL ^ E_NOTICE);

if(!defined('INCLUDE_CHECK')) die('You are not allowed to execute this file directly');
/* Database config */

$db_host		= '127.0.0.1';
$db_user		= 'root';
$db_pass		= 'mysql';
$db_database	= 'meshsr'; 

/* End config */



$link = mysql_connect($db_host,$db_user,$db_pass) or die('Unable to establish a DB connection');

mysql_select_db($db_database,$link);
mysql_query("SET names UTF8");

?>
