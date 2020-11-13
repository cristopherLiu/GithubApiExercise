//
//  BlogViewModel.swift
//  GithubApiExercise
//
//  Created by hjliu on 2020/11/13.
//

import UIKit

class BlogViewModel: DetailTextViewModel {
  
  let iconImag: UIImage?
  let blog: String
  
  init(blog: String = "") {
    self.iconImag = UIImage(named: "link")
    self.blog = blog
  }
}
