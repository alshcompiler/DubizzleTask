//
//  ViewController.swift
//  DubizzleTask
//
//  Created by Mostafa.Sultan on 10/12/21.
//

import UIKit

class HomePageViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    
    // MARK: - Properties
    var presenter: HomePageViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension HomePageViewController: HomePagePresenterToViewProtocol {

    func showItems() {
//        tableView.reloadData()
    }
    
    func showError() {
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching News", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
