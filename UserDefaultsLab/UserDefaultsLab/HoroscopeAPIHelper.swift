//
//  HoroscopeAPIHelper.swift
//  UserDefaultsLab
//
//  Created by Anthony Gonzalez on 9/24/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import Foundation

class HoroscopeAPIManager {
    private init() {}
    
    static let shared = HoroscopeAPIManager()
    
    func getHoroscope(urlString: String, completionHandler: @escaping (Result<Horoscope, AppError>) -> Void) {
        let urlStr = "http://sandipbgt.com/theastrologer/api/horoscope/taurus/today/"
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        
        
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error) :
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let horoscopeInfo = try JSONDecoder().decode(Horoscope.self, from: data)
                    completionHandler(.success(horoscopeInfo))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
}
