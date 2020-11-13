//
//  NetworkInterceptor.swift
//  GithubApiExercise
//
//  Created by hjliu on 2020/11/13.
//

import Foundation
import Alamofire

// RequestInterceptor
class BaseInterceptor: RequestInterceptor{
  
  private var isReachableToInternet:Bool {
    return NetworkReachabilityManager()?.isReachable ?? false
  }
  
  func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
    
    // check internet status
    if self.isReachableToInternet == false {
      DispatchQueue.main.async {
        NotificationCenter.default.post(name: Configuration.NotificationName.networkStatusChange, object: NetworkStatus.notConnectedToInternet)
      }
    }
    
    var request = urlRequest
    // add data to headers
    
    request.cachePolicy = .reloadIgnoringCacheData
    completion(.success(request))
  }
  
  func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
    completion(.doNotRetry)
  }
}
