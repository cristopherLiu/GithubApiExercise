//
//  UITableViewCell+Extension.swift
//  GithubApiExercise
//
//  Created by hjliu on 2020/11/13.
//

import Foundation
import UIKit

public extension UITableViewCell {
  /// Generated cell identifier derived from class name
  static func cellIdentifier() -> String {
    return String(describing: self)
  }
}

public extension UICollectionViewCell{
  /// Generated cell identifier derived from class name
  static func cellIdentifier() -> String {
    return String(describing: self)
  }
}

public extension UITableViewHeaderFooterView{
  static func cellIdentifier() -> String {
    return String(describing: self)
  }
}
