//
//  Handshake.swift
//  VeriPark
//
//  Created by Huseyn Valiyev on 25.09.2021.
//

import Foundation

struct Handshake: Decodable {
    let aesKey: String
    let aesIV: String
    let authorization: String
}
