//
//  UserListController.swift
//  GithubApiExercise
//
//  Created by hjliu on 2020/11/13.
//

import UIKit

class AllUsersController {
  
  let viewModel: AllUsersViewModel
  private let dataService: DataService
  
  private var sourceData = [RowViewModel]()
  private var sinceId = 0
  
  init(
    viewModel: AllUsersViewModel = AllUsersViewModel(),
    dataService: DataService = DataService()
  ) {
    self.viewModel = viewModel
    self.dataService = dataService
  }
  
  // Start
  func start() {
    loadDefaultDatas()
  }
  
  func loadDefaultDatas() {
    self.sourceData = [] // clear
    self.sinceId = 0
    
    self.viewModel.isLoading.value = true
    self.getAllUsers(sinceId: self.sinceId)
  }
  
  func loadMoreDatas() {
    self.getAllUsers(sinceId: self.sinceId)
  }
  
  func getAllUsers(sinceId: Int) {
    
    if sourceData.count >= 100 {
      self.viewModel.isLoading.value = false
      return
    }
    
    self.dataService.getAllUsers(sinceId: sinceId) { users in
      
      self.viewModel.isLoading.value = false
      self.buildViewModels(users: users)
    }
  }
  
  // MARK: - Data source
  private func buildViewModels(users: [User]) {
    
    for user in users {
      
      let avatarImage = AsyncImage(
        url: user.avatarUrl,
        placeholderImage: UIImage(named: "avatar")!,
        imageDownloadHelper: ImageDownloadHelper())

      let rowViewModel = UserCellViewModel(
        avatar: avatarImage,
        login: user.login,
        isSiteAdmin: user.siteAdmin,
        cellPressed: {
        self.viewModel.showUserDetail.value = user.login
      })
      sourceData.append(rowViewModel)
      
      self.sinceId = max(self.sinceId, user.id)
    }
    
    self.viewModel.rowViewModels.value = self.sourceData
  }
  
  func cellIdentifier(for viewModel: RowViewModel) -> String {
    return UserCell.cellIdentifier()
  }
}


