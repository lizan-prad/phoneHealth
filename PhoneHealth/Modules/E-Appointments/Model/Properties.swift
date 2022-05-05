/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Properties : Mappable {
	var patientMobileNumber : String?
	var selfPayment : String?
	var parentAppointmentId : String?
	var patientGender : String?
	var esewaId : String?
	var patientAddress : String?
	var patientEsewaId : String?
	var patientName : String?
	var hospitaId : Int?
	var gender : String?
	var agent : String?
	var patientDateOfBirth : String?
	var mobileNumber : String?
	var patientId : String?
	var name : String?
	var appointmentReservationId : Int?
	var dateOfBirth : String?
	var createdDateNepali : String?
	var separate_integration : String?
	var followUp : String?
	var hospitalAppointmentServiceTypeId : Int?
	var patientEmail : String?
	var newRegistration : Bool?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		patientMobileNumber <- map["patientMobileNumber"]
		selfPayment <- map["selfPayment"]
		parentAppointmentId <- map["parentAppointmentId"]
		patientGender <- map["patientGender"]
		esewaId <- map["esewaId"]
		patientAddress <- map["patientAddress"]
		patientEsewaId <- map["patientEsewaId"]
		patientName <- map["patientName"]
		hospitaId <- map["hospitaId"]
		gender <- map["gender"]
		agent <- map["agent"]
		patientDateOfBirth <- map["patientDateOfBirth"]
		mobileNumber <- map["mobileNumber"]
		patientId <- map["patientId"]
		name <- map["name"]
		appointmentReservationId <- map["appointmentReservationId"]
		dateOfBirth <- map["dateOfBirth"]
		createdDateNepali <- map["createdDateNepali"]
		separate_integration <- map["separate_integration"]
		followUp <- map["followUp"]
		hospitalAppointmentServiceTypeId <- map["hospitalAppointmentServiceTypeId"]
		patientEmail <- map["patientEmail"]
		newRegistration <- map["newRegistration"]
	}

}