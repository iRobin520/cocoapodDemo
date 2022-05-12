//
//  ToDo.swift
//  iOSCTLibKit
//
//  Created by Robin Shen on 2022/5/12.
//

import Foundation
import RxSwift

class ToDoService {
    //获取任务
    func getTodoTask() -> Observable<ToDoTask> {
        return HttpClient.sharedInstance.request(ToDoTask.self, requestUrl: "/todos/1", httpMethod: .get, parameters: [:])
    }
}

