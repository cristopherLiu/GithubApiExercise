//
//  HeaderView.swift
//  GithubApiExercise
//
//  Created by hjliu on 2020/11/13.
//

import UIKit

class HeaderView: UIView {
  
  private lazy var avatarView: UIImageView = {
    let view = UIImageView()
    view.layer.cornerRadius = 110
    view.clipsToBounds = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 24.0)
    label.textColor = UIColor.bk
    label.textAlignment = NSTextAlignment.center
    label.numberOfLines = 1
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var bioLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 20.0)
    label.textColor = UIColor.bk
    label.textAlignment = NSTextAlignment.center
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var loadingIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .medium)
    indicator.translatesAutoresizingMaskIntoConstraints = false
    return indicator
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func initView() {
    
    addSubview(avatarView)
    avatarView.addSubview(loadingIndicator)
    addSubview(nameLabel)
    addSubview(bioLabel)
    
    NSLayoutConstraint.activate([
      
      avatarView.widthAnchor.constraint(equalToConstant: 220),
      avatarView.heightAnchor.constraint(equalToConstant: 220),
      avatarView.leftAnchor.constraint(equalTo: self.leftAnchor),
      avatarView.rightAnchor.constraint(equalTo: self.rightAnchor),
      avatarView.topAnchor.constraint(equalTo: self.topAnchor),
      
      loadingIndicator.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
      loadingIndicator.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
      
      nameLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 24),
      nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
      nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
      
      bioLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 24),
      bioLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
      bioLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
      bioLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
    ])
  }
  
  func setup(viewModel: HeaderViewModel) {
    
    self.avatarView.image = viewModel.avatar.image
    
    self.loadingIndicator.startAnimating() // show Indicator
    viewModel.avatar.completeDownload = { [weak self] image in
      self?.loadingIndicator.stopAnimating() // hide Indicator
      self?.avatarView.image = image
    }
    viewModel.avatar.startDownload()
    
    // user name
    nameLabel.text = viewModel.name
    
    // user bio
    bioLabel.text = viewModel.bio
  }
}
