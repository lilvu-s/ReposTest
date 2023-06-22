//
//  NetworkingService.swift
//  ReposTest
//
//  Created by Ангеліна Семенченко on 21.06.2023.
//

import Alamofire

final class APIService {
    static let shared = APIService()
    private let baseURL = "https://api.github.com"
    
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
        
        AF.request(baseURL + path, parameters: parameters)
            .validate()
            .responseDecodable(of: [User].self) { response in
                switch response.result {
                case .success(let users):
                    completion(.success(users))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getRepos(for user: String, page: Int, completion: @escaping (Result<[Repo], Error>) -> Void) {
        let path = "/users/\(user)/repos"
        let parameters: [String: Any] = [
            "page": page,
            "per_page": 10
        ]
        
        AF.request(baseURL + path, parameters: parameters)
            .validate()
            .responseDecodable(of: [Repo].self) { response in
                switch response.result {
                case .success(let repos):
                    completion(.success(repos))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

