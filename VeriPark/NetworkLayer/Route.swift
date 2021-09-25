//
//  Route.swift
//  VeriPark
//
//  Created by Huseyn Valiyev on 25.09.2021.
//

import Foundation

enum Route {
    static let baseURL = "https://mobilechallenge.veripark.com/api"
    
    case handshake
    case stockList
    case stockDetail
    
    var description: String {
        switch self {
        case .handshake:
            return "/handshake/start"
        case .stockList:
            return "/stocks/list"
        case .stockDetail:
            return "/stocks/detail"
        }
    }
    
}
