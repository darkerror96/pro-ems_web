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
 * Servlet implementation class DeleteServlet
 */
@WebServlet("/Delete")
public class DeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeleteServlet() {
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

		int eId = Integer.valueOf(request.getParameter("eId").trim());

		try {
			PreparedStatement pst = ConnectionManager.getConnection()
					.prepareStatement("select count(*), aHomeId, aWorkId, isManager from Employee where eId = ?");
			pst.setInt(1, eId);

			ResultSet rs = pst.executeQuery();
			rs.next();

			if (rs.getInt(1) == 1) {

				PreparedStatement pstD = ConnectionManager.getConnection()
						.prepareStatement(Employee.getEmpDeleteStatement());
				pstD.setInt(1, eId);

				PreparedStatement pstAH = ConnectionManager.getConnection()
						.prepareStatement(Address.getDeleteStatement());
				pstAH.setInt(1, rs.getInt(2));

				PreparedStatement pstAW = ConnectionManager.getConnection()
						.prepareStatement(Address.getDeleteStatement());
				pstAW.setInt(1, rs.getInt(3));

				PreparedStatement pstM = ConnectionManager.getConnection()
						.prepareStatement(Employee.getManDeleteStatement());
				if (rs.getInt(4) == 1) {
					pstM.setInt(1, eId);
				}

				int rowEDeleted = pstD.executeUpdate();
				int rowAHDeleted = pstAH.executeUpdate();
				int rowAWDeleted = pstAW.executeUpdate();

				int rowMDeleted = 0;
				if (rowEDeleted == 1 & rowAHDeleted == 1 & rowAWDeleted == 1) {
					if (rs.getInt(4) == 1) {
						rowMDeleted = pstM.executeUpdate();
					}
				}

				if (rowEDeleted == 1 & rowAHDeleted == 1 & rowAWDeleted == 1) {

					try {
						InitDropDown.initDropDown(sess);
					} catch (SQLException e) {
						System.out.println(e.getMessage());
						sess.setAttribute("deleteFlag", "SQL Exception...");
						request.getRequestDispatcher("deleteEmp.jsp").forward(request, response);
					}

					if (rs.getInt(4) == 1) {
						if (rowMDeleted == 1) {
							System.out.println("Employee(Address) and Manager Info deleted from Database...");
							sess.setAttribute("deleteFlag",
									"Employee(Address) and Manager Info deleted from Database...");
							request.getRequestDispatcher("adminHome.jsp").forward(request, response);
						} else {
							System.out
									.println("Employee and Address Info deleted from Database but not Manager Info...");
							sess.setAttribute("deleteFlag",
									"Employee and Address Info deleted from Database but not Manager Info...");
							request.getRequestDispatcher("adminHome.jsp").forward(request, response);
						}
					} else {
						System.out.println("Employee and Address successfully deleted...");
						sess.setAttribute("deleteFlag", "Employee and Address successfully deleted...");
						request.getRequestDispatcher("adminHome.jsp").forward(request, response);
					}
				} else {
					System.out.println("Employee or Address couldn't be deleted. Try again...");
					sess.setAttribute("deleteFlag", "Employee or Address couldn't be deleted. Try again...");
					request.getRequestDispatcher("deleteEmp.jsp").forward(request, response);
				}
			} else {
				System.out.println("Employee Id not found. Try again...");
				sess.setAttribute("deleteFlag", "Employee Id not found. Try again...");
				request.getRequestDispatcher("deleteEmp.jsp").forward(request, response);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			sess.setAttribute("deleteFlag", "SQL Exception...");
			request.getRequestDispatcher("deleteEmp.jsp").forward(request, response);
		}
	}
}
