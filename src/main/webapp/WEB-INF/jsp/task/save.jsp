<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Task Manager</title>

    <!-- Bootstrap -->
    <link href="static/css/bootstrap.min.css" rel="stylesheet">
    <link href="static/css/style.css" rel="stylesheet">

    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
    <div role="navigation">
    	<div class="navbar navbar-inverse">
    		<div class="navbar-collapse collapse">
    			<ul class="nav navbar-nav">
					<li><a href="new-task">新建任务</a></li>
					<li><a href="all-tasks">所有任务</a></li>
    			</ul>
    		</div>
    	</div>
    </div>
    
     
  	<div class="container text-center">
    	<h3>Manage Task</h3>
    	<hr>
    	<form class="form-horizontal" method="POST" action="save-task">
    		<input type="hidden" name="id" value="${task.id}"/>
    		<div class="form-group">
    			<label class="control-label col-md-3">Name</label>
    			<div class="col-md-7">
    				<input type="text" class="form-control" name="name" value="${task.name}"/>
    			</div>
    		</div>
    		<div class="form-group">
    			<label class="control-label col-md-3">Description</label>
    			<div class="col-md-7">
    				<input type="text" class="form-control" name="description" value="${task.description}"/>
    			</div>
    		</div>
    		<div class="form-group">
    			<label class="control-label col-md-3">Finished</label>
    			<div class="col-md-7">
    				<input type="radio" class="col-md-1" name="finished" value="true"/>
    				<div class="col-md-1">Yes</div>
    				<input type="radio" class="col-md-1" name="finished" value="false" checked/>
    				<div class="col-md-1">No</div>
    			</div>
    		</div>
    		<div class="form-group">
    			<input type="submit" class="btn btn-primary" value="Save" />
    		</div>
    	</form>
    </div> 

    <script src="https://cdn.staticfile.org/jquery/3.1.1/jquery.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
  </body>
</html>
