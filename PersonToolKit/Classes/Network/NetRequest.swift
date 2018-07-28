//
//  NetRequest.swift
//  HandScan
//
//  Created by ay on 2018/6/28.
//  Copyright © 2018年 aypc. All rights reserved.
//

import UIKit
import Alamofire

public class NetResult: NSObject {
    public var success = false
    public var error:Error? = nil
    public var content = [String:Any]()
}

public typealias FinishedClosures = (NetResult) -> Void

open class NetRequest: NSObject {
    public static let shared = NetRequest()

    func analysisResult(result:Result<Any>) -> NetResult {
        let res = NetResult()
        if (result.isSuccess && result.error == nil)
        {
            print(result.value as Any)
            res.success = true
            res.content = result.value as! [String:Any]
            if(res.content.keys.contains("Error_Message"))
            {
                res.success = false
            }else
            {
                res.success = true
            }
        }else
        {
            res.success = false
            res.error = result.error
            print(result.error as Any)
        }
        return res
    }
    public func commonRequest(url:String,method: HTTPMethod = .get,params: Parameters? = nil,header: HTTPHeaders? = nil,construct:((URLRequest)->URLRequest)? = nil,finished:@escaping FinishedClosures) {
        let requestString: String = url;
        let url: NSURL = NSURL(string: requestString)!;
        var originalRequest = URLRequest(url: url as URL)
        originalRequest.httpMethod = method.rawValue
        originalRequest.timeoutInterval = 10
        originalRequest.allHTTPHeaderFields = header
        if(construct != nil)
        {
            originalRequest = construct!(originalRequest)
        }
        do {
            let encodedURLRequest = try URLEncoding.default.encode(originalRequest, with: params)
            Alamofire.request(encodedURLRequest as URLRequestConvertible).responseJSON { (response) in
                finished(self.analysisResult(result: response.result))
            }
        } catch {
            print("error ")
        }
    }
}
