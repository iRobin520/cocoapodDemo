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
        let params = ToDoTaskRequestParams(userId: "1")
        return HttpClient.sharedInstance.get(ToDoTask.self, requestUrl: "todos/1", parameters: params)
    }
}

struct ToDoTaskRequestParams: RequestParams {
    var userId:String?
}
