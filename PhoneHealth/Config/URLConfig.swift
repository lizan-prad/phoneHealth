//
//  URLConfig.swift
//  VenueFinder
//
//  Created by Lizan on 22/12/2021.
//

import Foundation
import CoreData

enum URLConfig {
    
    static let baseUrl = "https://qa-fonehealthapp-api.cogenthealth.com.np/fonehealth-app/api/v1/"//"http://10.13.171.39:8081/fonehealth-app/api/v1/" //
    //"https://uat-fonehealthapp-api.cogenthealth.com.np/fonehealth-app/api/v1/"
    static let apiKey = "fsq3j9q7oWWvICR6BzHmAo/cP6APlcP2SgONl6p3Rl4EyHk="
    static let minioBase = "public/user/"
    enum Modules {
        static let registration = URLConfig.baseUrl + "user/mobile-number-verification"
        static let otpVerification = URLConfig.baseUrl + "user/otp-verification"
        static let setPassword = URLConfig.baseUrl + "user/save-password"
        static let login = URLConfig.baseUrl + "user/login"
        static let getProvinence = URLConfig.baseUrl + "address/new/province"
    }

    static var venueList: String {
        return baseUrl + "places/search"
    }
    
    enum RandomImageUrls {
        static let venueUrls: [String] = [ "https://fastly.4sqi.net/img/general/original/522527553_YrryJcvtakIn4ktsBaYBfjtawSqL_yK0c-lH5JM4Qps.jpg", "https://fastly.4sqi.net/img/general/original/57548680_Uzg-KXrFPIteWDtC6ONIE8IyiPncJHxAYU5uWDa72LQ.jpg", "https://fastly.4sqi.net/img/general/original/9610309_s6tI2jeDUas4NI8jakt-JT4GgdpaXYpf_yU8_baHL8o.jpg", "https://fastly.4sqi.net/img/general/original/539103_OiEqWwJ6bDlxaWkS51shP6SGs5BNoAhxLAaHjAoeyik.jpg", "https://fastly.4sqi.net/img/general/original/50176003_N5s5ZAFMQZRl2TOe_yCcO7EcX_yAluFu7Wddp-9bGX8.jpg"
        ]
    }
}
