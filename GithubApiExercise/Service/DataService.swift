//
//  DataService.swift
//  GithubApiExercise
//
//  Created by hjliu on 2020/11/13.
//

import Foundation


class DataService {
  
  func getAllUsers(sinceId: Int = 0, onCompletion:@escaping ([User])->()) {
    
    let data = UsersReqData(sinceId: sinceId, per_page: 20)
    let request = UsersRequest(data: data)
    
    // call api
    NetworkService.sharedInstance.request(request, onCompletion: { (response) in
      if let response = response {
        onCompletion(response)
      }
    }) { error in
      print("getAllUsers Error -->\(error)")
    }
  }
  
  func getUserDetail(username: String, onCompletion:@escaping (UserDetail)->()) {
    
    let request = UserDetailRequest(userName: username)
    
    // call api
    NetworkService.sharedInstance.request(request, onCompletion: { (response) in
      print("getUserDetail -->\(response)")
      if let response = response {
        onCompletion(response)
      }
    }) { error in
      print("getUserDetail Error -->\(error)")
    }
  }
}
