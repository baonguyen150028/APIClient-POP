//
//  APIClient.swift
//  APIAwaken
//
//  Created by The Bao on 11/22/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import Foundation
typealias JSON = [String: Any]
typealias JSONTaskCompletion = (JSON?,HTTPURLResponse?,Error?) -> Void
typealias JSONTask = URLSessionDataTask

enum APIResult<T:JSONDecodable>{
    case Success(SpeciesWrapper<T>)
    case Failure(Error)
}
protocol JSONDecodable {
    init?(json: JSON)
}
protocol EndPoint{
    var baseURL: URL { get }
    var path: String { get }
    var request: URLRequest { get }
}

protocol APIClient {
    var configuration: URLSessionConfiguration { get }
    var session: URLSession { get }
    func JSONTaskWithRequest(request: URLRequest, completion: @escaping JSONTaskCompletion) -> JSONTask
    func parseJSON<T:JSONDecodable>(request: URLRequest, parse: @escaping (JSON) -> SpeciesWrapper<T>?, completion: @escaping (APIResult<T>) -> Void)
}

extension APIClient {
    func JSONTaskWithRequest(request: URLRequest, completion:  @escaping JSONTaskCompletion) -> JSONTask {

        let task = session.dataTask(with: request, completionHandler: {
            data, response, error in
            guard let HTTPResponse = response as? HTTPURLResponse else{
                return
            }
            if data == nil {
                if let error = error {
                    completion(nil, HTTPResponse, error)
                }
            } else {
                switch HTTPResponse.statusCode {
                case 200:
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as?  [String: Any]
                        completion(json, HTTPResponse, nil)
                    } catch let error {
                        print(error)
                        completion(nil, HTTPResponse, nil)
                    }
                default: print("Error Response")
                }
            }

        })
        return task
    }
    func parseJSON<T>(request: URLRequest, parse: @escaping (JSON) -> SpeciesWrapper<T>?, completion: @escaping (APIResult<T>) -> Void) {
        let task = JSONTaskWithRequest(request: request, completion: {
            json, response, error in
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        print(error)
                    } else {
                        // Error Handling
                    }
                    return
                }
                if let value = parse(json) {
                    completion(.Success(value))
                } else {
                    print(error)
                    //Error handling
                }

            }
        })
        task.resume()
    }
}








