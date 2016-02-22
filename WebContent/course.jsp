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
<head><!-- Bootstrap CSS -->    
     <title>Courses</title>
   <link href="css/bootstrap.min.css" rel="stylesheet">
   <link href="fonts/css/font-awesome.min.css" rel="stylesheet">
   <link href="css/animate.min.css" rel="stylesheet">
    <!-- Custom styling plus plugins -->
    <link href="css/custom.css" rel="stylesheet">
    <link href="css/icheck/flat/green.css" rel="stylesheet">
    <link href="css/shadow.css" rel="stylesheet">
    <!-- editor -->
    <link href="http://netdna.bootstrapcdn.com/font-awesome/3.0.2/css/font-awesome.css" rel="stylesheet">
    <link href="css/editor/external/google-code-prettify/prettify.css" rel="stylesheet">
    <link href="css/editor/index.css" rel="stylesheet">
    <!-- select2 -->
    <link href="css/select/select2.min.css" rel="stylesheet">
    <link rel="stylesheet" href="http://jqueryvalidation.org/files/demo/site-demos.css">
    <!-- switchery -->
    <link rel="stylesheet" href="css/switchery/switchery.min.css" />
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="//oss.maxcdn.com/bootbox/4.2.0/bootbox.min.js"></script>
    <script src="//code.jquery.com/jquery-1.8.2.min.js"></script> 
    <script type = "text/javascript"  src = "http://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
     <script src="js/mycustom/autosearch.js" ></script>
     <script src="js/mycustom/crud.js" ></script>
      <script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
      <script type = "text/javascript">
         $(document).ready(function() {
        	 
        	 //deleting course
        	 $('#courselist td a#delete').click(function() {
        		   var courseid = $(this).attr('data-id');
        		   $('#confirm-delete').on('show.bs.modal', function (e) {
        			   $('#deleteCourse').attr("href", "CourseServlet?courseId="+courseid+"&action=delete");
        			});
        		   
        		});
        	 
        	//adding course
        	 $("#coursevalid").click(function(event){
        			
        		 $('#democourse').validate({
  				   submitHandler: function(form) {
                    $('#testcourse').modal('show');
  	        		 $('#newCourse').click(function(){
  	             		 
  	             		 var data=$('#democourse').serialize()+"&action=save";
  	             		 $.post("CourseServlet",data,function(data) {
  	             			 window.location.href="course.jsp";
  	                      });
  	             	});
  			            return false;     
  			        }
  			    });	   
        		 
        	 });
        	
        	//edit
        	 $('#courselist td a#edit').click(function() {
        		var courseid = $(this).attr('data-id');
        		
        		//retrive to display
        	   $('#confirm-edit').on('show.bs.modal', function (e) {
      			 $.get('CourseServlet',{action:"reterive",courseId:courseid},function(response){
      				  $("#edityear").val(response.duration_in_years);
     		    	  $("#editcoursename").val(response.course_name);
     		    	  $("#editsem").val(response.duration_in_semesters);
     		    	
     		      });
      			//update code
      			
      			 $("#updateCourse").click(function(event){
      				 var data=$('#courseUpdateModal').serialize()+"&action=update"+"&courseId="+courseid;
	             		 $.post("CourseServlet",data,function(data) {
	             			 window.location.href="course.jsp";
	                      });
      			   });
      			});
        	});
         });
      </script>
    <script type="text/javascript">
      
      
      function isNumber(evt) {
  	    evt = (evt) ? evt : window.event;
  	    var charCode = (evt.which) ? evt.which : evt.keyCode;
  	    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
  	        return false;
  	    }
  	    return true;
  	}
  	
      
      
      
      </script>
     
