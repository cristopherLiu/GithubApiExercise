//
//  NetworkService.swift
//  GithubApiExercise
//
//  Created by hjliu on 2020/11/13.
//

import Foundation
import Alamofire

class NetworkService {
  
  static let sharedInstance = NetworkService()
  
  private var defaultSession: Session = {
    let configuration = URLSessionConfiguration.default
    configuration.isDiscretionary = true
    configuration.sessionSendsLaunchEvents = true
    configuration.timeoutIntervalForRequest = 15
    configuration.timeoutIntervalForResource = 40
    let session = Session(configuration: configuration)
    return session
  }()
  
  func request<T: EncodableRequest>(_ request: T, onCompletion:@escaping (T.Response?)->(), onError:@escaping (ErrorResponse)->()) {
    
    defaultSession.request(
      request.url, method: request.method, parameters: request.parameter, encoder: request.encoder, headers: request.headers, interceptor: request.interceptor, requestModifier: nil)
      .validate()
      .response(completionHandler: { self.parse(res: $0, onCompletion: onCompletion, onError: onError) })
//      .responseJSON { (res) in
//        guard let url = res.request?.url?.absoluteString, let statusCode = res.response?.statusCode else {return}
//        switch res.result {
//        case .success(let value):
//          print("成功\(url) (\(statusCode)) --> \(value)")
//        case .failure(let error):
//          print("失敗\(url) (\(statusCode)) --> \(error)")
//        }
//      }
  }
  
  // download Image
  func downloadImage(url: URLConvertible, onCompletion:@escaping (UIImage?)->()) {
    
    defaultSession.download(url)
      .validate()
      .responseData { (response) in
        switch response.result {
        case .success(let value):
          onCompletion(UIImage(data: value))
        case .failure(let error):
          print(error)
          onCompletion(nil)
        }
      }
  }
}

extension NetworkService {
  
  // response handler
  private func parse<T:Decodable>(res: (AFDataResponse<Data?>), onCompletion:@escaping (T?)->(), onError:@escaping (ErrorResponse)->()) {
    
    guard let statusCode = res.response?.statusCode else {
      return
    }
    
    switch res.result {
    case .success(_):
      
      guard let responseData = res.data else {
        onCompletion(nil)
        return
      }
      
      do{
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategyFormatters = [
          DateFormatter.dateFormatterWithTimeZone,
          DateFormatter.dateFormatterWithTime,
          DateFormatter.dateFormatterWithoutTime
        ]
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let object = try decoder.decode(T.self, from: responseData)
        onCompletion(object)
        
      } catch let DecodingError.dataCorrupted(context) {
        print(context)
        onError(ErrorResponse(statusCode: statusCode, message: "Json dataCorrupted: \(context.debugDescription)"))
        
      } catch let DecodingError.keyNotFound(key, context) {
        print("Key '\(key)' not found:", context.debugDescription)
        print("codingPath:", context.codingPath)
        onError(ErrorResponse(statusCode: statusCode, message: "Json Key'\(key)' not found: \(context.debugDescription)"))
        
      } catch let DecodingError.valueNotFound(value, context) {
        print("Value '\(value)' not found:", context.debugDescription)
        print("codingPath:", context.codingPath)
        onError(ErrorResponse(statusCode: statusCode, message: "Json Value'\(value)' not found: \(context.debugDescription)"))
        
      } catch let DecodingError.typeMismatch(type, context)  {
        print("Type '\(type)' mismatch:", context.debugDescription)
        print("codingPath:", context.codingPath)
        onError(ErrorResponse(statusCode: statusCode, message: "Json Type'\(type)' mismatch: \(context.debugDescription)"))
        
      } catch {
        print("error: ", error)
        onError(ErrorResponse(statusCode: statusCode, message: "Error: \(error)"))
      }
    case .failure(let error):
      
      print("\n\n===========Error===========")
      print("Url: \(res.request?.url?.absoluteString ?? "")")
      print("Error Code: \(error._code)")
      print("Error Messsage: \(error.localizedDescription)")
      if let data = res.data, let str = String(data: data, encoding: String.Encoding.utf8){
        print("Server Error: " + str)
      }
      debugPrint(error as Any)
      print("===========================\n\n")
      
      onError(ErrorResponse(statusCode: statusCode, message: error.localizedDescription))
    }
  }
}

struct ErrorResponse: CustomStringConvertible {
  var statusCode: Int
  var message: String
  var description: String {
    return "(\(statusCode))\(message)"
  }
}
