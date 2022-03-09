//
//  ViewController.swift
//  RxSkeletonView
//
//  Created by Condy on 2022/2/5.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import RxSkeletonView

class HomeViewController: UIViewController {
    
    var tableView: UITableView!
    let disposeBag = DisposeBag()
    lazy var dataSource = tableViewSectionedReloadDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
        setupSkeleton()
        setupBinding()
    }
    
    func setupUI() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "asset")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "token")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.isSkeletonable = true
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupSkeleton() {
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
    }
    
    func setupBinding() {
        let asset = "10000"
        let token = ["12", "34", "56", "77", "200"]
        let array = [
            SkeletonSection.asset(items: [.asset(item: asset)]),
            SkeletonSection.token(items: token.map { .token(item: $0) })
        ]
        let driver = Observable.just(array)
        
        driver.asDriver(onErrorJustReturn: [])
            .delay(RxTimeInterval.seconds(3))
            .do(onNext: { [weak self] _ in
                self?.view.hideSkeleton()
            })
            .drive(tableView.rx.skeletonItems(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        driver.subscribe { _ in
            
        }.disposed(by: disposeBag)
    }
}

extension HomeViewController {
    
    private func tableViewSectionedReloadDataSource() -> RxTableViewSkeletonDataSource<SkeletonSection> {
        return RxTableViewSkeletonDataSource(
            configureCell: { (dataSource, tableView, indexPath, sectionItem) in
                switch sectionItem {
                case .asset(let item):
                    let cell = tableView.dequeueReusableCell(withIdentifier: sectionItem.identity, for: indexPath)
                    cell.isSkeletonable = true
                    cell.backgroundColor = UIColor.yellow
                    cell.textLabel?.text = item
                    cell.showAnimatedGradientSkeleton()
                    return cell
                case .token(let item):
                    let cell = tableView.dequeueReusableCell(withIdentifier: sectionItem.identity, for: indexPath)
                    cell.textLabel?.isSkeletonable = true
                    cell.backgroundColor = UIColor.green
                    cell.textLabel?.text = "\(indexPath.row)" + " - " + item
                    cell.textLabel?.showAnimatedGradientSkeleton()
                    return cell
                }
            }
        )
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataSource[indexPath].itemHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch dataSource[section] {
        case .asset:
            return 0
        case .token:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch dataSource[section] {
        case .asset:
            return nil
        case .token:
            return nil
        }
    }
}
