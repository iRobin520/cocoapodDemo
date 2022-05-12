//
//  Dictionary.swift
//  Alamofire
//
//  Created by Robin Shen on 2022/5/11.
//

import Foundation

extension Dictionary {
    //两个字典合并
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
    
    //转化成JSON字符串
    func toJSONString() -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self,options: []) else {
            return nil
        }
        guard let str = String(data: data, encoding: .utf8) else {
            return nil
        }
        return str
    }
    
    //转化成Data
    func toJSONData() -> Data? {
        guard let data = try? JSONSerialization.data(withJSONObject: self,options: []) else {
            return nil
        }
        return data
    }
    
    //将字典转换为URL参数
    func toURLString() -> String {
        var parameters = [String]()
        for (key, value) in self {
            guard let keyString = key as? String  else {
                return ""
            }
            guard let valueString = value as? String  else {
                return ""
            }
            parameters.append(keyString + "=" + valueString)
        }
        return parameters.joined(separator: "&")
    }
    
    mutating func encodableMerge(dict: [Key: Value]) {
        for (k, v) in dict where (v as? Encodable) != nil {
            updateValue(v, forKey: k)
        }
    }
}
