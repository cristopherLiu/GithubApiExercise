//
//  StatusViewModel.swift
//  GithubApiExercise
//
//  Created by hjliu on 2020/11/13.
//

import UIKit

class StatusViewModel: DetailTextViewModel {
  
  let iconImag: UIImage?
  let login: String
  let isSiteAdmin: Bool
  
  init(login: String = "", isSiteAdmin: Bool = false) {
    self.iconImag = UIImage(named: "user")
    self.login = login
    self.isSiteAdmin = isSiteAdmin
  }
}
