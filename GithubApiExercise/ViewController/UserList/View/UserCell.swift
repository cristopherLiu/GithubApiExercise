//
//  UserCell.swift
//  GithubApiExercise
//
//  Created by hjliu on 2020/11/13.
//

import UIKit

class UserCell: UITableViewCell, CellConfiguraable {
  
  /// UI
  private lazy var bgView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.w
    view.layer.cornerRadius = 16
    view.clipsToBounds = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var avatarImageView: UIImageView = {
    let view = UIImageView()
    view.backgroundColor = UIColor.white
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.cornerRadius = 30
    view.clipsToBounds = true
    contentView.addSubview(view)
    return view
  }()
  
  private lazy var labelContentView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var loginLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 18)
    label.textAlignment = NSTextAlignment.left
    label.textColor = UIColor.bk
    label.numberOfLines = 1
    label.lineBreakMode = .byTruncatingTail
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var siteAdminLabel: UILabel = {
    let label = PaddingLabel(withInsets: 4, 4, 8, 8)
    label.text = "STAFF"
    label.font = UIFont.systemFont(ofSize: 18)
    label.layer.cornerRadius = 14
    label.clipsToBounds = true
    label.textAlignment = NSTextAlignment.left
    label.textColor = UIColor.w
    label.backgroundColor = UIColor.dan
    label.numberOfLines = 1
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  // loaging
  lazy var loadingIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .medium)
    indicator.translatesAutoresizingMaskIntoConstraints = false
    return indicator
  }()
  
  // siteAdminLabel height constraint
  private lazy var siteAdminLabelH: NSLayoutConstraint = {
    return self.siteAdminLabel.heightAnchor.constraint(equalToConstant: 28)
  }()
  // siteAdminLabel top constraint
  private lazy var siteAdminLabelTop: NSLayoutConstraint = {
    return siteAdminLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 4)
  }()
  
  // ViewModel
  var viewModel: UserCellViewModel?
  
  var isShowSiteAdminLabel = false {
    didSet {
      siteAdminLabelH.constant = isShowSiteAdminLabel ? 28 : 0
      siteAdminLabelTop.constant = isShowSiteAdminLabel ? 4 : 0
    }
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = UIColor.clear
    
    contentView.addSubview(bgView)
    bgView.addSubview(avatarImageView)
    bgView.addSubview(labelContentView)
    labelContentView.addSubview(loginLabel)
    labelContentView.addSubview(siteAdminLabel)
    avatarImageView.addSubview(loadingIndicator)
    
    NSLayoutConstraint.activate([
      bgView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
      bgView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
      bgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      
      avatarImageView.widthAnchor.constraint(equalToConstant: 60),
      avatarImageView.heightAnchor.constraint(equalToConstant: 60),
      avatarImageView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 16),
      avatarImageView.leftAnchor.constraint(equalTo: bgView.leftAnchor, constant: 16),
      avatarImageView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -16),
      
      labelContentView.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 16),
      labelContentView.rightAnchor.constraint(equalTo: bgView.rightAnchor, constant: -16),
      labelContentView.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
      
      loginLabel.leftAnchor.constraint(equalTo: labelContentView.leftAnchor),
      loginLabel.rightAnchor.constraint(equalTo: labelContentView.rightAnchor),
      loginLabel.topAnchor.constraint(equalTo: labelContentView.topAnchor),
      
      siteAdminLabel.leftAnchor.constraint(equalTo: labelContentView.leftAnchor),
      siteAdminLabelTop,
      siteAdminLabelH,
      siteAdminLabel.bottomAnchor.constraint(equalTo: labelContentView.bottomAnchor),
      
      loadingIndicator.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
      loadingIndicator.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
    ])
    
    self.selectionStyle = UITableViewCell.SelectionStyle.none
    self.accessoryType = UITableViewCell.AccessoryType.none
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.selectionStyle = UITableViewCell.SelectionStyle.none
    self.accessoryType = UITableViewCell.AccessoryType.none
  }
  
  func setup(viewModel: RowViewModel){
    guard let viewModel = viewModel as? UserCellViewModel else { return }
    self.viewModel = viewModel
    
    // avatar
    avatarImageView.image = viewModel.avatar.image
    
    self.loadingIndicator.startAnimating() // show Indicator
    viewModel.avatar.completeDownload = { [weak self] image in
      self?.loadingIndicator.stopAnimating() // hide Indicator
      self?.avatarImageView.image = image
    }
    viewModel.avatar.startDownload()
    
    // user login
    loginLabel.text = viewModel.login
    
    // show or hide siteAdmin Label
    isShowSiteAdminLabel = viewModel.isSiteAdmin
    
    setNeedsLayout()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.avatarImageView.image = nil
    viewModel?.cellPressed = nil
  }
}
