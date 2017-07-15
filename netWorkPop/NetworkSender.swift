//
//  NetworkSender.swift
//  netWorkPop
//
//  Created by karl on 2017/07/15.
//  Copyright © 2017年 Karl. All rights reserved.
//

import Foundation

enum Result {
  case success(CustomDecodable, URLResponse)
  case error(Error)
}

enum HTTPMethed: String {
  case Post
  case Get
}

protocol Requestable {
  var host: String { get }
  var path: String { get }
  var methed: HTTPMethed { get }
  var param: [String: Any]? { get }
  
  associatedtype Response: CustomDecodable
}

extension Requestable {
  var host: String {
    return "http://api.fir.im/"
  }
  
  var param: [String: Any]? {
    return nil
  }
  
  var methed: HTTPMethed {
    return .Get
  }
}

struct Request: Requestable {
  typealias Response = Model
  var path: String {
    return "apps/latest/593a54a4ca87a82d8c000514?api_token=4fa30877b9aaf685bec57f452e438d73"
  }
}


struct NetworkSender {
  func send<R: Requestable>(_ r: R, handle: @escaping (Result) -> ()) {
    guard let url = URL(string:r.host + r.path) else {
      fatalError("URL error")
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = r.methed.rawValue
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      var result: Result!
      if let data = data, let response = response {
        guard let res = R.Response.parse(data) else {
          fatalError("data parse error")
        }
        result = Result.success(res, response)
        handle(result)
      }
      
      if let error = error {
        result = Result.error(error)
        handle(result)
      }
    }
    
    task.resume()
  }
}
