<%@page import="in.jdsoft.studentmanagement.model.UserManagement"%>
<%@page import="in.jdsoft.studentmanagement.controller.UserManagementController"%>
<%@page import="in.jdsoft.studentmanagement.model.Courses"%>
<%@page import="java.util.Iterator"%>
<%@page import="in.jdsoft.studentmanagement.controller.CourseController"%>
<%@page import="java.util.ArrayList"%>
<%@page errorPage="error.jsp" %>
<%
		if(session.getAttribute("authenticated")!="true"){
		response.sendRedirect("user_login.jsp");
		  }
		else{%>
  		
   		<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>User Management</title>

    <!-- Bootstrap core CSS -->

    <link href="css/bootstrap.min.css" rel="stylesheet">

    <link href="fonts/css/font-awesome.min.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">

    <!-- Custom styling plus plugins -->
    <link href="css/custom.css" rel="stylesheet">
    <link href="css/icheck/flat/green.css" rel="stylesheet">
    <link href="css/datatables/tools/css/dataTables.tableTools.css" rel="stylesheet">

    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script> 
    <script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script type = "text/javascript">
         $(document).ready(function() {
        	 $("#tr").click(function(){
        		 
        		 
        		   $('#demo').validate({
        				   submitHandler: function(form) {
        			      
        			          

        	        			$('#usermanagement').modal('show');
        			        
        			            return true;     
        			        }
        			    });	   
        		   
        		  
        	  
         });
         });
      </script>
    

</head>

<body class="nav-md">
    <div class="container body">
    <div class="main_container" >
        <%@ include file="master_menu.jsp" %>
   		<%@ include file="master_header.jsp" %>
<div class="right_col" role="main">
  <div class="">
                    
                        <div id="addUser"  style="height:500px;display: none;">
                        <div class="page-title">
                        <div class="title_left">
                            <h3>
                    Manage Users
       
                </h3></div>
                        </div>
                          <div class="x_title">
 				  
 				  <div class="clearfix">
 				  </div>
 				  </div>
                        <div  class="x_panel">
                        
                         <div class="x_content">
                                   <br />
                         <form id="demo" data-parsley-validate class="form-horizontal form-label-left" action="${pageContext.request.contextPath}/UserManagementServlet" method="post">
                             <!-- start of form-group 1 -->
                             <div class="form-group">
                                  <label class="control-label col-md-3 col-sm-3 col-xs-12" for="user-name"> Name <span class="required">*</span>
                                   </label>
                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                         <input name="user-name" type="text" id="username" required class="form-control col-md-7 col-xs-12">
                                     </div>
                              </div>
                              <div class="form-group">
                                  <label class="control-label col-md-3 col-sm-3 col-xs-12" for="user-email"> Email(User Name) <span class="required">*</span>
                                   </label>
                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                         <input name="user-email" type="text" id="useremail" required class="form-control col-md-7 col-xs-12">
                                     </div>
                              </div>
                              <div class="form-group">
                                  <label class="control-label col-md-3 col-sm-3 col-xs-12" for="user-password">Password <span class="required">*</span>
                                   </label>
                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                         <input name="user-password" type="password" id="userpassword" required class="form-control col-md-7 col-xs-12">
                                     </div>
                                     </div>
                            
                                         <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="user-status">Status</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <select class="form-control" name="user-status">
                                                	<% 
                                                	 UserManagementController usermanagementcontroller=new UserManagementController();
                                                	   ArrayList<UserManagement> userStatusList=usermanagementcontroller.getUserStatus();
                                		      			for(UserManagement userstatus: userStatusList){%>
                                		          			<option value="<%out.print(userstatus.getUserStatusId());%>"><%out.print(userstatus.getUserStatusTitle()); %></option>
                                		      			<%}%>
                                                </select>
                                            </div>
                                        </div>
                               <div class="form-group"><!-- start of form group 5 -->
                           <!-- start of col-md-6 col-sm-6 col-xs-12 col-md-offset-3 -->
                              <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                             <button type="button" class="btn  btn-danger btn-sm" name="" onclick="showUserManagementDiv();">Cancel</button>               
                              <button type="reset" class="btn btn-primary btn-sm" name="">Clear</button>
                              <button type="submit" id="tr" name="createuser" class="btn  btn-info btn-sm" name="">Create</button>
                              
                                             
                                </div><!-- end of col-md-6 col-sm-6 col-xs-12 col-md-offset-3 -->
                            </div><!-- end of form group 5 -->
                                
                              </form>
                               <div class="modal fade" id="usermanagement" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">�</span>
                                                </button>
               <h4>Confirmation?</h4> 
            </div>
            <div class="modal-body">
                <h5>Are you sure?, You want to create a new user ??</h5>
            </div>
            <div class="modal-footer">
                
                <button type="button" class="btn btn-round btn-success" >Yes</button>
                
            </div>
        </div>
    </div>
</div>
                              
                               
        </div>      
        </div>               
        </div>
        
        <div id="dispUser" style="display:block;"> <br>
          <br />
 				<h3>User Management</h3>
 				<div class="x_title">
 				  <div class="clearfix">
 				  </div>
 				</div> 
 				  <div class="x_title">
 				  <div class="clearfix">
 				  <input type="button" class="btn btn-primary" name="addGroup" value="CREATE USER" onclick="showUserManagementDiv();"/>
 				  </div>
 				</div>
 				<%
 				  UserManagement users=new UserManagement();
 				  UserManagementController userController=new UserManagementController();
 				   ArrayList<UserManagement> usersList=  userController.getUsersList();%>
 					
 					<h3>Users Created[0]</h3>
     					<div class="row">
          					<div class="col-md-12 col-sm-12 col-xs-12">
             					<div class="x_panel">
             					      <div class="x_content">
             					      <div class="table-responsive">
                                    <table id="example" class="table table-striped responsive-utilities jambo_table">
                                        <thead>
                                            <tr class="headings">
                                                <th>User Name </th>
                                                <th>User Id</th>
                                                <th>User Status </th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        
                                        <tbody>
                                         
                                           <tr class="even pointer">
                                              <td class=" ">Nikil</td>
                                              <td class=" ">nikil@gmail.com</td>
                                              <td class=" ">Active</td>
                                              <td style="width: 250px">
                                             
                                                <a href="#"  data-href="#" data-id="" class="btn btn-warning btn-sm" data-toggle="modal" data-target="#confirm-edit">
                           <span class="glyphicon glyphicon-edit"></span> 
                   </a>
                   <a href="#"  data-href="#" data-id="" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#confirm-delete">
                           <span class="glyphicon glyphicon-trash"></span> 
                   </a>
                                 						
                                              </td>
                                          </tr>	 
                                        
                                        </tbody>
									 </table>
									 </div>
                                </div>
             					
               					
                                </div>
                                <div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">�</span>
                                                </button>
               <h4>Confirmation?</h4> 
            </div>
            <div class="modal-body">
                <h5>Are you sure ?, You want to delete this User???</h5>
            </div>
            <div class="modal-footer">
                
                <button class="btn btn-round btn-danger" data-dismiss="modal" onclick="new PNotify({
                                title: 'Notification',
                                text: 'successfully deleted',
                                type: 'success'
                            });">Delete</button>
                
            </div>
        </div>
    </div>
