<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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

	<div class="container text-center" id="tasksDiv">
		<h3>My Tasks</h3>
		<hr>
		<div class="table-responsive">
			<table class="table table-striped table-bordered text-left">
				<thead>
					<tr>
						<th>Id</th>
						<th>Name</th>
						<th>Description</th>
						<th>Date Created</th>
						<th>Finished</th>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="task" items="${tasks}">
						<tr>
							<td>${task.id}</td>
							<td>${task.name}</td>
							<td>${task.description}</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
									value="${task.dateCreated}" /></td>
							<td>${task.finished}</td>
							<td><a href="update-task?id=${task.id}"><span
									class="glyphicon glyphicon-pencil"></span></a></td>
							<td><a href="delete-task?id=${task.id}"><span
									class="glyphicon glyphicon-trash"></span></a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

	<script
		src="https://cdn.staticfile.org/jquery/3.1.1/jquery.min.js"></script>
	<script src="static/js/bootstrap.min.js"></script>
</body>
</html>
