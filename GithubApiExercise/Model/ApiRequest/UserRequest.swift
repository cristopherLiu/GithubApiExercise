//
//  UserRequest.swift
//  GithubApiExercise
//
//  Created by hjliu on 2020/11/13.
//

import Foundation
import Alamofire

struct UsersRequest: EncodableRequest {
  
  let url: URLConvertible = Configuration.Router.Users.path
  let method = HTTPMethod.get
  let encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default
  var parameter: Parameter
  var headers: HTTPHeaders? = nil
  var interceptor: RequestInterceptor?
  
  typealias Parameter = UsersReqData
  typealias Response = [User]
  
  init(data: UsersReqData){
    self.parameter = data
    self.interceptor = BaseInterceptor()
  }
}

struct UserDetailRequest: EncodableRequest {
  
  var url: URLConvertible
  let method = HTTPMethod.get
  let encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default
  var parameter: Parameter
  var headers: HTTPHeaders? = nil
  var interceptor: RequestInterceptor?
  
  typealias Parameter = UserDetailReqData
  typealias Response = UserDetail
  
  init(userName: String){
    self.url = Configuration.Router.UserDetail(userName).path
    self.parameter = UserDetailReqData()
    self.interceptor = BaseInterceptor()
  }
}
