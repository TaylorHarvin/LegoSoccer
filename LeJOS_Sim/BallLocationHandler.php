<?php
	require_once("includes/connect.php");
	
	$posProvided = 0;
	
	$object = $_GET["object"];
	if(isset($_GET["xPos"])){
		$xPos = $_GET["xPos"];
		$posProvided++;
	}
	
	if(isset($_GET["yPos"])){
		$yPos = $_GET["yPos"];
		$posProvided++;
	}
	
	if($posProvided < 2){
		$objPrepStmt = $dbConn->prepare("select xPos, yPos from positions where object=?");
		$objPrepStmt->bind_param("s",$object);
		$objPrepStmt->execute();
		$objPrepStmt->bind_result($xPos,$yPos);
		if($objPrepStmt->fetch()){
			echo $xPos.','.$yPos;
		}
		else{
			echo "ERROR: no objects!";
		}
	}
	else{
		$objPrepStmt = $dbConn->prepare("update positions set xPos = ?, yPos = ? where object=?");
		$objPrepStmt->bind_param("dds",$xPos,$yPos,$object);
		$objPrepStmt->execute();
	}
	
	
?>