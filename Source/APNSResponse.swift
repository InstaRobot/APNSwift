//
//  APNSResponse.swift
//  Smart APN
//
//  Created by Kaunteya Suryawanshi on 23/07/16.
//  Copyright © 2016 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation
extension APNS {
    struct Response {

        let apnsId: String?
        let serviceStatus: APNS.ServiceStatus
        var errorReason: APNS.Error?

        init(response: NSHTTPURLResponse, data: NSData?) {
            apnsId = response.allHeaderFields["apns-id"] as? String
            serviceStatus = APNS.ServiceStatus(rawValue: response.statusCode)!

            if serviceStatus != .Success {
                let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0))
                if let reason = json["reason"] as? String {
                    errorReason = APNS.Error(rawValue: reason)
                }
            }
        }
    }
}