</div>
                            </div>
                        </div>
                        <div class="modal fade" id="confirm-edit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">�</span>
                                                </button>
               <h4>Edit User</h4> 
            </div>
            <div class="modal-body">
                 <form class="form-horizontal" role="form">
                  		    <div class="form-group">
                                  <label class="control-label col-md-3 col-sm-3 col-xs-12" for="user-name"> Name <span class="required">*</span>
                                   </label>
                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                         <input name="user-name" type="text" id="username" required class="form-control col-md-7 col-xs-12">
                                     </div>
                              </div>
                              <div class="form-group">
                                  <label class="control-label col-md-3 col-sm-3 col-xs-12" for="user-email"> Email(User Name) <span class="required">*</span>
                                   </label>
                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                         <input name="user-email" type="text" id="useremail" required class="form-control col-md-7 col-xs-12">
                                     </div>
                              </div>
                              <div class="form-group">
                                  <label class="control-label col-md-3 col-sm-3 col-xs-12" for="user-password">Password <span class="required">*</span>
                                   </label>
                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                         <input name="user-password" type="password" id="userpasword" required class="form-control col-md-7 col-xs-12">
                                     </div>
                                     </div>
                             
                                         <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="user-status">Status</label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <select class="form-control" name="user-status">
                                                	<% 
                                                	 UserManagementController usermanagementcontroller1=new UserManagementController();
                                                	   ArrayList<UserManagement> userStatusList1=usermanagementcontroller1.getUserStatus();
                                		      			for(UserManagement userstatus: userStatusList1){%>
                                		          			<option value="<%out.print(userstatus.getUserStatusId());%>"><%out.print(userstatus.getUserStatusTitle()); %></option>
                                		      			<%}%>
                                                </select>
                                            </div>
                                            </div>
                        <div class="modal-footer">
                        
                		<button type="submit" class="btn btn-round btn-success" data-dismiss="modal" onclick="new PNotify({
                                title: 'Notification:',
                                text: ' Successfully Updated',
                                type: 'success'
                            });">Update</button>
                      </div>
                 </form>
                 
                 
            
        
                 
    
            </div>
            
        </div>
    </div>
