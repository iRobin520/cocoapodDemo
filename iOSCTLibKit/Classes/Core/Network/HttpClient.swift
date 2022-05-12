//
//  HttpClient.swift
//  Pods
//
//  Created by Robin Shen on 2022/5/11.
//

import Foundation
import Alamofire
import RxSwift

struct ServiceError: Error {
    let errorMsg: String
}

class HttpClient : NSObject {
    
    //超时设置
    let timeoutInterval = 30.0
    let session: Session
    let env: EnvConfig = EnvConfig()
    
    //单例对象
    static let sharedInstance = HttpClient()
    
    override init() {
        session = Session()
        super.init()
    }
    
    func request<T: Codable>(_ resModel: T.Type, requestUrl: String, httpMethod: HTTPMethod, parameters: [String: String]) -> Observable<T> {
        return Observable.create { [weak self](observable) -> Disposable in
            var url: String = requestUrl
            if url.hasPrefix("http") {
                url = self!.env.currentBaseUrl + url
            }
            let encoding: ParameterEncoder
            if httpMethod == .get {
                encoding = URLEncodedFormParameterEncoder.default
            } else {
                encoding = JSONParameterEncoder.default
            }
            let headers = HttpClient.requestHeaders
            
            var allParameters = HttpClient.commomParams
            allParameters.merge(dict: parameters);
           

//            let login = Login(email: "test@test.test", password: "testPassword")
//
//            AF.request("https://httpbin.org/post",
//                       method: .post,
//                       parameters: login,
//                       encoder: JSONParameterEncoder.default).response { response in
//                debugPrint(response)
//            }
//
            
//            AF.request(url,
//                       method: httpMethod,
//                       parameters: allParameters,
//                       encoder: encoding).response { response in
//                debugPrint(response)
//            }
            
            self?.session.request(url, method: httpMethod, parameters: allParameters, encoder: encoding, headers: headers) { urlRequest in
                /// 请求超时时间
                urlRequest.timeoutInterval = self!.timeoutInterval
            }.responseData(completionHandler: { (response) in
                if self?.env.buildMode == BuildMode.DEBUG {
                    print("==========请求地址========")
                    print(url )
                    print("==========请求头========")
                    print(headers)
                    print("==========请求参数========")
                    print(allParameters.toJSONString() ?? "")
                    print("==========请求结果========")
                    print(response)
                }
                switch response.result {
                case .success(let value):
                    if let jsonData = value as? Dictionary<String,Any> {
                        //debugPrint(jsonData.toJSONString() ?? "")
                        let status = jsonData["status"] as! Int
                        let msg = jsonData["msg"] as! String
                        if (status == 0) {
                            let resDic = jsonData
                            let decoder = JSONDecoder()
                            if let data = resDic.toJSONData() {
                                do {
                                    let item = try decoder.decode(BaseModel<T>.self, from: data)
                                    if let model = item.data {
                                        observable.onNext(model)
                                        observable.onCompleted()
                                    }
                                } catch let err {
                                    observable.onError(err)
                                    observable.onCompleted()
                                }
                            }
                        } else {
                            observable.onError(ServiceError(errorMsg: msg))
                            observable.onCompleted()
                        }
                    } else {
                        observable.onError(ServiceError(errorMsg: "服务器出错㕸！"))
                        observable.onCompleted()
                    }
                case .failure(let error):
                    debugPrint(error)
                    observable.onError(error)
                    observable.onCompleted()
                }
            })
            return Disposables.create()
        }
    }
    
    //取消所有网络请求
    func cancelRequests() {
        session.cancelAllRequests()
    }
    
}

extension HttpClient {
    //通用参数
    static var commomParams: [String: String] {
        return [
            "deviceId": "dsafdsafdsa",
            "channel": "App",
        ]
    }
    
    //请求头
    static var requestHeaders: HTTPHeaders {
        var headerParams = [String: String]()
        headerParams.updateValue("application/json;charset=UTF-8", forKey:"Content-Type")
        return HTTPHeaders.init(headerParams)
    }
}
