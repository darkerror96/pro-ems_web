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
import com.collabera.db.StringConverter;

/**
 * Servlet implementation class SearchServlet
 */
@WebServlet("/Search")
public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SearchServlet() {
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

		String sR = request.getParameter("sR");
		String searchInput = request.getParameter("searchInput");

		if (sR != null & searchInput != null) {

			int radioBtn = Integer.valueOf(sR);
			if (radioBtn == 2) {

				String manDetails[] = searchInput.split(":");

				if (manDetails.length == 2) {

					String manName = manDetails[0].trim();
					String manId = manDetails[1].trim();

					try {

						PreparedStatement pstMT = ConnectionManager.getConnection().prepareStatement(
								"SELECT  E.eId, E.name, E.age, G.gType,E.contactNo,AH.street, AH.city,AH.state,AH.country,AH.zipCode,AW.street, AW.city,AW.state,AW.country,AW.zipCode,E.ssn,E.email,J.jType, D.dType,E.salary FROM Employee E JOIN Address AH ON E.aHomeId = AH.aId JOIN Address AW ON E.aWorkId = AW.aId JOIN Gender G ON E.gId = G.gId JOIN Department D ON E.dId = D.dId JOIN JobTitle J ON E.jId = J.jId WHERE E.manId = ? ORDER BY E.eId ASC;");
						pstMT.setString(1, manId);

						ResultSet rsMT = pstMT.executeQuery();

						if (rsMT.last()) {

							int i = 0;
							String[][] searchManTeam = new String[rsMT.getRow()][22];

							rsMT.beforeFirst();
							while (rsMT.next()) {
								searchManTeam[i][0] = String.valueOf(rsMT.getInt("eId"));
								searchManTeam[i][1] = rsMT.getString("name");
								searchManTeam[i][2] = String.valueOf(rsMT.getInt("age"));
								searchManTeam[i][3] = rsMT.getString("gType");
								searchManTeam[i][4] = String.valueOf(rsMT.getInt("contactNo"));
								searchManTeam[i][5] = rsMT.getString("AH.street");
								searchManTeam[i][6] = rsMT.getString("AH.city");
								searchManTeam[i][7] = rsMT.getString("AH.state");
								searchManTeam[i][8] = rsMT.getString("AH.country");

								searchManTeam[i][9] = StringConverter
										.zipCodeConv(String.valueOf(rsMT.getInt("AH.zipCode")));

								searchManTeam[i][10] = rsMT.getString("AW.street");
								searchManTeam[i][11] = rsMT.getString("AW.city");
								searchManTeam[i][12] = rsMT.getString("AW.state");
								searchManTeam[i][13] = rsMT.getString("AW.country");

								searchManTeam[i][14] = StringConverter
										.zipCodeConv(String.valueOf(rsMT.getInt("AW.zipCode")));

								searchManTeam[i][15] = StringConverter.ssnConv(String.valueOf(rsMT.getInt("ssn")));

								searchManTeam[i][16] = rsMT.getString("email");
								searchManTeam[i][17] = rsMT.getString("jType");
								searchManTeam[i][18] = rsMT.getString("dType");
								searchManTeam[i][19] = String.valueOf(rsMT.getDouble("salary"));
								i++;
							}
							sess.setAttribute("searchManTeam", searchManTeam);
						} else {
							System.out.println("Manager has no Employee in the Team...");
							sess.setAttribute("searchManFlag", "Manager has no Employee in the Team...");
						}

						PreparedStatement pst = ConnectionManager.getConnection().prepareStatement(
								"SELECT E.name, E.eId, E.age, G.gType,E.contactNo,AH.street, AH.city,AH.state,AH.country,AH.zipCode,AW.street, AW.city,AW.state,AW.country,AW.zipCode,E.ssn,E.email,J.jType, D.dType,E.salary,E.isManager,E.manId  FROM Employee E JOIN Address AH ON E.aHomeId = AH.aId JOIN Address AW ON E.aWorkId = AW.aId JOIN Gender G ON E.gId = G.gId JOIN Department D ON E.dId = D.dId JOIN JobTitle J ON E.jId = J.jId WHERE E.eId = ? AND E.name = ? AND E.isManager = 1 ORDER BY E.eId ASC;");
						pst.setInt(1, Integer.valueOf(manId));
						pst.setString(2, manName);

						ResultSet rs = pst.executeQuery();

						if (rs.last()) {

							int i = 0;
							String[][] searchMan = new String[rs.getRow()][22];

							rs.beforeFirst();
							while (rs.next()) {
								searchMan[i][0] = rs.getString("name");
								searchMan[i][1] = String.valueOf(rs.getInt("eId"));
								searchMan[i][2] = String.valueOf(rs.getInt("age"));
								searchMan[i][3] = rs.getString("gType");
								searchMan[i][4] = String.valueOf(rs.getInt("contactNo"));
								searchMan[i][5] = rs.getString("AH.street");
								searchMan[i][6] = rs.getString("AH.city");
								searchMan[i][7] = rs.getString("AH.state");
								searchMan[i][8] = rs.getString("AH.country");

								searchMan[i][9] = StringConverter.zipCodeConv(String.valueOf(rs.getInt("AH.zipCode")));

								searchMan[i][10] = rs.getString("AW.street");
								searchMan[i][11] = rs.getString("AW.city");
								searchMan[i][12] = rs.getString("AW.state");
								searchMan[i][13] = rs.getString("AW.country");

								searchMan[i][14] = StringConverter.zipCodeConv(String.valueOf(rs.getInt("AW.zipCode")));

								searchMan[i][15] = StringConverter.ssnConv(String.valueOf(rs.getInt("ssn")));

								searchMan[i][16] = rs.getString("email");
								searchMan[i][17] = rs.getString("jType");
								searchMan[i][18] = rs.getString("dType");
								searchMan[i][19] = String.valueOf(rs.getDouble("salary"));
								searchMan[i][20] = String.valueOf(rs.getInt("isManager"));
								searchMan[i][21] = String.valueOf(rs.getInt("manId"));
								i++;
							}
							sess.setAttribute("searchMan", searchMan);
							request.getRequestDispatcher("searchResultMan.jsp").forward(request, response);

						} else {
							System.out.println("No Manager with entered Name matched...");
							sess.setAttribute("searchFlag", "No Manager with entered Name matched...");
							request.getRequestDispatcher("searchEmp.jsp").forward(request, response);
						}

					} catch (SQLException e) {
						System.out.println(e.getMessage());
						sess.setAttribute("searchFlag", "SQL Exception...");
						request.getRequestDispatcher("searchEmp.jsp").forward(request, response);
					}

				} else {
					System.out.println("No Manager with entered Name matched...");
					sess.setAttribute("searchFlag", "No Manager with entered Name matched...");
					request.getRequestDispatcher("searchEmp.jsp").forward(request, response);
				}

			} else if (radioBtn == 3) {

				try {

					PreparedStatement pst = ConnectionManager.getConnection().prepareStatement(
							"SELECT J.jType,E.eId, E.name, E.age, G.gType,E.contactNo,AH.street, AH.city,AH.state,AH.country,AH.zipCode,AW.street, AW.city,AW.state,AW.country,AW.zipCode,E.ssn,E.email, D.dType,E.salary,E.isManager,E.manId  FROM Employee E JOIN Address AH ON E.aHomeId = AH.aId JOIN Address AW ON E.aWorkId = AW.aId JOIN Gender G ON E.gId = G.gId JOIN Department D ON E.dId = D.dId JOIN JobTitle J ON E.jId = J.jId WHERE J.jType = ? ORDER BY E.eId ASC;");
					pst.setString(1, searchInput);

					ResultSet rs = pst.executeQuery();

					if (rs.last()) {

						int i = 0;
						String[][] searchJob = new String[rs.getRow()][22];

						rs.beforeFirst();
						while (rs.next()) {
							searchJob[i][0] = rs.getString("jType");
							searchJob[i][1] = String.valueOf(rs.getInt("eId"));
							searchJob[i][2] = rs.getString("name");
							searchJob[i][3] = String.valueOf(rs.getInt("age"));
							searchJob[i][4] = rs.getString("gType");
							searchJob[i][5] = String.valueOf(rs.getInt("contactNo"));
							searchJob[i][6] = rs.getString("AH.street");
							searchJob[i][7] = rs.getString("AH.city");
							searchJob[i][8] = rs.getString("AH.state");
							searchJob[i][9] = rs.getString("AH.country");

							searchJob[i][10] = StringConverter.zipCodeConv(String.valueOf(rs.getInt("AH.zipCode")));

							searchJob[i][11] = rs.getString("AW.street");
							searchJob[i][12] = rs.getString("AW.city");
							searchJob[i][13] = rs.getString("AW.state");
							searchJob[i][14] = rs.getString("AW.country");

							searchJob[i][15] = StringConverter.zipCodeConv(String.valueOf(rs.getInt("AW.zipCode")));

							searchJob[i][16] = StringConverter.ssnConv(String.valueOf(rs.getInt("ssn")));

							searchJob[i][17] = rs.getString("email");
							searchJob[i][18] = rs.getString("dType");
							searchJob[i][19] = String.valueOf(rs.getDouble("salary"));
							searchJob[i][20] = String.valueOf(rs.getInt("isManager"));
							searchJob[i][21] = String.valueOf(rs.getInt("manId"));
							i++;
						}
						sess.setAttribute("searchJob", searchJob);
						request.getRequestDispatcher("searchResultJob.jsp").forward(request, response);

					} else {
						System.out.println("No Job Title matched...");
						sess.setAttribute("searchFlag", "No Job Title matched...");
						request.getRequestDispatcher("searchEmp.jsp").forward(request, response);
					}

				} catch (SQLException e) {
					System.out.println(e.getMessage());
					sess.setAttribute("searchFlag", "SQL Exception...");
					request.getRequestDispatcher("searchEmp.jsp").forward(request, response);
				}

			} else if (radioBtn == 4) {

				try {

					PreparedStatement pst = ConnectionManager.getConnection().prepareStatement(
							"SELECT D.dType, E.eId, E.name, E.age, G.gType,E.contactNo,AH.street, AH.city,AH.state,AH.country,AH.zipCode,AW.street, AW.city,AW.state,AW.country,AW.zipCode,E.ssn,E.email,J.jType,E.salary,E.isManager,E.manId  FROM Employee E JOIN Address AH ON E.aHomeId = AH.aId JOIN Address AW ON E.aWorkId = AW.aId JOIN Gender G ON E.gId = G.gId JOIN Department D ON E.dId = D.dId JOIN JobTitle J ON E.jId = J.jId WHERE D.dType = ? ORDER BY E.eId ASC;");
					pst.setString(1, searchInput);

					ResultSet rs = pst.executeQuery();

					if (rs.last()) {

						int i = 0;
						String[][] searchDept = new String[rs.getRow()][22];

						rs.beforeFirst();
						while (rs.next()) {
							searchDept[i][0] = rs.getString("dType");
							searchDept[i][1] = String.valueOf(rs.getInt("eId"));
							searchDept[i][2] = rs.getString("name");
							searchDept[i][3] = String.valueOf(rs.getInt("age"));
							searchDept[i][4] = rs.getString("gType");
							searchDept[i][5] = String.valueOf(rs.getInt("contactNo"));
							searchDept[i][6] = rs.getString("AH.street");
							searchDept[i][7] = rs.getString("AH.city");
							searchDept[i][8] = rs.getString("AH.state");
							searchDept[i][9] = rs.getString("AH.country");

							searchDept[i][10] = StringConverter.zipCodeConv(String.valueOf(rs.getInt("AH.zipCode")));

							searchDept[i][11] = rs.getString("AW.street");
							searchDept[i][12] = rs.getString("AW.city");
							searchDept[i][13] = rs.getString("AW.state");
							searchDept[i][14] = rs.getString("AW.country");

							searchDept[i][15] = StringConverter.zipCodeConv(String.valueOf(rs.getInt("AW.zipCode")));

							searchDept[i][16] = StringConverter.ssnConv(String.valueOf(rs.getInt("ssn")));

							searchDept[i][17] = rs.getString("email");
							searchDept[i][18] = rs.getString("jType");
							searchDept[i][19] = String.valueOf(rs.getDouble("salary"));
							searchDept[i][20] = String.valueOf(rs.getInt("isManager"));
							searchDept[i][21] = String.valueOf(rs.getInt("manId"));
							i++;
						}
						sess.setAttribute("searchDept", searchDept);
						request.getRequestDispatcher("searchResultDept.jsp").forward(request, response);

					} else {
						System.out.println("No Department matched...");
						sess.setAttribute("searchFlag", "No Department matched...");
						request.getRequestDispatcher("searchEmp.jsp").forward(request, response);
					}

				} catch (SQLException e) {
					System.out.println(e.getMessage());
					sess.setAttribute("searchFlag", "SQL Exception...");
					request.getRequestDispatcher("searchEmp.jsp").forward(request, response);
				}

			} else {

				String empDetails[] = searchInput.split(":");

				if (empDetails.length == 2) {

					String empName = empDetails[0].trim();
					String empId = empDetails[1].trim();

					try {

						PreparedStatement pst = ConnectionManager.getConnection().prepareStatement(
								"SELECT E.name, E.eId, E.age, G.gType,E.contactNo,AH.street, AH.city,AH.state,AH.country,AH.zipCode,AW.street, AW.city,AW.state,AW.country,AW.zipCode,E.ssn,E.email,J.jType, D.dType,E.salary,E.isManager,E.manId  FROM Employee E JOIN Address AH ON E.aHomeId = AH.aId JOIN Address AW ON E.aWorkId = AW.aId JOIN Gender G ON E.gId = G.gId JOIN Department D ON E.dId = D.dId JOIN JobTitle J ON E.jId = J.jId WHERE E.eId = ? AND E.name = ? ORDER BY E.eId ASC;");
						pst.setInt(1, Integer.valueOf(empId));
						pst.setString(2, empName);

						ResultSet rs = pst.executeQuery();

						if (rs.last()) {

							int i = 0;
							String[][] searchEmp = new String[rs.getRow()][22];

							rs.beforeFirst();
							while (rs.next()) {
								searchEmp[i][0] = rs.getString("name");
								searchEmp[i][1] = String.valueOf(rs.getInt("eId"));
								searchEmp[i][2] = String.valueOf(rs.getInt("age"));
								searchEmp[i][3] = rs.getString("gType");
								searchEmp[i][4] = String.valueOf(rs.getInt("contactNo"));
								searchEmp[i][5] = rs.getString("AH.street");
								searchEmp[i][6] = rs.getString("AH.city");
								searchEmp[i][7] = rs.getString("AH.state");
								searchEmp[i][8] = rs.getString("AH.country");

								searchEmp[i][9] = StringConverter.zipCodeConv(String.valueOf(rs.getInt("AH.zipCode")));

								searchEmp[i][10] = rs.getString("AW.street");
								searchEmp[i][11] = rs.getString("AW.city");
								searchEmp[i][12] = rs.getString("AW.state");
								searchEmp[i][13] = rs.getString("AW.country");

								searchEmp[i][14] = StringConverter.zipCodeConv(String.valueOf(rs.getInt("AW.zipCode")));

								searchEmp[i][15] = StringConverter.ssnConv(String.valueOf(rs.getInt("ssn")));

								searchEmp[i][16] = rs.getString("email");
								searchEmp[i][17] = rs.getString("jType");
								searchEmp[i][18] = rs.getString("dType");
								searchEmp[i][19] = String.valueOf(rs.getDouble("salary"));
								searchEmp[i][20] = String.valueOf(rs.getInt("isManager"));
								searchEmp[i][21] = String.valueOf(rs.getInt("manId"));
								i++;
							}
							sess.setAttribute("searchEmp", searchEmp);
							request.getRequestDispatcher("searchResultEmp.jsp").forward(request, response);

						} else {
							System.out.println("No Employee with entered Name matched...");
							sess.setAttribute("searchFlag", "No Employee with entered Name matched...");
							request.getRequestDispatcher("searchEmp.jsp").forward(request, response);
						}

					} catch (SQLException e) {
						System.out.println(e.getMessage());
						sess.setAttribute("searchFlag", "SQL Exception...");
						request.getRequestDispatcher("searchEmp.jsp").forward(request, response);
					}

				} else {
					System.out.println("No Employee with entered Name matched...");
					sess.setAttribute("searchFlag", "No Employee with entered Name matched...");
					request.getRequestDispatcher("searchEmp.jsp").forward(request, response);
				}
			}
		}
	}
}
