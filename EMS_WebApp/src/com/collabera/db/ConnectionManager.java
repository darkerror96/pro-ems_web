/**
 * 
 */
package com.collabera.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * @author rutpatel
 *
 */
public class ConnectionManager {

	private static Connection con;

	public static Connection getConnection() {

		if (con == null) {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				con = DriverManager.getConnection("jdbc:mysql://localhost/EMS_DB?serverTimezone=EST5EDT", "root", "");
			} catch (ClassNotFoundException e) {
				System.out.println(e.getMessage());
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return con;
	}
}
