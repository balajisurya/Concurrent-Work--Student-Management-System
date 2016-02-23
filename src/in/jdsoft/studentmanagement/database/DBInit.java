package in.jdsoft.studentmanagement.database;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import in.jdsoft.reportingtool.feeders.FeesFeeder;
import in.jdsoft.studentmanagement.controller.CourseCategoryController;
import in.jdsoft.studentmanagement.controller.CourseController;
import in.jdsoft.studentmanagement.controller.CourseSemesterController;
import in.jdsoft.studentmanagement.controller.CurrencyController;
import in.jdsoft.studentmanagement.controller.FeesTemplateController;
import in.jdsoft.studentmanagement.controller.GroupController;
import in.jdsoft.studentmanagement.controller.GroupMappingController;
import in.jdsoft.studentmanagement.controller.InstitutionController;
import in.jdsoft.studentmanagement.controller.LoginController;
import in.jdsoft.studentmanagement.controller.MenuController;
import in.jdsoft.studentmanagement.controller.ReceiptController;
import in.jdsoft.studentmanagement.controller.StudentAcademicController;
import in.jdsoft.studentmanagement.controller.StudentFeesHistoryController;
import in.jdsoft.studentmanagement.controller.StudentRegistrationController;
import in.jdsoft.studentmanagement.controller.TemplateItemController;
import in.jdsoft.studentmanagement.controller.UserManagementController;


public class DBInit extends HttpServlet {

	private static final long serialVersionUID = 1L;


	public void init(ServletConfig config) throws ServletException {
        
        String jdbcDriverName=config.getInitParameter("DriverName");
        String jdbcServerName=config.getInitParameter("ServerName");
        String jdbcPort=config.getInitParameter("Port");
        String jdbcDatabaseName=config.getInitParameter("DatabaseName");
        String jdbcUserName=config.getInitParameter("UserName");
        String jdbcPassword=config.getInitParameter("Password");
        
        ServletContext sc = config.getServletContext();
        
        DBConnection dbConn=null;
        
        try{
            dbConn=new DBConnection();
            
            dbConn.setSDriverName(jdbcDriverName);
            dbConn.setSServerName(jdbcServerName);
            dbConn.setSPort(jdbcPort);
            dbConn.setSDatabaseName(jdbcDatabaseName);
            dbConn.setSUserName(jdbcUserName);
            dbConn.setSPassword(jdbcPassword);
            sc.setAttribute("dbConn", dbConn);
        }
        catch(Exception e)
        {
            e.printStackTrace();
            
        }
        
        MenuController menu=new MenuController();
        menu.getDbAccess(sc);
        
        //ConnectionObject obj=new ConnectionObject();
        //obj.setDbAccess(sc);
        
        LoginController login=new LoginController();
        login.getDbAccess(sc);
        
        CourseController course=new CourseController();
        course.getDbAccess(sc);
        
        GroupController groups=new GroupController();
        groups.getDbAccess(sc);
        
        TemplateItemController templateItem=new TemplateItemController();
        templateItem.getDbAccess(sc);
        
        FeesTemplateController feesTemplate=new FeesTemplateController();
        feesTemplate.getDbAccess(sc);
        
        CurrencyController currency=new CurrencyController();
        currency.getDbAccess(sc);
        
        GroupMappingController groupMapping=new GroupMappingController();
        groupMapping.getDbAccess(sc);
        
        StudentRegistrationController studentRegistration=new StudentRegistrationController();
        studentRegistration.getDbAccess(sc);
        
        CourseCategoryController courseCategory=new CourseCategoryController();
        courseCategory.getDbAccess(sc);
        
        StudentAcademicController studentAcademic=new StudentAcademicController();
        studentAcademic.getDbAccess(sc);
        
        CourseSemesterController courseSemester=new CourseSemesterController();
        courseSemester.getDbAccess(sc);
        
        ReceiptController receipt=new ReceiptController();
        receipt.getDbAccess(sc);
        
        StudentFeesHistoryController studentFeesHistory=new StudentFeesHistoryController();
        studentFeesHistory.getDbAccess(sc);
        
        UserManagementController userManagement=new UserManagementController();
        userManagement.getDbAccess(sc);
        
        FeesFeeder feesFeeder=new FeesFeeder();
        feesFeeder.getDbAccess(sc);
        
        InstitutionController institutionController=new InstitutionController();
        institutionController.getDbAccess(sc);
        
    }

}
