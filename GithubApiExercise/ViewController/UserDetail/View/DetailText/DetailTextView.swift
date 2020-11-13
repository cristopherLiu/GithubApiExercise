//
//  LocationView.swift
//  GithubApiExercise
//
//  Created by hjliu on 2020/11/13.
//

import UIKit

class DetailTextView: UIView {
  
  private lazy var iconImag: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var textLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 18.0)
    label.textColor = UIColor.bk
    label.textAlignment = NSTextAlignment.left
    label.numberOfLines = 1
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var badgeLabel: UILabel = {
    let label = PaddingLabel(withInsets: 4, 4, 8, 8)
    label.font = UIFont.systemFont(ofSize: 12)
    label.layer.cornerRadius = 12
    label.clipsToBounds = true
    label.textAlignment = NSTextAlignment.left
    label.textColor = UIColor.w
    label.backgroundColor = UIColor.dan
    label.numberOfLines = 1
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  // siteAdminLabel height constraint
  private lazy var badgeLabelH: NSLayoutConstraint = {
    return self.badgeLabel.heightAnchor.constraint(equalToConstant: 0)
  }()
  // siteAdminLabel top constraint
  private lazy var badgeLabelTop: NSLayoutConstraint = {
    return badgeLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 0)
  }()
  
  var isShowBadge = false {
    didSet {
      badgeLabelH.constant = isShowBadge ? 28 : 0
      badgeLabelTop.constant = isShowBadge ? 4 : 0
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func initView() {
    
    addSubview(iconImag)
    addSubview(textLabel)
    addSubview(badgeLabel)
    
    NSLayoutConstraint.activate([
      
      iconImag.widthAnchor.constraint(equalToConstant: 36),
      iconImag.heightAnchor.constraint(equalToConstant: 36),
      iconImag.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24),
      iconImag.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
      iconImag.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
      
      textLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
      textLabel.leftAnchor.constraint(equalTo: iconImag.rightAnchor, constant: 16),
      textLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24),
      
      badgeLabelTop,
      badgeLabel.leftAnchor.constraint(equalTo: iconImag.rightAnchor, constant: 16),
      badgeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
      badgeLabelH
    ])
  }
  
  func setup(viewModel: DetailTextViewModel) {
    
    switch viewModel {
    case is StatusViewModel:
      let model = viewModel as! StatusViewModel
      iconImag.image = model.iconImag
      textLabel.text = model.login
      badgeLabel.text = model.isSiteAdmin ? "STAFF" : nil
      isShowBadge = model.isSiteAdmin
      
    case is LocationViewModel:
      let model = viewModel as! LocationViewModel
      iconImag.image = model.iconImag
      textLabel.text = model.location
      
    case is BlogViewModel:
      let model = viewModel as! BlogViewModel
      iconImag.image = model.iconImag
      textLabel.text = model.blog
    default:
      break
    }
    setNeedsLayout()
  }
}
