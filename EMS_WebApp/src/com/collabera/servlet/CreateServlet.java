package com.collabera.servlet;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.collabera.db.ConnectionManager;
import com.collabera.db.InitDropDown;
import com.collabera.ems.model.Address;
import com.collabera.ems.model.Employee;

/**
 * Servlet implementation class CreateServlet
 */
@WebServlet("/Create")
public class CreateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CreateServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession sess = request.getSession();

		String name = request.getParameter("name");
		int age = Integer.valueOf(request.getParameter("age"));
		int gender = Integer.valueOf(request.getParameter("gender"));
		long contactNo = Long.valueOf(request.getParameter("contactNo"));

		String hStreet = request.getParameter("hStreet");
		String hCity = request.getParameter("hCity");
		String hState = request.getParameter("hState");
		String hCountry = request.getParameter("hCountry");
		int hZipCode = Integer.valueOf(request.getParameter("hZipCode"));

		String wStreet = request.getParameter("wStreet");
		String wCity = request.getParameter("wCity");
		String wState = request.getParameter("wState");
		String wCountry = request.getParameter("wCountry");
		int wZipCode = Integer.valueOf(request.getParameter("wZipCode"));

		int ssn = Integer.valueOf(request.getParameter("ssn"));
		int jobTitle = Integer.valueOf(request.getParameter("jobTitle"));
		int dept = Integer.valueOf(request.getParameter("dept"));
		double salary = Double.valueOf(request.getParameter("salary"));

		int isManager = Integer.valueOf(request.getParameter("isManTF"));
		int reportTo = Integer.valueOf(request.getParameter("reportTo"));

