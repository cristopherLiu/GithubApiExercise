//
//  NetworkStatus.swift
//  GithubApiExercise
//
//  Created by hjliu on 2020/11/13.
//

import Foundation

enum NetworkStatus: Error, CustomStringConvertible {
  
  case none
  case success
  case error
  case notConnectedToInternet
  
  var description: String {
    
    switch self {
    case .none:
      return "None"
    case .success:
      return "Success"
    case .error:
      return "Error"
    case .notConnectedToInternet:
      return "No Connected To Internet"
    }
  }
}
