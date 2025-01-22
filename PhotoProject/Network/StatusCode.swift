//
//  StatusCode.swift
//  PhotoProject
//
//  Created by 이빈 on 1/22/25.
//

import Foundation

enum StatusCode {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case serverError
    case unknownError
    
    var title: String {
        switch self {
        case .badRequest:
            return "Bad Request"
        case .unauthorized:
            return "Unauthorized"
        case .forbidden:
            return "Forbidden"
        case .notFound:
            return "Not Found"
        case .serverError:
            return "Server Error"
        case .unknownError:
            return "Unknown Error"
        }
    }
    
    var description: String {
        switch self {
        case .badRequest:
            return "The request was unacceptable, often due to missing a required parameter"
        case .unauthorized:
            return "Invalid Access Token"
        case .forbidden:
            return "Missing permissions to perform request"
        case .notFound:
            return "The requested resource doesn’t exist"
        case .serverError:
            return "Something went wrong on our end"
        case .unknownError:
            return "Unknown Error Occurred"
        }
    }
}