</div>
                        
  </div><!-- end of LisDiv div -->
        
        
        
        
        
        
        
</div>
</div>
</div>
</div>


        <script src="js/bootstrap.min.js"></script>

        <!-- chart js -->
        <script src="js/chartjs/chart.min.js"></script>
        <!-- bootstrap progress js -->
        <script src="js/progressbar/bootstrap-progressbar.min.js"></script>
        <script src="js/nicescroll/jquery.nicescroll.min.js"></script>
        <!-- icheck -->
        <script src="js/icheck/icheck.min.js"></script>

        <script src="js/custom.js"></script>
        <!-- formHide jquery -->
  		  <script type="text/javascript" src="js/formHide.js"></script>
 	    <!-- /formHide jquery -->

        <!-- Datatables -->
        <script src="js/datatables/js/jquery.dataTables.js"></script>
        <script src="js/datatables/tools/js/dataTables.tableTools.js"></script>
        <script>
            $(document).ready(function () {
                $('input.tableflat').iCheck({
                    checkboxClass: 'icheckbox_flat-green',
                    radioClass: 'iradio_flat-green'
                });
            });

            var asInitVals = new Array();
            $(document).ready(function () {
                var oTable = $('#example').dataTable({
                    "oLanguage": {
                        "sSearch": "Search all columns:"
                    },
                    "aoColumnDefs": [
                        {
                            'bSortable': false,
                            'aTargets': [0]
                        } //disables sorting for column one
            ],
                    'iDisplayLength': 12,
                    "sPaginationType": "full_numbers",
                    "dom": 'T<"clear">lfrtip',
                    "tableTools": {
                        "sSwfPath": "<?php echo base_url('assets2/js/Datatables/tools/swf/copy_csv_xls_pdf.swf'); ?>"
                    }
                });
                $("tfoot input").keyup(function () {
                    /* Filter on the column based on the index of this element's parent <th> */
                    oTable.fnFilter(this.value, $("tfoot th").index($(this).parent()));
                });
                $("tfoot input").each(function (i) {
                    asInitVals[i] = this.value;
                });
                $("tfoot input").focus(function () {
                    if (this.className == "search_init") {
                        this.className = "";
                        this.value = "";
                    }
                });
                $("tfoot input").blur(function (i) {
                    if (this.value == "") {
                        this.className = "search_init";
                        this.value = asInitVals[$("tfoot input").index(this)];
                    }
                });
            });
        </script>
        
     
         <!-- PNotify -->
    <script type="text/javascript" src="js/notify/pnotify.core.js"></script>
    <script type="text/javascript" src="js/notify/pnotify.buttons.js"></script>
    <script type="text/javascript" src="js/notify/pnotify.nonblock.js"></script>
     
            

</body>
</html>
 <%}%>