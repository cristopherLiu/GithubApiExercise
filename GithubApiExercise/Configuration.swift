//
//  Configuration.swift
//  GithubApiExercise
//
//  Created by hjliu on 2020/11/13.
//

import Foundation

struct Configuration {
  
  struct NotificationName {
    static let networkStatusChange = NSNotification.Name("networkStatusChange")
  }
  
  static var APIHost: String {
    return infoForKey("APIHostUrl") ?? ""
  }
  
  struct Url{
    static let users = "\(APIHost)users" // get users
    static let userDetail = "\(APIHost)users" // get users
  }
  
  enum Router {
    case Users
    case UserDetail(String)
    
    var path: String {
      switch self {
      case .Users:
        return "\(APIHost)users"
      case .UserDetail(let username):
        return "\(APIHost)users/\(username)"
      }
    }
  }
}

fileprivate func infoForKey(_ key: String) -> String? {
  return (Bundle.main.infoDictionary?[key] as? String)?
    .replacingOccurrences(of: "\\", with: "")
}
