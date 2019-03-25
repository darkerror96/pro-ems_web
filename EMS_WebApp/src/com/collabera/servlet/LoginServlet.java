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
import com.collabera.db.StringConverter;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/Home")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession sess = request.getSession();

		String eId = request.getParameter("eId").trim();
		String pwd = request.getParameter("pwd").trim();

		if (eId.equals("0") & pwd.equals("admi")) {

			try {
				InitDropDown.initDropDown(sess);
				request.getRequestDispatcher("adminHome.jsp").forward(request, response);
			} catch (SQLException e) {
				System.out.println(e.getMessage());
				sess.setAttribute("loginFlag", "SQL Exception...");
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
		} else {
			try {
				PreparedStatement pst = ConnectionManager.getConnection().prepareStatement(
						"SELECT E.eId, E.name, E.age, G.gType,E.contactNo,AH.street, AH.city,AH.state,AH.country,AH.zipCode,AW.street, AW.city,AW.state,AW.country,AW.zipCode,E.ssn,E.email,J.jType, D.dType,E.salary,E.isManager,E.manId  FROM Employee E JOIN Address AH ON E.aHomeId = AH.aId JOIN Address AW ON E.aWorkId = AW.aId JOIN Gender G ON E.gId = G.gId JOIN Department D ON E.dId = D.dId JOIN JobTitle J ON E.jId = J.jId WHERE E.eId = ?;");

				pst.setInt(1, Integer.valueOf(eId));

				ResultSet rs = pst.executeQuery();
				if (rs.next()) {
					String userSsn = String.valueOf(rs.getInt(16));
					if (userSsn.substring(5, 9).equals(pwd)) {

						String[][] Emp = new String[1][22];

						Emp[0][0] = String.valueOf(rs.getInt("eId"));
						Emp[0][1] = rs.getString("name");
						Emp[0][2] = String.valueOf(rs.getInt("age"));
						Emp[0][3] = rs.getString("gType");
						Emp[0][4] = String.valueOf(rs.getInt("contactNo"));
						Emp[0][5] = rs.getString("AH.street");
						Emp[0][6] = rs.getString("AH.city");
						Emp[0][7] = rs.getString("AH.state");
						Emp[0][8] = rs.getString("AH.country");

						Emp[0][9] = StringConverter.zipCodeConv(String.valueOf(rs.getInt("AH.zipCode")));

						Emp[0][10] = rs.getString("AW.street");
						Emp[0][11] = rs.getString("AW.city");
						Emp[0][12] = rs.getString("AW.state");
						Emp[0][13] = rs.getString("AW.country");

						Emp[0][14] = StringConverter.zipCodeConv(String.valueOf(rs.getInt("AW.zipCode")));

						Emp[0][15] = StringConverter.ssnConv(String.valueOf(rs.getInt("ssn")));

						Emp[0][16] = rs.getString("email");
						Emp[0][17] = rs.getString("jType");
						Emp[0][18] = rs.getString("dType");
						Emp[0][19] = String.valueOf(rs.getDouble("salary"));
						Emp[0][20] = String.valueOf(rs.getInt("isManager"));
						Emp[0][21] = String.valueOf(rs.getInt("manId"));

						sess.setAttribute("Emp", Emp);
						request.getRequestDispatcher("empHome.jsp").forward(request, response);
					} else {
						sess.setAttribute("loginFlag", "Incorrect Password. Try again...");
						request.getRequestDispatcher("login.jsp").forward(request, response);
					}
				} else {
					sess.setAttribute("loginFlag", "Employee Id not found. Try again...");
					request.getRequestDispatcher("login.jsp").forward(request, response);
				}
			} catch (SQLException e) {
				System.out.println(e.getMessage());
				sess.setAttribute("loginFlag", "SQL Exception...");
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
		}
	}
}
