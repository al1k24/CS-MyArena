//
//  MyArenaManager.swift
//  CS-MyArena
//
//  Created by Алик on 18.02.2021.
//

import Foundation
import Alamofire

enum ServerStatus: Int {
    case offline = 0, online, restart
}

enum Query: String {
    case status //Статус сервера
    case start //Включение сервера
    case stop //Выключение сервера
    case restart //Перезапуск сервера
    case changelevel //Смена карты на сервере
    case getmaps //Вывод списка карт
    case consolecmd //Выполнить консольную команду
    case getresources//Информация о ресурсах
    
//    var path {
//        switch self {
//        case .status {
//            return ""
//        }
//        }
//    }
}

class MyArenaService {
    
    private init() {}
    static let shared = MyArenaService()
    
    private let host = "https://myarena.ru/api.php"
    
    func fetchData<T: Decodable>(of: T.Type,
                                 by token: String,
                                 for query: Query,
                                 with param: Parameters?,
                                 completion: @escaping (Result<ServerResult, NetworkError>) -> Void) {
        
        request(of: ServerResult.self, token: token, query: .status, parameters: param) { (result) in
            guard let result = result else {
                completion(.failure(.invalidData))
                return
            }
            
            if result.message != nil {
                completion(.failure(.invalidToken))
                return
            }
            
            completion(.success(result))
        }
    }
    
    private func request<T: Decodable>(of: T.Type, token: String, query: Query, parameters: Parameters?, completion: @escaping (T?) -> Void) {
        let fullUrl = formatUrl(with: query, and: token)
        AF.request(fullUrl, method: .get, parameters: parameters).validate()
            .responseDecodable(of: T.self) { (response) in
                if let data = response.value {
                    completion(data)
                } else {
                    completion(nil)
                }
        }
    }
    
    private func formatUrl(with query: Query, and token: String) -> String {
        return "\(host)?token=\(token)&query=\(query.rawValue)"
    }
}
