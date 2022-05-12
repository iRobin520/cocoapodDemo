//
//  DictionaryValue.swift
//  iOSCTLibKit
//
//  Created by Robin Shen on 2022/5/11.
//

import Foundation

public protocol DictionaryValue {
    var jsonValue: Any { get }
}

extension Int: DictionaryValue { public var jsonValue: Any { return self } }
extension Int32: DictionaryValue { public var jsonValue: Any { return self } }
extension Int64: DictionaryValue { public var jsonValue: Any { return self } }
extension Float: DictionaryValue { public var jsonValue: Any { return self } }
extension Double: DictionaryValue { public var jsonValue: Any { return self } }
extension String: DictionaryValue { public var jsonValue: Any { return self } }
extension Bool: DictionaryValue { public var jsonValue: Any { return self } }
extension Decimal: DictionaryValue { public var jsonValue: Any { return self.description } }
extension Optional: DictionaryValue where Wrapped: DictionaryValue {
    public var jsonValue: Any {
        switch self {
        case .none:
            return self as Any
        case .some(let wraped):
            return wraped.jsonValue
        }
    }
}
extension Array: DictionaryValue where Element: DictionaryValue {
    public var jsonValue: Any { return map { $0.jsonValue } }
}
extension Dictionary: DictionaryValue where Value: DictionaryValue {
    public var jsonValue: Any { return mapValues { $0.jsonValue } }
}

extension DictionaryValue {
    var jsonValue: Any {
        let mirror = Mirror(reflecting: self)
        var result = [String: Any]()
        for child in mirror.children {
            guard let key = child.label else {
                fatalError("Invalid key in child: \(child)")
            }
            if let value = child.value as? DictionaryValue {
                result[key] = value.jsonValue
            } else {
                result[key] = nil
            }
        }
        return result
    }
    
    var sigleDicValue: [String: String] {
        var dic = [String: String]()
        if let json = jsonValue as? [String: Any] {
            for item in json {
                if let v = item.value as? String {
                    dic[item.key] = v
                } else {
                    dic[item.key] = "\(item.value)"
                }
            }
        }
        return [String: String]()
    }
}

