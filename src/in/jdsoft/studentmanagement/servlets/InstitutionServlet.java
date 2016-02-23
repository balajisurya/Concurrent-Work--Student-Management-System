package in.jdsoft.studentmanagement.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import in.jdsoft.studentmanagement.controller.InstitutionController;
import in.jdsoft.studentmanagement.model.Institution;

@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
maxFileSize=1024*1024*10,      // 10MB
maxRequestSize=1024*1024*50)   // 50MB
@WebServlet("/InstitutionServlet")
public class InstitutionServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static String SAVE_DIR = "images\\logo";
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		resp.setContentType("text/html");
		
		if(req.getParameter("action").equals("s")){
			
		}
		else if(req.getParameter("action").equals("save")) {
			// gets absolute path of the web application
	        String appPath = req.getServletContext().getRealPath("/");
	        // constructs path of the directory to save uploaded file
	        String savePath = appPath + SAVE_DIR;
	        System.out.println(savePath);
	        // creates the save directory if it does not exists
	        java.io.File fileSaveDir = new java.io.File(savePath);
	        if (!fileSaveDir.exists()) {
	        	System.out.println("file does not exist");
	            fileSaveDir.mkdirs();
	            System.out.println("file created");
	        }
	        System.out.println("entered-1");
	        
	        Part part=req.getPart("photo");
	        String fileprefix=Long.toString(System.currentTimeMillis()); 
	        String file = extractFileName(part);
	        String fileName=fileprefix.concat(file);
	        System.out.println("fileName"+fileName);
	        part.write(savePath + java.io.File.separator +fileName);
	        String imagePath="images\\logo\\".concat(fileName);
	        if(part.getContentType().equals("image/jpeg")||part.getContentType().equals("image/png")){
	        	Institution institution=new Institution();
				institution.setInstitutionName(req.getParameter("institute-name"));
				institution.setInstitutionDescription(req.getParameter("institute-desc"));
				institution.setInstitutionLogopath(imagePath);
				institution.setInstitutionEmail(req.getParameter("institute-email"));
				institution.setInstitutionAddressLine1(req.getParameter("institute-add1"));
				institution.setInstitutionAddressLine2(req.getParameter("institute-add2"));
				institution.setInstitutionAdminName(req.getParameter("institute-admin-name"));
				institution.setInstitutionCity(req.getParameter("institute-city"));
				institution.setInstitutionCountry(req.getParameter("institute-country"));
				institution.setInstitutionContact(req.getParameter("institute-contact"));
				institution.setInstitutionPostcode("62008");
				new InstitutionController().addInstitution(institution);
				resp.sendRedirect("dashboard.jsp");
	        }
	        else{
	        	req.setAttribute("errorMessage", "Upload Image in png/jpeg only.");
				req.getRequestDispatcher("institutions.jsp").forward(req, resp);
	        }
			
		}
	}
	
		private String extractFileName(Part part) {
	        String contentDisp = part.getHeader("content-disposition");
	        String[] items = contentDisp.split(";");
	        for (String s : items) {
	            if (s.trim().startsWith("filename")) {
	                return s.substring(s.indexOf("=") + 2, s.length()-1);
	            }
	        }
	        return "";
	    }

}
