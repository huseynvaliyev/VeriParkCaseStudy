//
//  NetworkService.swift
//  VeriPark
//
//  Created by Huseyn Valiyev on 25.09.2021.
//

import Foundation

struct NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func startWithHandshake(id: String, systemVersion: String, modelName: String ,completion: @escaping(Result<Handshake, Error>) -> Void) {
        let params = ["deviceId": id, "systemVersion": systemVersion, "platformName": "iOS", "deviceModel": modelName, "manifacturer": "Apple"] as [String : Any]
        request(route: .handshake, method: .post, parameters: params, completion: completion)
    }
    
    func getStockList(auth:String, period: String, completion: @escaping(Result<Stocks, Error>) -> Void) {
        let params = ["period": period] as [String: Any]
        request(route: .stockList, method: .post, parameters: params, auth: auth, completion: completion)
    }
    
    private func request<T: Decodable>(route: Route, method: Methods, parameters: [String: Any], auth: String? = nil ,completion: @escaping(Result<T, Error>) -> Void) {
        
        guard let request = createRequest(route: route, method: method, parameters: parameters, auth: auth) else {
            completion(.failure(AppError.unknownError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            var result: Result<Data, Error>?
            if let data = data {
                result = .success(data)
                let responseString = String(data: data, encoding: .utf8) ?? "Could not stringify our data"
                print("The response is:\n \(responseString)")
            } else if let error = error {
                result = .failure(error)
                print("The error is: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.handleResponse(result: result, completion: completion)
            }
            
        }.resume()
        
    }
    
    
    private func handleResponse<T: Decodable>(result: Result<Data, Error>?, completion: (Result<T, Error>) -> Void) {
        guard let result = result else {
            completion(.failure(AppError.unknownError))
            return
        }
        
        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(T.self, from: data) else {
                completion(.failure(AppError.errorDecoding))
                return
            }
            completion(.success(response))
        case .failure(let error):
            completion(.failure(error))
        }
        
    }
    
    
    private func createRequest(route: Route, method: Methods, parameters: [String: Any], auth: String? = nil) -> URLRequest? {
        let urlString = Route.baseURL + route.description
        guard let url = URL(string: urlString) else { return nil}
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let auth = auth {
            print("Auth: \(auth)")
            urlRequest.addValue(auth, forHTTPHeaderField: "X-VP-Authorization")
        }
        urlRequest.httpMethod = method.rawValue
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        return urlRequest
    }
    
}
