//
//  PeriodDataManager.swift
//  Periodic
//
//  Created by Aimeric on 4/9/23.
//

import Foundation
import PostgresNIO
import NIO
import NIOTransportServices

enum PeriodDataManagingResponseStatus<T> {
    case initial
    case loading
    case failed(NSError)
    case success(T)
}
//port 2761

protocol PeriodDataManaging {
    func fetchUserInfo(completion: @escaping (PeriodDataManagingResponseStatus<[UserModel]>) -> Void)
    func testAPICall()
    func fetchUserPeriodInfo(completion: @escaping (PeriodDataManagingResponseStatus<[PeriodModel]>) -> Void)
}

struct PeriodDataManager: PeriodDataManaging {
    private struct Constant {
        // swiftlint:disable nesting
        struct URL {
            static let apiURLStringUsers = "https://scarlet-server.herokuapp.com/api/v1/users"
            static let apiURLStringUserPeriod = "https://scarlet-server.herokuapp.com/api/v1/period"
            static let apiURLStringUserReviews = "https://scarlet-server.herokuapp.com/api/v1/reviews"

        }
        // swiftlint:enable nesting
    }
    func testAPICall() {
        guard let url = URL(string: Constant.URL.apiURLStringUsers) else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle errors
            guard error == nil else {
                print("Error: \(error!)")
                return
            }
            // Handle response
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
            // Handle data
            guard let data = data else {
                print("No data returned")
                return
            }
            // Convert data to JSON
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("JSON response: \(json)")
            } catch let error {
                print("Error parsing JSON: \(error)")
            }
        }

        task.resume()

    }
    func testAPIPostToUSER() {
        guard let url = URL(string: Constant.URL.apiURLStringUsers) else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var v1ApiToken = ""
        // Model to Data Convert (JSONEncoder() + Encodable)
        request.allHTTPHeaderFields = [
                    "Content-Type" : "application/json",
                    "Accept" : "application/json",
                    "Authentication" : "Bearer \(v1ApiToken)",
                    "cache-control" : "no-cache"
        ]
        

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle errors
            guard error == nil else {
                print("Error: \(error!)")
                return
            }
            // Handle response
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
            // Handle data
            guard let data = data else {
                print("No data returned")
                return
            }
            // Convert data to JSON
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("JSON response: \(json)")
            } catch let error {
                print("Error parsing JSON: \(error)")
            }
        }

        task.resume()

    }
    

    func fetchUserInfo(completion: @escaping (PeriodDataManagingResponseStatus<[UserModel]>) -> Void) {
        fetchData(urlString: Constant.URL.apiURLStringUsers,
                  modelType: UserModel.self,
                  completion: { completion($0) })
    }
    func fetchUserPeriodInfo(completion: @escaping (PeriodDataManagingResponseStatus<[PeriodModel]>) -> Void){
        fetchData(urlString: Constant.URL.apiURLStringUserPeriod,
                  modelType: PeriodModel.self,
                  completion: { completion($0) })
    }
    private func fetchData<T: Decodable>(urlString: String,
                                         modelType: T.Type,
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
    private func postUserData <T: Decodable>(urlString: String, modelType: T.Type,
                                             completion: @escaping (PeriodDataManagingResponseStatus<[T]>) -> Void) {
        guard let urlLink = urlString.addingPercentEncoding(withAllowedCharacters:
                                                            NSCharacterSet.urlQueryAllowed) else {
            completion(.failed(NSError(domain: "Error: cannot create URL", code: 10001)))
            return
        }
        guard let url = URL(string: urlLink) else {
            completion(.failed(NSError(domain: "Error: cannot create URL", code: 10001)))
            return
        }
        completion(.loading)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // Model to Data Convert (JSONEncoder() + Encodable)
        request.allHTTPHeaderFields = [
                    "Content-Type": "application/json"
        ]

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            do {
                // Data to Model convert - JSONDecoder() + Decodable
                let userResponse = try JSONDecoder().decode(UserModel.self, from: data)
                print(userResponse)
            }catch {
                print(error)
            }
        }.resume()
    }
    private func postPeriodData <T: Decodable>(urlString: String, modelType: T.Type,
                                         completion: @escaping (PeriodDataManagingResponseStatus<[T]>) -> Void) {
        guard let urlLink = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            completion(.failed(NSError(domain: "Error: cannot create URL", code: 10001)))
            return
        }
        guard let url = URL(string: urlLink) else {
            completion(.failed(NSError(domain: "Error: cannot create URL", code: 10001)))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Model to Data Convert (JSONEncoder() + Encodable)
        request.allHTTPHeaderFields = [
                    "Content-Type": "application/json"
                ]

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            do {
                // Data to Model convert - JSONDecoder() + Decodable
                let userResponse = try JSONDecoder().decode(UserModel.self, from: data)
                print(userResponse)
            }catch {
                print(error)
            }
        }.resume()
    }
    
}
