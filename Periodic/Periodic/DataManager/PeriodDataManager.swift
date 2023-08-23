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
// port 2761

protocol PeriodDataManaging {
    func login(username: String, password: String, completion: @escaping (Bool, String) -> Void)
    func fetchUserInfo(completion: @escaping (PeriodDataManagingResponseStatus<[UserModel]>) -> Void)
    func testAPICall()
    func fetchUserPeriodInfo(completion: @escaping (PeriodDataManagingResponseStatus<[PeriodModel]>) -> Void)
}

struct PeriodDataManager: PeriodDataManaging {
    private struct Constant {
        // swiftlint:disable nesting
        struct URL {
            static let baseURL = "https://scarlet-server.herokuapp.com/api/v1/"
            static let apiURLStringUsers = "\(baseURL)users"
            static let apiURLStringUserPeriod = "\(baseURL)period"
            static let apiURLStringUserReviews = "\(baseURL)reviews"
            static let apiURLLogin = "\(baseURL)users/login"
            static let apiURLForgotPassword = "\(baseURL)users/forgotPassword"
            static let apiURLResetPassword = "\(baseURL)users/resetPassword/d8e43977e7ed4698cfcc5ca995777016cf0ee3e016fab5938fa6e2ff2e5d414f"
            static let apiURLVerifyUser = "http://127.0.0.1:5000/api/v1/users/verify/ce2a98738290fd5282084351c2705cae0a2fc9fd23f243f55c56f5a647c90b54"
            static let apiURLSignUp = "\(baseURL)users/signup"
        }
        struct Token {
            // swiftlint:disable line_length
            static let jwt = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0NTE5YTYwMGZkMzRiZjY5NTAyZThkZiIsImlhdCI6MTY4MzI0NTUyNSwiZXhwIjoxNjg1MDU5OTI1fQ.ztGByLJxIII0ztVh66OpWMRIjgCXw_quzKE9fUVGhk0"
            // swiftlint:enable line_length
        }
        // swiftlint:enable nesting
    }
    func login(username: String, password: String, completion: @escaping (Bool, String) -> Void) {
        guard let url = URL(string: Constant.URL.apiURLLogin) else {
            completion(false, "error")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let params: [String: String] = [
            "email": username,
            "password": password
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.allHTTPHeaderFields = [
                    "Content-Type": "application/json",
                    "Authentication": "Bearer \(Constant.Token.jwt)",
                    "cache-control": "no-cache"
        ]
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil, let data = data,
                    let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(false, "error")
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            let successString = json?["status"] as? String ?? ""
            let success = successString.lowercased() == "success"
            if success {
                completion(true, successString.lowercased())
            } else {
                print("error")
                completion(false, "error")
            }
        }
        task.resume()
    }
    func forgotPassword(_ email: String, completion: @escaping (Bool, String) -> Void) {
        guard let url = URL(string: Constant.URL.apiURLLogin) else {
            completion(false, "error")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let params: [String: String] = [
            "email": email
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.allHTTPHeaderFields = [
                    "Content-Type": "application/json",
                    "Authentication": "Bearer \(Constant.Token.jwt)",
                    "cache-control": "no-cache"
        ]
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil, let data = data,
                    let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(false, "error")
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            let successString = json?["status"] as? String ?? ""
            let success = successString.lowercased() == "success"
            if success {
                completion(true, successString.lowercased())
            } else {
                print("error")
                completion(false, "error")
            }
        }
        task.resume()
    }
    func resetPassword(_ password: String, _ passwordConfirm: String, completion: @escaping (Bool, String) -> Void) {
        guard let url = URL(string: Constant.URL.apiURLLogin) else {
            completion(false, "error")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        let params: [String: String] = [
            "password": password,
            "passwordConfirm": passwordConfirm
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.allHTTPHeaderFields = [
                    "Content-Type": "application/json",
                    "Authentication": "Bearer \(Constant.Token.jwt)",
                    "cache-control": "no-cache"
        ]
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil, let data = data,
                    let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(false, "error")
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            let successString = json?["status"] as? String ?? ""
            let success = successString.lowercased() == "success"
            if success {
                completion(true, successString.lowercased())
            } else {
                print("error")
                completion(false, "error")
            }
        }
        task.resume()
    }
    func signUp(_ email: String, _ firstName: String,_ lastName: String, _ password: String, _ passwordConfirm: String, completion: @escaping (Bool, String) -> Void) {
        guard let url = URL(string: Constant.URL.apiURLLogin) else {
            completion(false, "error")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let params: [String: String] = [
            "email": email,
            "firstName": firstName,
            "lastName": lastName,
            "password": password,
            "passwordConfirm": passwordConfirm
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.allHTTPHeaderFields = [
                    "Content-Type": "application/json",
                    "Authentication": "Bearer \(Constant.Token.jwt)",
                    "cache-control": "no-cache"
        ]
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil, let data = data,
                    let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(false, "error")
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            let successString = json?["status"] as? String ?? ""
            let success = successString.lowercased() == "success"
            if success {
                completion(true, successString.lowercased())
            } else {
                print("error")
                completion(false, "error")
            }
        } 
        task.resume()
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
