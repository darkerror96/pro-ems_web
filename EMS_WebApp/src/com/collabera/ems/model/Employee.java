/**
 * 
 */
package com.collabera.ems.model;

/**
 * @author rutpatel
 *
 */
public class Employee extends Person {

	private int eId;
	private int ssn;
	private String email;
	private int jobTitle;
	private int dept;
	private double salary;
	private int reportTo;
	private int isManager;

	public Employee(int eId, String name, int age, int gender, long contactNo, int aHomeId, int aWorkId, int ssn,
			String email, int jobTitle, int dept, double salary, int reportTo, int isManager) {
		super(name, age, gender, contactNo, aHomeId, aWorkId);
		this.eId = eId;
		this.ssn = ssn;
		this.email = email;
		this.jobTitle = jobTitle;
		this.dept = dept;
		this.salary = salary;
		this.reportTo = reportTo;
		this.isManager = isManager;
	}

	public int geteId() {
		return eId;
	}

	public int getSsn() {
		return ssn;
	}

	public String getEmail() {
		return email;
	}

	public int getJobTitle() {
		return jobTitle;
	}

	public int getDept() {
		return dept;
	}

	public double getSalary() {
		return salary;
	}

	public int getReportTo() {
		return reportTo;
	}

	public int getIsManager() {
		return isManager;
	}

	public String getFieldOrder() {
		return "eId, name, age, gId, contactNo, aHomeId, aWorkId, ssn, email, jId, dId, salary, isManager, manId";
	}

	public static String getTableName() {
		return "Employee";
	}

	public String getSelectClause() {
		return "select " + getFieldOrder() + " from " + getTableName();
	}

//	public String getInsertStatement() {
//		return "insert into " + getTableName() + " (" + getFieldOrder() + ") values " + "(" + eId + ", '" + getName()
//				+ "', " + getAge() + ", " + getGender() + ", " + getContactNo() + ", " + getAddress().getaId() + ", "
//				+ getAddress().getaId() + ", " + ssn + ", '" + email + "', " + jobTitle + ", " + dept + ", " + salary
//				+ ", " + isManager + ", " + reportTo + ")";
//	}

	public String getEmpInsertStatement() {
		return "insert into " + getTableName() + " (" + getFieldOrder() + ") values " + "(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	}

	public String getManInsertStatement() {
		return "insert into Manager (manId, details) values (?,?)";
	}

	public String getEmpUpdateStatement() {
		return "update " + getTableName()
				+ " set name = ?, age = ?, gId = ?, contactNo = ?, ssn = ?, jId = ?, dId = ?, salary = ?, isManager = ?, manId = ? where eId = ?";
	}
	
	public String getManUpdateStatement() {
		return "update Manager set details = ? where manId = ?";
	}

	public static String getEmpDeleteStatement() {
		return "delete from " + getTableName() + " where eId = ?;";
	}

	public static String getManDeleteStatement() {
		return "delete from Manager where manId = ?;";
	}

}