<?php
	include("sessionGenerator.php");
	generateSession();
?>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="includes/bootstrap-3.3.4-dist/css/bootstrap.min.css">
		<script src="includes/jquery/jquery-2.1.4.js"></script>
		<script src="includes/bootstrap-3.3.4-dist/js/bootstrap.min.js"></script>
		<nav class="navbar navbar-inverse">
		  <div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="#">Knowledge Repo</a>
			</div>
				<div>
					<ul class="nav navbar-nav">
						<?php
							if(!isset($_SESSION['username'])){
								echo'<li class="active"><a href="login.php">Home</a></li>';
							}
							else{
								echo'
									<li class="active"><a href="home_AJ.php">Home</a></li>
									<li class="active"><a href="createUser.php">Create User</a></li>
									<li class="active"><a href="createTopic.php">Create Topic</a></li>
									<li class="active"><a href="search_AJ.php">Search</a></li>
									<li class="active"><a href="logout.php">Logout</a></li>
								';
							}
						?>
					</ul>
				</div>
			</div>
		</nav>
	</head>
</html>