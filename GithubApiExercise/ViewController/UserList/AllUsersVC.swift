//
//  UserListVC.swift
//  GithubApiExercise
//
//  Created by hjliu on 2020/11/13.
//

import Foundation
import UIKit

class AllUsersVC: UIViewController {
  
  // Model
  var viewModel: AllUsersViewModel {
    return controller.viewModel
  }
  
  lazy var controller: AllUsersController = {
    return AllUsersController()
  }()
  
  // UI
  private lazy var tableView: UITableView = {
    let view = UITableView()
    view.backgroundColor = UIColor.clear
    view.delegate = self
    view.dataSource = self
    view.register(UserCell.self, forCellReuseIdentifier: UserCell.cellIdentifier())
    view.separatorStyle = UITableViewCell.SeparatorStyle.none
    view.rowHeight = UITableView.automaticDimension
    view.estimatedRowHeight = 44
    view.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(refreshControl)
    return view
  }()
  
  private lazy var refreshControl: UIRefreshControl = {
    let control = UIRefreshControl()
    control.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    return control
  }()
  
  lazy var loadingIdicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .medium)
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.hidesWhenStopped = true
    self.view.addSubview(indicator)
    NSLayoutConstraint.activate([
      indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
    ])
    return indicator
  }()
  
  private lazy var spinnerFooter: UIView = {
    let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 50) )
    let spinner = UIActivityIndicatorView(style: .medium)
    spinner.startAnimating()
    spinner.center = footerView.center
    footerView.addSubview(spinner)
    return footerView
  }()
  
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
    
    view.backgroundColor = UIColor.pri
    view.addSubview(tableView)
    
    NSLayoutConstraint.activate([
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
      tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
    ])
  }
  
  func initBinding() {
    
    viewModel.isLoading.addObserver { [weak self] (isLoading) in
      if isLoading {
        self?.loadingIdicator.startAnimating()
      } else {
        self?.loadingIdicator.stopAnimating()
        
        self?.refreshControl.endRefreshing()
        self?.tableView.tableFooterView = nil
      }
    }
    
    viewModel.rowViewModels.addObserver(fireNow: false) { [weak self] (models) in
      self?.tableView.reloadData()
    }
    
    viewModel.showUserDetail.addObserver(fireNow: false) { [weak self] (name) in
      let dialog = UserDetailVC(userName: name)
      self?.present(dialog, animated: true, completion: nil)
    }
  }
  
  @objc func refreshData() {
    controller.loadDefaultDatas()
  }
}

extension AllUsersVC: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.rowViewModels.value.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let rowViewModel = viewModel.rowViewModels.value[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: controller.cellIdentifier(for: rowViewModel), for: indexPath)
    if let cell = cell as? CellConfiguraable {
      cell.setup(viewModel: rowViewModel)
    }
    cell.layoutIfNeeded()
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let rowViewModel = viewModel.rowViewModels.value[indexPath.row] as? ViewModelPressible {
      rowViewModel.cellPressed?()
    }
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    
    // UITableView only moves in one direction, y axis
    let currentOffset = scrollView.contentOffset.y
    let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
    
    // Change 10.0 to adjust the distance from bottom
    if maximumOffset - currentOffset <= 10.0 {
      self.tableView.tableFooterView = spinnerFooter
      controller.loadMoreDatas() // Load more
    }
  }
}
