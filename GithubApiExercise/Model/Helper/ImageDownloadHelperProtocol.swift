//
//  ImageDownloadHelperProtocol.swift
//  GithubApiExercise
//
//  Created by hjliu on 2020/11/13.
//

import UIKit

protocol ImageDownloadHelperProtocol {
  func download(url: URL, completion: @escaping (UIImage?, URLResponse?, Error?) -> ())
}

class ImageDownloadHelper: ImageDownloadHelperProtocol {
  
  let urlSession: URLSession = URLSession.shared
  
  static var shared: ImageDownloadHelper = {
    return ImageDownloadHelper()
  }()
  
  func download(url: URL, completion: @escaping (UIImage?, URLResponse?, Error?) -> ()) {
    urlSession.dataTask(with: url) { data, response, error in
      if let data = data {
        completion(UIImage(data: data), response, error)
      } else {
        completion(nil, response, error)
      }
    }.resume()
  }
}

class MockImageDownloadHelper: ImageDownloadHelperProtocol {
  func download(url: URL, completion: @escaping (UIImage?, URLResponse?, Error?) -> ()) {
    DispatchQueue.global().async {
      let image = UIImage(systemName: "eye.slash")
      completion(image, nil, nil)
    }
  }
}
