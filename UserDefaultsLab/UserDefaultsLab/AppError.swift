//
//  AppError.swift
//  UserDefaultsLab
//
//  Created by Anthony Gonzalez on 9/24/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import Foundation

enum AppError: Error {
    case unauthenticated
    case invalidJSONResponse
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case badURL
    case badStatusCode
    case noDataReceived
    case notAnImage
    case other(rawError: Error)
}
