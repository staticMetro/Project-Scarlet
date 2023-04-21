//
//  PeriodDataManager.swift
//  Periodic
//
//  Created by Aimeric on 4/9/23.
//

import Foundation

enum PeriodDataManagingResponseStatus<T> {
    case initial
    case loading
    case failed(NSError)
    case success(T)
}

protocol PeriodDataManaging {
    func fetchUserInfo(completion: @escaping (PeriodDataManagingResponseStatus<[PeriodModel]>) -> Void)
    func fetchUserPeriodInfo(completion: @escaping (PeriodDataManagingResponseStatus<[PeriodModel]>) -> Void)
}

struct PeriodDataManager: PeriodDataManaging {
    
    private struct Constant {
        // swiftlint:disable nesting
        struct URL {
            static let apiURLStringUsers = "https://scarlet-server.herokuapp.com/api/v1/users"
            static let apiURLStringUserPeriod = "https://scarlet-server.herokuapp.com/api/v1/period"
        }
        // swiftlint:enable nesting
    }
    
    func fetchUserInfo(completion: @escaping (PeriodDataManagingResponseStatus<[PeriodModel]>) -> Void) {
        fetchData(urlString: Constant.URL.apiURLStringUsers, modelType: PeriodModel.self, completion: { completion($0) })
    }
    
    func fetchUserPeriodInfo(completion: @escaping (PeriodDataManagingResponseStatus<[PeriodModel]>) -> Void) {
        fetchData(urlString: Constant.URL.apiURLStringUserPeriod, modelType: PeriodModel.self, completion: { completion($0) })
    }
    
    private func fetchData<T: Decodable>(urlString: String, modelType: T.Type,
                                         completion: @escaping (PeriodDataManagingResponseStatus<[T]>) -> Void) {
        
        guard let urlLink = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        else {
            completion(.failed(NSError(domain: "Error: cannot create URL", code: 10001)))
            return
        }
        
        guard let url = URL(string: urlLink) else {
            completion(.failed(NSError(domain: "Error: cannot create URL", code: 10001)))
            return
        }
        completion(.loading)
        URLSession.shared.dataTask(with: url, completionHandler: {(responseData, _, error) in
            guard let rawData = responseData else {
                completion(.failed(NSError(domain:
                                            "Error: Something went wrong, please try it again later", code: 10002)))
                return
            }
            
            do {
                let data = try JSONDecoder().decode([T].self, from: rawData)
                completion(.success(data))
            } catch let error {
                completion(.failed(NSError(domain:
                                            "Error: Something went wrong, please try it again later. Message: \(error.localizedDescription)",
                                           code: 10002)))
            }
        }).resume()
        
    }
}
