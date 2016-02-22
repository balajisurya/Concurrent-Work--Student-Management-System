package in.jdsoft.studentmanagement.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletContext;

import in.jdsoft.studentmanagement.database.DBConnection;
import in.jdsoft.studentmanagement.model.Institution;

public class InstitutionController {
 
	static ServletContext sc;
	Connection instituteConn=null;
    PreparedStatement instituteStmt=null;
    ResultSet instituteRs=null;
    
    public void getDbAccess(ServletContext sc){
		InstitutionController.sc=sc;
	 }
    
    public void addInstitution(Institution i){
    	try{
    	DBConnection instituteSc=(DBConnection) sc.getAttribute("dbConn");
    	instituteConn=instituteSc.getDBConnection();
    	instituteStmt=instituteConn.prepareStatement("INSERT INTO tbl_institution(institution_name,institution_admin_name,institution_addressline1,institution_addressline2,institution_city,institution_country,institution_contact,institution_description,institution_logo,institution_postcode,institution_email) values(?,?,?,?,?,?,?,?,?,?,?)");
    	instituteStmt.setString(1,i.getInstitutionName());
    	instituteStmt.setString(2,i.getInstitutionAdminName());
    	instituteStmt.setString(3,i.getInstitutionAddressLine1());
    	instituteStmt.setString(4,i.getInstitutionAddressLine2());
    	instituteStmt.setString(5,i.getInstitutionCity());
    	instituteStmt.setString(6,i.getInstitutionCountry());
    	instituteStmt.setString(7,i.getInstitutionContact());
    	instituteStmt.setString(8,i.getInstitutionDescription());
    	instituteStmt.setString(9,i.getInstitutionLogopath());
    	instituteStmt.setString(10,i.getInstitutionPostcode());
    	instituteStmt.setString(11,i.getInstitutionEmail());
    	instituteStmt.execute();
    	}
    	catch(Exception e){ 
    		System.out.println("Exception in Add Institution of Institute controller "+e);
    	}
    	finally{
    		close();
    	}
    }
   
    
    public void close(){
    	try{
    		if(instituteConn!=null){
    			instituteConn.close();
			}
			if(instituteStmt!=null){
				instituteStmt.close();	
			}
			if(instituteRs!=null){
				instituteRs.close();
		   }
		}catch(Exception e){
			System.out.println("Exception in closing Institution connection of Institute controller"+e);
		}
    }
}
