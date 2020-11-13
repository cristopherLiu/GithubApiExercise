//
//  UserCellViewModel.swift
//  GithubApiExercise
//
//  Created by hjliu on 2020/11/13.
//

import Foundation
import UIKit

class UserCellViewModel: RowViewModel, ViewModelPressible {
  
  let avatar: AsyncImage
  let login: String
  let isSiteAdmin: Bool
  var cellPressed: (() -> Void)?
  
  init(avatar: AsyncImage, login: String, isSiteAdmin: Bool, cellPressed: (() -> Void)? = nil) {
    self.avatar = avatar
    self.login = login
    self.isSiteAdmin = isSiteAdmin
    self.cellPressed = cellPressed
  }
}
