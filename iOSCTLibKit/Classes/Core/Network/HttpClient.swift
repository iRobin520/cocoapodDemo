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
    
    //发起Get方法网络请求
    func get<T: Codable>(_ resModel: T.Type, requestUrl: String, parameters: RequestParams?  = nil) -> Observable<T> {
        return request(T.self, requestUrl: requestUrl, httpMethod: .get, parameters: parameters)
    }
    
    //发起Post方法网络请求
    func post<T: Codable>(_ resModel: T.Type, requestUrl: String, parameters: RequestParams?  = nil) -> Observable<T> {
        return request(T.self, requestUrl: requestUrl, httpMethod: .post, parameters: parameters)
    }
    
    //发起Put方法网络请求
    func put<T: Codable>(_ resModel: T.Type, requestUrl: String, parameters: RequestParams?  = nil) -> Observable<T> {
        return request(T.self, requestUrl: requestUrl, httpMethod: .put, parameters: parameters)
    }
    
    //发起Delete方法网络请求
    func delete<T: Codable>(_ resModel: T.Type, requestUrl: String, parameters: RequestParams?  = nil) -> Observable<T> {
        return request(T.self, requestUrl: requestUrl, httpMethod: .delete, parameters: parameters)
    }
    
    //发起网络请求
    func request<T: Codable>(_ resModel: T.Type, requestUrl: String, httpMethod: HTTPMethod, parameters: RequestParams?  = nil) -> Observable<T> {
        return Observable.create { [weak self](observable) -> Disposable in
            var url: String = requestUrl
            if !url.hasPrefix("http") {
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
            if parameters != nil {
                allParameters.encodableMerge(dict: parameters!.stringJsonValue);
            }
            self?.session.request(url, method: httpMethod, parameters: allParameters, encoder: encoding, headers: headers) { urlRequest in
                /// 请求超时时间
                urlRequest.timeoutInterval = self!.timeoutInterval
            }.responseDecodable(of: T.self) { response in
                if self?.env.buildMode == BuildMode.DEBUG {
                    print("==========请求地址========")
                    print(url)
                    print("==========请求头========")
                    print(headers)
                    print("==========请求参数========")
                    print(allParameters.toJSONString() ?? "")
                    print("==========请求结果========")
                    print(response.value!)
                }
                switch response.result {
                case .success(let value):
                    observable.onNext(value)
                    observable.onCompleted()
                case .failure(let error):
                    if self?.env.buildMode == BuildMode.DEBUG {
                        print(error)
                    }
                    observable.onError(error)
                    observable.onCompleted()
                }
            }
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

