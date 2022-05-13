//
//  ToDoTask.swift
//  iOSCTLibKit
//
//  Created by Robin Shen on 2022/5/12.
//

import Foundation

public struct ToDoTask: Codable {
    var userId: Int?
    var id: Int?
    var title: String?
    var completed: Bool?
}