//		System.out.println(name + " " + age + " " + gender + " " + contactNo + " \n" + hStreet + ", " + hCity + ", "
//				+ hState + ", " + hCountry + " [" + hZipCode + "]\n" + wStreet + ", " + wCity + ", " + wState + ", "
//				+ wCountry + " [" + wZipCode + "]\n" + ssn + " " + jobTitle + " " + dept + " " + salary + "\n"
//				+ isManager + " " + reportManId);

		try {

			int aId = 0;
			Statement stA = ConnectionManager.getConnection().createStatement();

			ResultSet rsA = stA.executeQuery("select MAX(aId) from Address");
			if (rsA.next()) {
				aId = rsA.getInt(1) + 1;
			} else {
				aId = 1;
			}

			Address homeAdd = new Address(aId, hStreet, hCity, hState, hCountry, hZipCode);
			Address workAdd = new Address(aId + 1, wStreet, wCity, wState, wCountry, wZipCode);

			PreparedStatement pstH = ConnectionManager.getConnection().prepareStatement(homeAdd.getInsertStatement());
			pstH.setInt(1, homeAdd.getaId());
			pstH.setString(2, homeAdd.getStreetAddress());
			pstH.setString(3, homeAdd.getCity());
			pstH.setString(4, homeAdd.getState());
			pstH.setString(5, homeAdd.getCountry());
			pstH.setInt(6, homeAdd.getZipCode());

			PreparedStatement pstW = ConnectionManager.getConnection().prepareStatement(workAdd.getInsertStatement());
			pstW.setInt(1, workAdd.getaId());
			pstW.setString(2, workAdd.getStreetAddress());
			pstW.setString(3, workAdd.getCity());
			pstW.setString(4, workAdd.getState());
			pstW.setString(5, workAdd.getCountry());
			pstW.setInt(6, workAdd.getZipCode());

			int flagHomeAdd = pstH.executeUpdate();
			int flagWorkAdd = pstW.executeUpdate();

			if (flagHomeAdd == 1 & flagWorkAdd == 1) {

				System.out.println("Home and Work Address Info inserted into Database...");

				int eId = 0;
				Statement stEmp = ConnectionManager.getConnection().createStatement();

				ResultSet rseId = stEmp.executeQuery("select MAX(eId) from Employee");
				if (rseId.next()) {
					eId = rseId.getInt(1) + 1;
				} else {
					eId = 1;
				}

				String email = null;
				PreparedStatement psteMail = ConnectionManager.getConnection()
						.prepareStatement("select count(*) from Employee where name = ?");
				psteMail.setString(1, name);

				ResultSet rseMail = psteMail.executeQuery();
				rseMail.next();
				int nameFound = rseMail.getInt(1);
				if (nameFound > 0) {
					email = name.toLowerCase().replaceAll("\\s", "") + nameFound + "@colla.com";
				} else {
					email = name.toLowerCase().replaceAll("\\s", "") + "@colla.com";
				}

				Employee emp = new Employee(eId, name, age, gender, contactNo, aId, aId + 1, ssn, email, jobTitle, dept,
						salary, reportTo, isManager);

				PreparedStatement pstE = ConnectionManager.getConnection()
						.prepareStatement(emp.getEmpInsertStatement());
				pstE.setInt(1, emp.geteId());
				pstE.setString(2, emp.getName());
				pstE.setInt(3, emp.getAge());
				pstE.setInt(4, emp.getGender());
				pstE.setLong(5, emp.getContactNo());
				pstE.setInt(6, emp.getaHomeId());
				pstE.setInt(7, emp.getaWorkId());
				pstE.setInt(8, emp.getSsn());
				pstE.setString(9, emp.getEmail());
				pstE.setInt(10, emp.getJobTitle());
				pstE.setInt(11, emp.getDept());
				pstE.setDouble(12, emp.getSalary());
				pstE.setInt(13, emp.getIsManager());

				PreparedStatement pstM = ConnectionManager.getConnection()
						.prepareStatement(emp.getManInsertStatement());

				if (emp.getIsManager() == 1) {
					pstE.setInt(14, 0);

					pstM.setInt(1, emp.geteId());
					pstM.setString(2, emp.getName());
				} else {
					pstE.setInt(14, emp.getReportTo());
				}

				int flagE = pstE.executeUpdate();
				int flagM = 0;

				if (flagE == 1) {
					if (emp.getIsManager() == 1) {
						flagM = pstM.executeUpdate();
					}
				}

				if (flagE == 1) {

					try {
						InitDropDown.initDropDown(sess);
					} catch (SQLException e) {
						System.out.println(e.getMessage());
						sess.setAttribute("createFlag", "SQL Exception...");
						request.getRequestDispatcher("createEmp.jsp").forward(request, response);
					}

					if (emp.getIsManager() == 1) {
						if (flagM == 1) {
							System.out.println("Employee and Manager Info inserted into Database...");
							sess.setAttribute("createFlag", "Employee and Manager Info inserted into Database...");
							request.getRequestDispatcher("adminHome.jsp").forward(request, response);
						} else {
							System.out.println("Employee Info inserted into Database but not Manager Info...");
							sess.setAttribute("createFlag",
									"Employee Info inserted into Database but not Manager Info...");
							request.getRequestDispatcher("adminHome.jsp").forward(request, response);
						}
					} else {
						System.out.println("Employee Info inserted into Database...");
						sess.setAttribute("createFlag", "Employee Info inserted into Database...");
						request.getRequestDispatcher("adminHome.jsp").forward(request, response);
					}
				} else {
					System.out.println("Employee Info can't be inserted into Database...");
					sess.setAttribute("createFlag", "Employee Info can't be inserted into Database...");
					request.getRequestDispatcher("createEmp.jsp").forward(request, response);
				}
			} else {
				System.out.println("Address Info can't be inserted into Database...");
				sess.setAttribute("createFlag", "Address Info can't be inserted into Database...");
				request.getRequestDispatcher("createEmp.jsp").forward(request, response);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			sess.setAttribute("createFlag", "SQL Exception...");
			request.getRequestDispatcher("createEmp.jsp").forward(request, response);
		}
	}
}
