//
//  ViewController.swift
//  DubizzleTask
//
//  Created by Mostafa.Sultan on 10/12/21.
//

import UIKit
import AlamofireImage
class HomePageViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    // MARK: - Properties
    var presenter: HomePageViewToPresenterProtocol?
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.updateView()
        configureTableView()
    }
    
    // MARK: - Helper Methods
    
    private func configureTableView() {
        itemsTableView.register(UINib(nibName: "ItemsTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: ItemsTableViewCell.cellIdentifier)
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        itemsTableView.tableFooterView = UIView()
        itemsTableView.rowHeight = UITableView.automaticDimension
        itemsTableView.estimatedRowHeight = 300
    }
}

extension HomePageViewController: HomePagePresenterToViewProtocol {

    func showItems() {
        itemsTableView.reloadData()
    }
    
    func showError(message: String) {
        showAlert(title: "Error", message: message)
    }
}

extension HomePageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getItemsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemsTableViewCell.cellIdentifier, for: indexPath) as! ItemsTableViewCell
        cell.configure(homePresenter: presenter, cellIndex: indexPath.row)
        return cell
    }
}

extension HomePageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
