//
//  NetworkingService.swift
//  ReposTest
//
//  Created by Ангеліна Семенченко on 21.06.2023.
//

import Foundation
import Alamofire

final class APIService {
    static let shared = APIService()
    private let baseURL = "https://api.github.com"
    let dbManager = DBManager.shared
    
    private init() {}
    
    func getUsers(page: Int, since: Int?, completion: @escaping (Result<[User], Error>) -> Void) {
        var path = "/users"
        let parameters: [String: Any] = [
            "page": page,
            "per_page": 10
        ]
        
        if let since = since {
            path += "?since=\(since)"
        }
        
        request(path: path, parameters: parameters, completion: completion)
    }
    
    func getRepos(for user: String, page: Int, completion: @escaping (Result<[Repo], Error>) -> Void) {
        let path = "/users/\(user)/repos"
        let parameters: [String: Any] = [
            "page": page,
            "per_page": 10
        ]
        
        request(path: path, parameters: parameters, completion: completion)
    }
    
    private func request<T: Decodable>(path: String, parameters: [String: Any], completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(baseURL + path, parameters: parameters)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    completion(.failure(error))
                }
            }
    }
}

