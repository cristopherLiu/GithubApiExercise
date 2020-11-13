//
//  UserDetailController.swift
//  GithubApiExercise
//
//  Created by hjliu on 2020/11/13.
//

import UIKit

class UserDetailController {
  
  let viewModel: UserDetailViewModel
  private let dataService: DataService
  
  var userName: String? // user name
  private var userDetail: UserDetail? // userDetail data
  
  init(
    viewModel: UserDetailViewModel = UserDetailViewModel(),
    dataService: DataService = DataService()
  ) {
    self.viewModel = viewModel
    self.dataService = dataService
  }
  
  func start() {
    
    guard let userName = userName else { return }
    self.getUserDetail(name: userName)
  }
  
  private func getUserDetail(name: String) {
    
    dataService.getUserDetail(username: name) { detail in
      self.userDetail = detail // save detail
      self.buildViewModel(detail: detail)
    }
  }
  
  private func buildViewModel(detail: UserDetail) {
    
    let avatarImage = AsyncImage(url: detail.avatarUrl, placeholderImage: UIImage(named: "avatar")!, imageDownloadHelper: ImageDownloadHelper())
    let headerViewModel = HeaderViewModel(avatar: avatarImage, name: detail.name, bio: detail.bio)
    self.viewModel.setHeaderView.value = headerViewModel
    
    let statusViewModel = StatusViewModel(login: detail.login, isSiteAdmin: detail.siteAdmin)
    self.viewModel.setStatusView.value = statusViewModel
    
    let locationViewModel = LocationViewModel(location: detail.location)
    self.viewModel.setLocationView.value = locationViewModel
    
    let blogViewModel = BlogViewModel(blog: detail.blog)
    self.viewModel.setBlogView.value = blogViewModel
  }
}
