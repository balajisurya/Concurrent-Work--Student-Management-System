package in.jdsoft.studentmanagement.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import in.jdsoft.studentmanagement.controller.InstitutionController;
import in.jdsoft.studentmanagement.model.Institution;

public class InstitutionServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		if(req.getParameter("action").equals("save")){
			Institution institution=new Institution();
			institution.setInstitutionName(req.getParameter("institute-name"));
			institution.setInstitutionDescription(req.getParameter("institute-desc"));
			institution.setInstitutionLogopath("/images/logo.png");
			institution.setInstitutionEmail(req.getParameter("institute-email"));
			institution.setInstitutionAddressLine1(req.getParameter("institute-add1"));
			institution.setInstitutionAddressLine2(req.getParameter("institute-add2"));
			institution.setInstitutionAdminName(req.getParameter("institute-admin-name"));
			institution.setInstitutionCity(req.getParameter("institute-city"));
			institution.setInstitutionCountry(req.getParameter("institute-country"));
			institution.setInstitutionContact(req.getParameter("institute-contact"));
			institution.setInstitutionPostcode("62008");
			new InstitutionController().addInstitution(institution);
		}
		else {
			System.out.println("not saved");
		}
		
	}

}