</head>
<body class="nav-md">
  <div class="container body">
    <div class="main_container">
    <%@ include file="master_menu.jsp" %>
   		<%@ include file="master_header.jsp" %>
      <div class="right_col" role="main" >
        <div id="ListDiv" style="display:block;"> <br>
          <br />
 				<h3>Courses</h3>
 				<div class="x_title">
 				  <div class="clearfix">
 				  </div>
 				</div> 
 				  <div class="x_title">
 				  <div class="clearfix">
 				  <button type="button" class="btn btn-primary col-md-3" name="addCourse" onclick="showDiv()"><span class="glyphicon glyphicon-plus-sign" ></span>  Add Course</button>
 				  <button type="button" class="btn btn-success col-md-3" name="importExcel" onclick="PrintElem('#printList')"><span class="glyphicon glyphicon-upload" ></span>  Export Excel</button>
 				  <button type="button" class="btn btn-warning col-md-3" name="print"><span class="glyphicon glyphicon-print" ></span>  Print</button>
 				  <input type="text" class="form-control col-md-2" id="search" placeholder="Course Search " style="width: 150px;margin-left: 100px"/>
 				  </div>
 				</div>
 					<%
 		    CourseController courseController=new CourseController();
 			ArrayList<Courses> courses=courseController.viewCourse();
 			int courseCount=courses.size();%>
 			<h3>Courses[<%out.print(courseCount);%>]</h3>
 			
 	<div  class="x_panel">
 	<div  id="printList" class="table-responsive">
    <table id="courselist" class="table table-bordered table-striped">
        <thead >
            <tr>
                <th>S.NO</th>
                <th>Course Code</th>
                <th>Course Name</th>
                <th>Years/Semesters</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <%
 			if(courseCount>0){
 				int SNO=1;
 				for(Courses course:courses){	
 		%>
            <tr id="courseList">
                <td><%out.print(SNO);%></td>
                <td style="width: 120px"><%out.print("COU"+course.getCourseId());%></td>
                <td><%out.print(course.getCourseName());%></td>
                <td style="width:50px"><%out.print(course.getDurationInYears()+"/"+course.getDurationInSemester());%></td>
                <td style="width: 250px">
                
                   <a href="#" id="edit"  data-href="#" data-id="<%out.print(course.getCourseId());%>" class="btn btn-warning btn-sm" data-toggle="modal" data-target="#confirm-edit">
                           <span class="glyphicon glyphicon-edit"></span> 
                   </a>
                   <a href="#"  id="delete" data-href="#" data-id="<%out.print(course.getCourseId());%>" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#confirm-delete">
                           <span class="glyphicon glyphicon-trash"></span> 
                   </a>
                </td>
            </tr>
           <% SNO++;}
           }
           else{%>
        	   <tr>
                <td colspan="5" align="center">No Courses Available</td>
              </tr>
          <% }%>
        </tbody>
    </table>
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
                <h5>Are you sure ?, You want to delete this course ??</h5>
            </div>
            <div class="modal-footer" id="deletemodalfooter">
            <a  id="deleteCourse" class="btn btn-round btn-danger"  role="button">delete</a>
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
               <h4>Edit Course</h4> 
            </div>
            <div class="modal-body">
                 <form class="form-horizontal" id="courseUpdateModal" role="form">
                  		<div class="form-group">
                    	  <label  class="col-sm-3 control-label" for="editcoursename">Course Name</label>
                    	    <div class="col-sm-9">
                        		<input type="text" class="form-control" name="editcoursename" id="editcoursename" placeholder=""  required="required" />
                            </div>
                        </div>
                        <div class="form-group">
                    	  <label  class="col-sm-3 control-label" for="edityear">Duration in Years</label>
                    	    <div class="col-sm-9">
                        		<input type="text" class="form-control" name="edityear" id="edityear" placeholder="" required="required"/>
                            </div>
                        </div>
                        <div class="form-group">
                    	  <label  class="col-sm-3 control-label" for="editsem">Semesters</label>
                    	    <div class="col-sm-9">
                        		<input type="text" class="form-control" name="editsem" id="editsem" placeholder="" required="required" onkeypress="return isNumber(event)"/>
                            </div>
                        </div>
                        
                        <div class="modal-footer">
                        
                		<button type="button" id="updateCourse" class="btn btn-round btn-success">Update</button>
                      </div>
                 </form>
    
            </div>
            
        </div>
    </div>
