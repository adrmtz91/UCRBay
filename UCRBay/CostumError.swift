//
//  CostumError.swift
//  UCRBay
//
//
import Foundation

enum CustomError: Error, Equatable {
    case invalidEmailFormat
    case weakPassword
    case usernameAlreadyExists
    case missingRequiredFields
    case invalidPhoneNumberFormat
}

extension CustomError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidEmailFormat:
            return "The email address format is invalid."
        case .weakPassword:
            return "The password is too weak."
        case .usernameAlreadyExists:
            return "The username already exists."
        case .missingRequiredFields:
            return "Some required fields are missing."
        case .invalidPhoneNumberFormat:
            return "The phone number format is invalid."
        }
    }
}
