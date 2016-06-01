<?php
	include("config.php");
	$dbConn = mysqli_connect(DB_HOST, DB_USER, DB_PASS, DB_NAME);
	echo $dbConn->error;
	if($dbConn == false){
		echo "ERROR:" .mysqli_connect_error();
		die();
	}
?>