</div>






     
<!-- The form which is used to populate the item data -->

  </div><!-- end of LisDiv div -->
                                
	<div id="FormDiv" style="display: none;"> 
       <div class="clearfix"></div><!-- end of clearfix div -->
           <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                 <div class="x_panel" style="height:500px;">
                    <div class="x_title">
                               <h2>ADD COURSE <small>(add new course)</small></h2>
                                   <div class="clearfix"></div>
                     </div><!-- end of x_title div -->
                      <div class="x_content">
                                   <br />
                         <form id="democourse"  class="form-horizontal form-label-left">
                             <!-- start of form-group 1 -->
                             <div class="form-group">
                                  <label class="control-label col-md-3 col-sm-3 col-xs-12" for="course-name">Course Name <span class="required">*</span>
                                   </label>
                                    <div class="col-md-6 col-sm-6 col-xs-12">
                                         <input name="course-name" type="text" id="course-name" required class="form-control col-md-7 col-xs-12">
                                     </div>
                              </div>
                              <!-- end of form-group 1 -->
                              
                              <!-- start of form-group 2 -->          
                              <div class="form-group">
                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="years">Duration in years <span class="required">*</span>
                                    </label>
                                      <div class="col-md-6 col-sm-6 col-xs-12">
                                           <input type="text" id="years" name="years" required class="form-control col-md-7 col-xs-12" onkeypress="return isNumber(event)">
                                      </div>
                              </div>
                              <!-- end of form-group 2 -->
                              
                               <!-- start of form-group 3 -->         
                               <div class="form-group">
                                    <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12" for="sems">Duration in Semesters<span class="required">*</span>
                                    </label>
                                     <div class="col-md-6 col-sm-6 col-xs-12">
                                           <input id="sems" name="sems" required class="form-control col-md-7 col-xs-12"  type="text" name="middle-name" onkeypress="return isNumber(event)">
                                     </div>
                               </div>
                               <!-- end of form-group 3 -->
                               
                               <!-- start of form-group 4 -->       
                               <div class="form-group">
                                     <label class="control-label col-md-3 col-sm-3 col-xs-12" for="descrption">Course Description <span class="required">*</span>
                                     </label>
                                       <div class="col-md-6 col-sm-6 col-xs-12">
                                             <textarea id="descrption" name="description"class="form-control"  required rows="3" placeholder=""></textarea>
                                       </div>
                               </div>
                               <!-- end of form-group 4 -->
                       <div class="ln_solid"></div>
                           <div class="form-group"><!-- start of form group 5 -->
                           <!-- start of col-md-6 col-sm-6 col-xs-12 col-md-offset-3 -->
                              <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                                 <button type="button" class="btn btn-primary" onclick="showDiv()">Cancel</button>
                                   
                                  <button type="reset" class="btn btn-info">Clear</button>
                                
                                  
                                  <button id="coursevalid" type="submit" class="btn btn-primary">Save</button>
                                 
                                    
                                </div><!-- end of col-md-6 col-sm-6 col-xs-12 col-md-offset-3 -->
                            </div><!-- end of form group 5 -->
                        

                                
                         </form><!-- end of form -->
                         
                              
                      </div><!-- end of x-content div -->
                 </div><!-- end of x-panel div -->
              </div><!-- end of col-md-12 col-sm-12 col-xs-12 div -->
           </div><!-- end of row div -->
    </div><!-- end of FormDiv div --> 
  </div><!-- end of right col -->
 </div><!-- end of main body -->
</div><!-- end of container body --><div class="modal fade" id="testcourse" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
    <div class="modal-content">
    <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">�</span>
                                                </button>
               <h4>Confirmation?</h4> 
            </div>
    
            
            <div class="modal-body">
                <Strong> Are you sure ?, You want to Add this course??</Strong>
            </div>
            <div class="modal-footer">
                <button type="button" id="newCourse" class="btn btn-round btn-primary" data-dismiss="modal">OK</button>
               
                
            </div>
        </div>
    </div>
</div>

  <script src="js/validator/bootstrap.min.js"></script>
 
  
  
  <!-- custom js -->
    <script src="js/custom.js"></script>
     <!-- formHide jquery -->
  		<script type="text/javascript" src="js/formHide.js"></script>
 	<!-- /formHide jquery -->
  
   
     <!-- PNotify -->
    <script type="text/javascript" src="js/notify/pnotify.core.js"></script>
    <script type="text/javascript" src="js/notify/pnotify.buttons.js"></script>
    <script type="text/javascript" src="js/notify/pnotify.nonblock.js"></script>
     
    <script>
        NProgress.done();
   </script>
 
  
  
  
 
</body>
</html>
 <%}%>
 