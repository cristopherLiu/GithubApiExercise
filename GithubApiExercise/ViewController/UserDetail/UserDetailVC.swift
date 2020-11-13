//
//  UserDetailVC.swift
//  GithubApiExercise
//
//  Created by hjliu on 2020/11/13.
//

import Foundation
import UIKit

class UserDetailVC: DialogVC {
  
  private lazy var cancelButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "cancel_w"), for: .normal)
    button.addTarget(self, action: #selector(tapCancel), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private lazy var topView1: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.gy
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var topView2: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.pri
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var headerView: HeaderView = {
    let view = HeaderView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var statusView: DetailTextView = {
    let view = DetailTextView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var locationView: DetailTextView = {
    let view = DetailTextView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var blogView: DetailTextView = {
    let view = DetailTextView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  
  // Model
  var viewModel: UserDetailViewModel {
    return controller.viewModel
  }
  
  lazy var controller: UserDetailController = {
    return UserDetailController()
  }()
  
  init(userName: String) {
    super.init()
    self.controller.userName = userName
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.initializer()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initView()
    initBinding()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    controller.start()
  }
  
  func initView() {
    
    contentView.addSubview(topView1)
    contentView.addSubview(topView2)
    contentView.addSubview(cancelButton)
    contentView.addSubview(headerView)
    contentView.addSubview(statusView)
    contentView.addSubview(locationView)
    contentView.addSubview(blogView)
    
    NSLayoutConstraint.activate([
      
      topView1.topAnchor.constraint(equalTo: contentView.topAnchor),
      topView1.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      topView1.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      topView1.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
      
      topView2.topAnchor.constraint(equalTo: contentView.topAnchor),
      topView2.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      topView2.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      topView2.heightAnchor.constraint(equalToConstant: 192),
      
      cancelButton.widthAnchor.constraint(equalToConstant: 40),
      cancelButton.heightAnchor.constraint(equalToConstant: 40),
      cancelButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      cancelButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
      
      headerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 60),
      headerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -60),
      headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
      
      statusView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 24),
      statusView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      statusView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      
      locationView.topAnchor.constraint(equalTo: statusView.bottomAnchor, constant: 24),
      locationView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      locationView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      
      blogView.topAnchor.constraint(equalTo: locationView.bottomAnchor, constant: 24),
      blogView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      blogView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      blogView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
    ])
  }
  
  func initBinding() {
    
    viewModel.setHeaderView.addObserver(fireNow: false) { [weak self] (model) in
      guard let self = self else {return}
      self.headerView.setup(viewModel: model)
    }
    
    viewModel.setStatusView.addObserver(fireNow: false) { [weak self] (model) in
      guard let self = self else {return}
      self.statusView.setup(viewModel: model)
    }
    
    viewModel.setLocationView.addObserver(fireNow: false) { [weak self] (model) in
      guard let self = self else {return}
      self.locationView.setup(viewModel: model)
    }
    
    viewModel.setBlogView.addObserver(fireNow: false) { [weak self] (model) in
      guard let self = self else {return}
      self.blogView.setup(viewModel: model)
    }
  }
  
  @objc func tapCancel() {
    self.hideWithAnimate()
  }
}
