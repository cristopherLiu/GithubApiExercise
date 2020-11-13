//
//  UserListViewModel.swift
//  GithubApiExercise
//
//  Created by hjliu on 2020/11/13.
//

import Foundation

class AllUsersViewModel {
  let isLoading = Observable<Bool>(value: false)
  let rowViewModels = Observable<[RowViewModel]>(value: [])
  let showUserDetail = Observable<String>(value: "")
}
