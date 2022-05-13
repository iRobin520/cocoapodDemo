//
//  DictionaryValue.swift
//  iOSCTLibKit
//
//  Created by Robin Shen on 2022/5/11.
//

import Foundation

public protocol RequestParams {
    var jsonValue: Any { get }
}

extension Int: RequestParams { public var jsonValue: Any { return self } }
extension Int32: RequestParams { public var jsonValue: Any { return self } }
extension Int64: RequestParams { public var jsonValue: Any { return self } }
extension Float: RequestParams { public var jsonValue: Any { return self } }
extension Double: RequestParams { public var jsonValue: Any { return self } }
extension String: RequestParams { public var jsonValue: Any { return self } }
extension Bool: RequestParams { public var jsonValue: Any { return self } }
extension Decimal: RequestParams { public var jsonValue: Any { return self.description } }
extension Optional: RequestParams where Wrapped: RequestParams {
    public var jsonValue: Any {
        switch self {
        case .none:
            return self as Any
        case .some(let wraped):
            return wraped.jsonValue
        }
    }
}
extension Array: RequestParams where Element: RequestParams {
    public var jsonValue: Any { return map { $0.jsonValue } }
}
extension Dictionary: RequestParams where Value: RequestParams {
    public var jsonValue: Any { return mapValues { $0.jsonValue } }
}

extension RequestParams {
    var jsonValue: Any {
        let mirror = Mirror(reflecting: self)
        var result = [String: Any]()
        for child in mirror.children {
            guard let key = child.label else {
                fatalError("Invalid key in child: \(child)")
            }
            if let value = child.value as? RequestParams {
                result[key] = value.jsonValue
            } else {
                result[key] = nil
            }
        }
        return result
    }
    
    var stringJsonValue: [String: String] {
        var dict = [String: String]()
        if let json = jsonValue as? [String: Any] {
            for item in json {
                if let v = item.value as? String {
                    dict[item.key] = v
                } else {
                    dict[item.key] = "\(item.value)"
                }
            }
        }
        return dict
    }
}
