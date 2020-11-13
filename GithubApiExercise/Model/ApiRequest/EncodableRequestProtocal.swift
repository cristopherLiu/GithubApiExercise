//
//  EncodableRequestProtocal.swift
//  GithubApiExercise
//
//  Created by hjliu on 2020/11/13.
//

import Alamofire

protocol EncodableRequest {
  
  var url: URLConvertible {get}
  var method: HTTPMethod {get}
  var encoder: ParameterEncoder {get}
  var parameter: Parameter {get}
  var headers: HTTPHeaders? {get}
  var interceptor: RequestInterceptor? {get}
  
  associatedtype Parameter: Encodable
  associatedtype Response: Decodable
}
