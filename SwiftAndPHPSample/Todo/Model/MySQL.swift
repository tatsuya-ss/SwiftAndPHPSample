//
//  MySQL.swift
//  SwiftAndPHPSample
//
//  Created by 坂本龍哉 on 2021/12/07.
//

import Foundation

protocol MySQLProtocol {
    func fetch() async throws -> [Todo]
    func save(todo: String, deadline: String) async throws
}

final class MySQL: MySQLProtocol {
    
    func save(todo: String, deadline: String) async throws {
        let urlString = "http://localhost:8000/saveToDo.php"
        guard let requestURL = NSURL(string: urlString) else { throw MySQLError.urlError }
        let request = NSMutableURLRequest(url: requestURL as URL)
        request.httpMethod = "POST"
        let postParameters = "todo=" + todo + "&deadline=" + deadline
        request.httpBody = postParameters.data(using: .utf8)
        
        let (data, response) = try await URLSession.shared.data(for: request as URLRequest)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else { throw MySQLError.statusCodeError }
        do {
            guard let myJson = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary,
            let message = myJson["message"] as? String?  else { throw MySQLError.jsonError }
            print(#function, message)
        } catch {
            print("失敗\(error)")
        }
    }
    
    func fetch() async throws -> [Todo] {
        // php -S localhost:8000  -t ~/Desktop/PHP/Practice/MySQL を実行後のみ
        guard let url = URL(string: "http://localhost:8000/todo.php") else {
            throw MySQLError.urlError
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
                  throw MySQLError.statusCodeError
              }
        guard let result = try? JSONDecoder().decode([Todo].self, from: data) else {
            throw MySQLError.decodeError
        }
        return result
    }
    
}


enum MySQLError: Error {
    case urlError
    case statusCodeError
    case decodeError
    case jsonError
}
