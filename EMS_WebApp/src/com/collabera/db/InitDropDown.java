/**
 * 
 */
package com.collabera.db;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

/**
 * @author rutpatel
 *
 */
public class InitDropDown {

	public static void initDropDown(HttpSession sess) throws SQLException {

		try {
			Statement st = ConnectionManager.getConnection().createStatement();

			// ----------Initialize Employee Database into String[][]--------
			int row = 0;
			ResultSet rsRow = st.executeQuery("select count(*) from Employee");
			if (rsRow.next()) {
				row = rsRow.getInt(1);
			} else {
				row = 1;
			}

			int i = 0;
			String[][] empDb = new String[row][22];
			ResultSet rsEmp = st.executeQuery(
					"SELECT E.eId, E.name, E.age, G.gType,E.contactNo,AH.street, AH.city,AH.state,AH.country,AH.zipCode,AW.street, AW.city,AW.state,AW.country,AW.zipCode,E.ssn,E.email,J.jType, D.dType,E.salary,E.isManager,E.manId  FROM Employee E JOIN Address AH ON E.aHomeId = AH.aId JOIN Address AW ON E.aWorkId = AW.aId JOIN Gender G ON E.gId = G.gId JOIN Department D ON E.dId = D.dId JOIN JobTitle J ON E.jId = J.jId ORDER BY E.eId ASC;");
			while (rsEmp.next()) {
				empDb[i][0] = String.valueOf(rsEmp.getInt("eId"));
				empDb[i][1] = rsEmp.getString("name");
				empDb[i][2] = String.valueOf(rsEmp.getInt("age"));
				empDb[i][3] = rsEmp.getString("gType");
				empDb[i][4] = String.valueOf(rsEmp.getInt("contactNo"));
				empDb[i][5] = rsEmp.getString("AH.street");
				empDb[i][6] = rsEmp.getString("AH.city");
				empDb[i][7] = rsEmp.getString("AH.state");
				empDb[i][8] = rsEmp.getString("AH.country");

				empDb[i][9] = StringConverter.zipCodeConv(String.valueOf(rsEmp.getInt("AH.zipCode")));

				empDb[i][10] = rsEmp.getString("AW.street");
				empDb[i][11] = rsEmp.getString("AW.city");
				empDb[i][12] = rsEmp.getString("AW.state");
				empDb[i][13] = rsEmp.getString("AW.country");

				empDb[i][14] = StringConverter.zipCodeConv(String.valueOf(rsEmp.getInt("AW.zipCode")));

				empDb[i][15] = StringConverter.ssnConv(String.valueOf(rsEmp.getInt("ssn")));

				empDb[i][16] = rsEmp.getString("email");
				empDb[i][17] = rsEmp.getString("jType");
				empDb[i][18] = rsEmp.getString("dType");
				empDb[i][19] = String.valueOf(rsEmp.getDouble("salary"));
				empDb[i][20] = String.valueOf(rsEmp.getInt("isManager"));
				empDb[i][21] = String.valueOf(rsEmp.getInt("manId"));
				i++;
			}
			sess.setAttribute("empDb", empDb);

			// System.out.println(Arrays.deepToString(empDb));

			// ----------Initialize Employee Id and Name into String[][]--------
			int rowEN = 0;
			ResultSet rsRowEN = st.executeQuery("select count(*) from Employee");
			if (rsRowEN.next()) {
				rowEN = rsRowEN.getInt(1);
			} else {
				rowEN = 1;
			}

			int iEN = 0;
			String[][] empDbEN = new String[rowEN][3];
			ResultSet rsEmpEN = st
					.executeQuery("SELECT E.eId, E.name, E.isManager FROM Employee E ORDER BY E.eId DESC;");
			while (rsEmpEN.next()) {
				empDbEN[iEN][0] = String.valueOf(rsEmpEN.getInt("eId"));
				empDbEN[iEN][1] = rsEmpEN.getString("name");
				empDbEN[iEN][2] = String.valueOf(rsEmpEN.getInt("isManager"));
				iEN++;
			}
			sess.setAttribute("empDbEN", empDbEN);

			// System.out.println(Arrays.deepToString(empDb));

			// -------Initialize Drop-down List JobTitle----------
			ArrayList<String> jobList = new ArrayList<String>();
			ResultSet rsJt = st.executeQuery("select jType from JobTitle");
			while (rsJt.next()) {
				jobList.add(rsJt.getString(1));
			}
			sess.setAttribute("jobList", jobList);

			// -------Initialize Drop-down List Department----------
			ArrayList<String> deptList = new ArrayList<String>();
			ResultSet rsD = st.executeQuery("select dType from Department");
			while (rsD.next()) {
				deptList.add(rsD.getString(1));
			}
			sess.setAttribute("deptList", deptList);

			// -------Initialize Drop-down List Manager----------
			ArrayList<String> manList = new ArrayList<String>();
			ResultSet rsM = st.executeQuery("select manId, details from Manager");
			while (rsM.next()) {
				if (rsM.getInt(1) != 0) {
					manList.add(rsM.getString(2) + " : " + rsM.getInt(1));
				}
			}
			sess.setAttribute("manList", manList);

			// -------Initialize Drop-down List Employee----------
			ArrayList<String> empList = new ArrayList<String>();
			ResultSet rsE = st.executeQuery("select eId, name, isManager from Employee");
			while (rsE.next()) {
				if (rsE.getInt(3) == 0) {
					empList.add(rsE.getString(2) + " : " + rsE.getInt(1));
				}

			}
			sess.setAttribute("empList", empList);

		} catch (SQLException e) {
			System.out.println("InitDropDown Error...\n" + e.getMessage());
		}
	}
}
