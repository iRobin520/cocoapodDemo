//
//  EnvConfig.swift
//  iOSCTLibKit
//
//  Created by Robin Shen on 2022/5/11.
//

import Foundation

//环境变量
enum Env {
    case PRO //生产
    case TEST //测试
    case DEV //开发
}

//应用编译模式
enum BuildMode {
    case RELEASE //发布模式
    case DEBUG //调试模式
}

class EnvConfig {
    //当前环境
    let currentEvn: Env = Env.TEST
    //编译模式
    let buildMode: BuildMode = BuildMode.DEBUG
    //环境BaseUrl
    var baseUrls: [Env: String] = [
        Env.PRO: "https://jsonplaceholder.typicode.com/",
        Env.TEST: "https://jsonplaceholder.typicode.com/",
        Env.DEV: "https://jsonplaceholder.typicode.com/",
    ]
    //获取当前环境的BaseUrl
    var currentBaseUrl: String {
        get {
            return baseUrls[currentEvn]!
        }
    }
}
