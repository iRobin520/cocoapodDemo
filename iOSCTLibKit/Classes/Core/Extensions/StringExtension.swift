//
//  StringExtension.swift
//  iOSCTLibKit
//
//  Created by Robin Shen on 2022/5/11.
//

import Foundation

extension String {
    // 16进制字符串转十进制字符串
    func hexToDecimal() -> String {
        if self.hasPrefix("0x") {
            let start = self.index(self.startIndex, offsetBy: 2);
            let str1 = String(self[start...])
            let fStr = str1.uppercased()
            var sum = 0
            for i in fStr.utf8 {
                sum = sum * 16 + Int(i) - 48
                if i >= 65 {
                    sum -= 7
                }
            }
            return String(sum)
        } else {
            return self
        }
    }
    
    func isValid() -> Bool {
        return !self.isEmpty && self.count>0
    }
    
    static func dictionaryFromJSONString(jsonString:String) -> NSDictionary {
        let jsonData:Data = jsonString.data(using: .utf8)!
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
    
    static func arrayFromJSONString(jsonString:String) -> NSArray {
        let jsonData:Data = jsonString.data(using: .utf8)!
        let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if array != nil {
            return array as! NSArray
        }
        return array as! NSArray
    }
    
    static func JSONStringFromDictionary(dictionary: Any) -> String {
           if (!JSONSerialization.isValidJSONObject(dictionary)) {
               print("无法解析出JSONString")
               return ""
           }
        let data : NSData! = try! JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData?
           let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
           return JSONString! as String
       }
    
    static func JSONStringFromArray(array: Any) -> String {
        if (!JSONSerialization.isValidJSONObject(array)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try! JSONSerialization.data(withJSONObject: array, options: []) as NSData?
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }
}
