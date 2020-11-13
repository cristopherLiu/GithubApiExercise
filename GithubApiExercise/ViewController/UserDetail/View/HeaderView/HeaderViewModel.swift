//
//  UserDetailModel.swift
//  GithubApiExercise
//
//  Created by hjliu on 2020/11/13.
//

import Foundation

class HeaderViewModel {
  
  let avatar: AsyncImage
  let name: String
  let bio: String?
  
  init(avatar: AsyncImage, name: String = "", bio: String? = nil) {
    self.avatar = avatar
    self.name = name
    self.bio = bio
  }
}
