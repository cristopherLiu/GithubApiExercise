//
//  DateFormatter+Extension.swift
//  GithubApiExercise
//
//  Created by hjliu on 2020/11/13.
//

import Foundation

extension DateFormatter {
  
  static let dateFormatterWithTimeZone: DateFormatter = {
    var dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return dateFormatter
  }()
  
  static let dateFormatterWithTime: DateFormatter = {
    var dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return dateFormatter
  }()
  
  static let dateFormatterWithoutTime: DateFormatter = {
    var dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter
  }()
}
