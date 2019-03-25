/**
 * 
 */
package com.collabera.ems.model;

/**
 * @author rutpatel
 *
 */
public class Address {

	private int aId;
	private String streetAddress;
	private String city;
	private String state;
	private String country;
	private int zipCode;

	public Address(int aId, String streetAddress, String city, String state, String country, int zipCode) {
		this.aId = aId;
		this.streetAddress = streetAddress;
		this.city = city;
		this.state = state;
		this.country = country;
		this.zipCode = zipCode;
	}

	public int getaId() {
		return aId;
	}

	public String getStreetAddress() {
		return streetAddress;
	}

	public String getCity() {
		return city;
	}

	public String getState() {
		return state;
	}

	public String getCountry() {
		return country;
	}

	public int getZipCode() {
		return zipCode;
	}

	public String getFieldOrder() {
		return "aId, street, city, state, country, zipCode";
	}

	public static String getTableName() {
		return "Address";
	}

	public String getSelectClause() {
		return "select " + getFieldOrder() + " from " + getTableName();
	}

	public String getInsertStatement() {
		return "insert into " + getTableName() + " (" + getFieldOrder() + ") values " + "(?,?,?,?,?,?)";
	}

	public String getUpdateStatement() {
		return "update " + getTableName()
				+ " set street = ?, city = ?, state = ?, country = ?, zipCode = ? where aId = ?;";
	}

	public static String getDeleteStatement() {
		return "delete from " + getTableName() + " where aId = ?";
	}
}