/**
 * 
 */
package com.collabera.db;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * @author rutpatel
 *
 */
public class GetEmployee {

	public static String[][] getEmployee(int eId) {

		try {

			String[][] empDb = new String[1][22];

			PreparedStatement pst = ConnectionManager.getConnection().prepareStatement(
					"SELECT E.eId, E.name, E.age, G.gType,E.contactNo,AH.street, AH.city,AH.state,AH.country,AH.zipCode,AW.street, AW.city,AW.state,AW.country,AW.zipCode,E.ssn,E.email,J.jType, D.dType,E.salary,E.isManager,E.manId  FROM Employee E JOIN Address AH ON E.aHomeId = AH.aId JOIN Address AW ON E.aWorkId = AW.aId JOIN Gender G ON E.gId = G.gId JOIN Department D ON E.dId = D.dId JOIN JobTitle J ON E.jId = J.jId WHERE E.eId = ?;");
			pst.setInt(1, eId);

			ResultSet rsEmp = pst.executeQuery();

			if (rsEmp.next()) {
				empDb[0][0] = String.valueOf(rsEmp.getInt("eId"));
				empDb[0][1] = rsEmp.getString("name");
				empDb[0][2] = String.valueOf(rsEmp.getInt("age"));
				empDb[0][3] = rsEmp.getString("gType");
				empDb[0][4] = String.valueOf(rsEmp.getInt("contactNo"));
				empDb[0][5] = rsEmp.getString("AH.street");
				empDb[0][6] = rsEmp.getString("AH.city");
				empDb[0][7] = rsEmp.getString("AH.state");
				empDb[0][8] = rsEmp.getString("AH.country");
				empDb[0][9] = String.valueOf(rsEmp.getInt("AH.zipCode"));
				empDb[0][10] = rsEmp.getString("AW.street");
				empDb[0][11] = rsEmp.getString("AW.city");
				empDb[0][12] = rsEmp.getString("AW.state");
				empDb[0][13] = rsEmp.getString("AW.country");
				empDb[0][14] = String.valueOf(rsEmp.getInt("AW.zipCode"));
				empDb[0][15] = String.valueOf(rsEmp.getInt("ssn"));
				empDb[0][16] = rsEmp.getString("email");
				empDb[0][17] = rsEmp.getString("jType");
				empDb[0][18] = rsEmp.getString("dType");
				empDb[0][19] = String.valueOf(rsEmp.getDouble("salary"));
				empDb[0][20] = String.valueOf(rsEmp.getInt("isManager"));
				empDb[0][21] = String.valueOf(rsEmp.getInt("manId"));
			}

//			for (int i = 0; i < empDb.length; i++) {
//				for (int j = 0; j < empDb[i].length; j++) {
//					System.out.println(empDb[i][j]);
//				}
//			}

			return empDb;
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return null;
	}
}
