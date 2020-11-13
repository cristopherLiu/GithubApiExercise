//
//  LocationViewModel.swift
//  GithubApiExercise
//
//  Created by hjliu on 2020/11/13.
//

import UIKit

class LocationViewModel: DetailTextViewModel {
  
  let iconImag: UIImage?
  let location: String?
  
  init(location: String? = nil) {
    self.iconImag = UIImage(named: "pin")
    self.location = location
  }
}
