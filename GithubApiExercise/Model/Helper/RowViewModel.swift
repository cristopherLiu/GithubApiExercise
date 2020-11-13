//
//  RowViewModel.swift
//  GithubApiExercise
//
//  Created by hjliu on 2020/11/13.
//

import Foundation

protocol RowViewModel {
}

/// Conform this protocol to handles user press action
protocol ViewModelPressible {
  var cellPressed: (()->Void)? { get set }
}

protocol CellConfiguraable {
  func setup(viewModel: RowViewModel)
}

