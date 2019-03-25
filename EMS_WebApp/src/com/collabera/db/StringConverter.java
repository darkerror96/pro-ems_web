/**
 * 
 */
package com.collabera.db;

/**
 * @author rutpatel
 *
 */
public class StringConverter {

	public static String zipCodeConv(String zipCode) {
		int zipCodeL = zipCode.length();
		if (zipCodeL < 5) {
			for (int j = 0; (5 - zipCodeL - j) != 0; j++) {
				zipCode = "0" + zipCode;
			}
		}
		return zipCode;
	}

	public static String ssnConv(String ssn) {
		int ssnL = ssn.length();
		if (ssnL < 9) {
			for (int j = 0; (9 - ssnL - j) != 0; j++) {
				ssn = "0" + ssn;
			}
		}
		return ssn;
	}
}
