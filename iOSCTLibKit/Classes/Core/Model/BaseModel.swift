//
//  BaseModel.swift
//  iOSCTLibKit
//
//  Created by Robin Shen on 2022/5/11.
//

import Foundation

struct NoneRes: Codable { }

struct BaseModel<T: Codable>: Codable {
    var status: Int?
    var data: T?
    var msg: String?
}
