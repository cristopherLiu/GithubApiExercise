//
//  User.swift
//  GithubApiExercise
//
//  Created by hjliu on 2020/11/13.
//

import Foundation

class UsersReqData: Encodable, CustomStringConvertible {
  
  let sinceId: Int // start id
  let per_page: Int // per_page
  
  init(sinceId: Int, per_page: Int) {
    self.sinceId = sinceId
    self.per_page = per_page
  }
  
  required init(from decoder: Decoder) throws {
    fatalError("init(from:) has not been implemented")
  }
  
  private enum CodingKeys : String, CodingKey {
    case since = "since"
    case per_page = "per_page"
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(sinceId, forKey: .since)
    try container.encode(per_page, forKey: .per_page)
  }
  
  var description: String {
    return "sinceId:\(sinceId), per_page:\(per_page)"
  }
}

struct User: Decodable {
  let login: String
  let id: Int
  let avatarUrl: String
  let siteAdmin: Bool
}


class UserDetailReqData: Encodable {
}

struct UserDetail: Decodable {
  
  let avatarUrl: String
  let name: String
  let bio: String?
  let login: String
  let siteAdmin: Bool
  
  let location: String?
  let blog: String
}
