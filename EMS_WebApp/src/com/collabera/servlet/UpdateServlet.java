package com.collabera.servlet;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
 * Servlet implementation class UpdateServlet
 */
@WebServlet("/Update")
public class UpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateServlet() {
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

		int eId = Integer.valueOf(request.getParameter("eId"));
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
		String email = request.getParameter("email");
		int jobTitle = Integer.valueOf(request.getParameter("jobTitle"));
		int dept = Integer.valueOf(request.getParameter("dept"));
		double salary = Double.valueOf(request.getParameter("salary"));

		int isManager = Integer.valueOf(request.getParameter("isManTF"));
		int reportTo = 0;
		if (isManager == 0) {
			reportTo = Integer.valueOf(request.getParameter("reportTo"));
		}

//		System.out.println(name + " " + age + " " + gender + " " + contactNo + " \n" + hStreet + ", " + hCity + ", "
//				+ hState + ", " + hCountry + " [" + hZipCode + "]\n" + wStreet + ", " + wCity + ", " + wState + ", "
//				+ wCountry + " [" + wZipCode + "]\n" + ssn + " " + jobTitle + " " + dept + " " + salary + "\n"
//				+ isManager + " " + reportManId);

		String updateEmpURL = "updateEmp.jsp?eId=" + eId;

		try {

			int aHId = 1, aWId = 2, currentEisManager = 0;
			PreparedStatement pstA = ConnectionManager.getConnection()
					.prepareStatement("select aHomeId, aWorkId, isManager from Employee where eId = ?");
			pstA.setInt(1, eId);

			ResultSet rsA = pstA.executeQuery();
			if (rsA.next()) {
				aHId = rsA.getInt(1);
				aWId = rsA.getInt(2);
				currentEisManager = rsA.getInt(3);
			} else {
				System.out.println("Invalid URL parameter(Employee Id - " + eId + " not found)...");
				sess.setAttribute("updateFlag", "Invalid URL parameter(Employee Id - " + eId + " not found)...");
				request.getRequestDispatcher("adminHome.jsp").forward(request, response);
			}

			Address homeAdd = new Address(aHId, hStreet, hCity, hState, hCountry, hZipCode);
			Address workAdd = new Address(aWId, wStreet, wCity, wState, wCountry, wZipCode);

			PreparedStatement pstH = ConnectionManager.getConnection().prepareStatement(homeAdd.getUpdateStatement());
			pstH.setString(1, homeAdd.getStreetAddress());
			pstH.setString(2, homeAdd.getCity());
			pstH.setString(3, homeAdd.getState());
			pstH.setString(4, homeAdd.getCountry());
			pstH.setInt(5, homeAdd.getZipCode());
			pstH.setInt(6, homeAdd.getaId());

			PreparedStatement pstW = ConnectionManager.getConnection().prepareStatement(workAdd.getUpdateStatement());
			pstW.setString(1, workAdd.getStreetAddress());
			pstW.setString(2, workAdd.getCity());
			pstW.setString(3, workAdd.getState());
			pstW.setString(4, workAdd.getCountry());
			pstW.setInt(5, workAdd.getZipCode());
			pstW.setInt(6, workAdd.getaId());

			int flagHomeAdd = pstH.executeUpdate();
			int flagWorkAdd = pstW.executeUpdate();

			if (flagHomeAdd == 1 & flagWorkAdd == 1) {

				System.out.println("Home and Work Address Info updated into Database...");

				Employee emp = new Employee(eId, name, age, gender, contactNo, aHId, aWId, ssn, email, jobTitle, dept,
						salary, reportTo, isManager);

				PreparedStatement pstE = ConnectionManager.getConnection()
						.prepareStatement(emp.getEmpUpdateStatement());

				pstE.setString(1, emp.getName());
				pstE.setInt(2, emp.getAge());
				pstE.setInt(3, emp.getGender());
				pstE.setLong(4, emp.getContactNo());
				pstE.setInt(5, emp.getSsn());
				pstE.setInt(6, emp.getJobTitle());
				pstE.setInt(7, emp.getDept());
				pstE.setDouble(8, emp.getSalary());
				pstE.setInt(9, emp.getIsManager());
				pstE.setInt(11, emp.geteId());

				PreparedStatement pstMU = ConnectionManager.getConnection()
						.prepareStatement(emp.getManUpdateStatement());

				PreparedStatement pstEM = ConnectionManager.getConnection()
						.prepareStatement(emp.getManInsertStatement());

				if (emp.getIsManager() == 1) {
					pstE.setInt(10, 0);

					if (currentEisManager == 1) {
						pstMU.setString(1, emp.getName());
						pstMU.setInt(2, emp.geteId());
					} else {
						pstEM.setInt(1, emp.geteId());
						pstEM.setString(2, emp.getName());
					}

				} else {
					pstE.setInt(10, emp.getReportTo());
				}

				int flagE = pstE.executeUpdate();
				int flagMU = 0, flagEM = 0;

				if (flagE == 1) {
					if (emp.getIsManager() == 1) {
						if (currentEisManager == 1) {
							flagMU = pstMU.executeUpdate();
						} else {
							flagEM = pstEM.executeUpdate();
						}
					}
				}

				if (flagE == 1) {
					try {
						InitDropDown.initDropDown(sess);
					} catch (SQLException e) {
						System.out.println(e.getMessage());
						sess.setAttribute("updateFlag", "SQL Exception...");
						request.getRequestDispatcher(updateEmpURL).forward(request, response);
					}

					if (emp.getIsManager() == 1) {
						if (flagMU == 1) {
							System.out.println("Employee and Manager Info updated into Database...");
							sess.setAttribute("updateFlag", "Employee and Manager Info updated into Database...");
							request.getRequestDispatcher("adminHome.jsp").forward(request, response);
						} else if (flagEM == 1) {
							System.out.println(
									"Employee Info updated into Database and Manager Info inserted into Database...");
							sess.setAttribute("updateFlag",
									"Employee Info updated into Database and Manager Info inserted into Database...");
							request.getRequestDispatcher("adminHome.jsp").forward(request, response);
						} else {
							System.out.println("Employee Info updated into Database but not Manager Info...");
							sess.setAttribute("updateFlag",
									"Employee Info updated into Database but not Manager Info...");
							request.getRequestDispatcher("adminHome.jsp").forward(request, response);
						}
					} else {
						System.out.println("Employee Info updated into Database...");
						sess.setAttribute("updateFlag", "Employee Info updated into Database...");
						request.getRequestDispatcher("adminHome.jsp").forward(request, response);
					}
				} else {
					System.out.println("Employee Info can't be updated into Database...");
					sess.setAttribute("updateFlag", "Employee Info can't be updated into Database...");
					request.getRequestDispatcher(updateEmpURL).forward(request, response);
				}
			} else {
				System.out.println("Address Info can't be updated into Database...");
				sess.setAttribute("updateFlag", "Address Info can't be updated into Database...");
				request.getRequestDispatcher(updateEmpURL).forward(request, response);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			sess.setAttribute("updateFlag", "SQL Exception...");
			request.getRequestDispatcher(updateEmpURL).forward(request, response);
		}
	}
}
