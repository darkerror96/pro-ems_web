/**
 * 
 */
package com.collabera.ems.model;

/**
 * @author rutpatel
 *
 */
public class Person {

	private String name;
	private int age;
	private int gender;
	private long contactNo;
	private int aHomeId;
	private int aWorkId;

	public Person(String name, int age, int gender, long contactNo, int aHomeId, int aWorkId) {
		this.name = name;
		this.age = age;
		this.gender = gender;
		this.contactNo = contactNo;
		this.aHomeId = aHomeId;
		this.aWorkId = aWorkId;
	}

	public String getName() {
		return name;
	}

	public int getAge() {
		return age;
	}

	public int getGender() {
		return gender;
	}

	public long getContactNo() {
		return contactNo;
	}

	public int getaHomeId() {
		return aHomeId;
	}

	public int getaWorkId() {
		return aWorkId;
	}

}
