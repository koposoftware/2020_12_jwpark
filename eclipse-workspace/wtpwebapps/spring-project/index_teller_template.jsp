<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>하나 화상창구 서비스</title>
  <link rel="icon" type="image/png" sizes="16x16" href="${ pageContext.request.contextPath }/resources/images/favicon/favicon.ico">
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>
  <script>
  	$("#menu-toggle").click(function(e) {
  		e.preventDefault();
  		$("#wrapper").toggleClass("toggled");
  	});
  </script>
	
</head>
<body>
	<header>
		<%@include file="/WEB-INF/jsp/include/header.jsp" %>
	</header>
	<div class="d-flex" id="wrapper">
		<!-- Sidebar -->
    	<div class="bg-light border-right" id="sidebar-wrapper">
    		<div class="sidebar-heading">Start Bootstrap </div>
    		<div class="list-group list-group-flush">
	    		<a href="#" class="list-group-item list-group-item-action bg-light">Dashboard</a>
    			<a href="#" class="list-group-item list-group-item-action bg-light">Shortcuts</a>
    			<a href="#" class="list-group-item list-group-item-action bg-light">Overview</a>
    			<a href="#" class="list-group-item list-group-item-action bg-light">Events</a>
    			<a href="#" class="list-group-item list-group-item-action bg-light">Profile</a>
    			<a href="#" class="list-group-item list-group-item-action bg-light">Status</a>
    		</div>
    	</div>
    	<!-- /#sidebar-wrapper -->

    	<!-- Page Content -->
    	<div id="page-content-wrapper">
    	
    		<nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
    			 
    			<button class="btn btn-primary" id="menu-toggle">Toggle Menu</button>
    			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    			<span class="navbar-toggler-icon"></span>
    			</button>
    		 	
    			<div class="collapse navbar-collapse" id="navbarSupportedContent">
    				<ul class="navbar-nav ml-auto mt-2 mt-lg-0">
    					<li class="nav-item active">
    						<a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
    					</li>
    					<li class="nav-item">
    						<a class="nav-link" href="#">Link</a>
    					</li>
    					<li class="nav-item dropdown">
    						<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    							Dropdown
    						</a>
    						<div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
    							<a class="dropdown-item" href="#">Action</a>
    							<a class="dropdown-item" href="#">Another action</a>
    							<div class="dropdown-divider"></div>
    							<a class="dropdown-item" href="#">Something else here</a>
    						</div>
    					</li>
    				</ul>
    			</div>
    		</nav>
    	 
    		<div class="container-fluid">
    			<h1 class="mt-4">Simple Sidebar</h1>
    			<p>The starting state of the menu will appear collapsed on smaller screens, and will appear non-collapsed on larger screens. When toggled using the button below, the menu will change.</p>
    			<p>Make sure to keep all page content within the <code>#page-content-wrapper</code>. The top navbar is optional, and just for demonstration. Just create an element with the <code>#menu-toggle</code> ID which will toggle the menu when clicked.</p>
    		</div>
    	</div>
    <!-- /#page-content-wrapper -->
    </div>
</body>

</html>