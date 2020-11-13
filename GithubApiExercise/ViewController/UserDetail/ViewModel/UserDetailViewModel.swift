//
//  UserDetailViewModel.swift
//  GithubApiExercise
//
//  Created by hjliu on 2020/11/13.
//

import Foundation

class UserDetailViewModel {
  let setHeaderView = Observable<HeaderViewModel>(value: HeaderViewModel(avatar: AsyncImage(url: "")))
  let setStatusView = Observable<StatusViewModel>(value: StatusViewModel())
  let setLocationView = Observable<LocationViewModel>(value: LocationViewModel())
  let setBlogView = Observable<BlogViewModel>(value: BlogViewModel())
}
