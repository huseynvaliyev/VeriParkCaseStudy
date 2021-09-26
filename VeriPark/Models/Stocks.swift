//
//  Stocks.swift
//  VeriPark
//
//  Created by Huseyn Valiyev on 26.09.2021.
//

import Foundation

struct Stocks: Decodable {
    let stocks: [Stock]
}

struct Stock: Decodable {
    let id: Int
    let isDown: Bool
    let isUp: Bool
    let bid: Double
    let difference: Double
    let offer: Double
    let price: Double
    let volume: Double
    let symbol: String
}
