//
//  HomePagePrersenter.swift
//  DubizzleTask
//
//  Created by Mostafa.Sultan on 10/12/21.
//

import Foundation
import SVProgressHUD

class HomePagePresenter: HomePageViewToPresenterProtocol {
    
    // MARK: - Properties
    weak var view: HomePagePresenterToViewProtocol?
    var interactor: HomePagePresentorToInteractorProtocol?
    var router: HomePagePresenterToRouterProtocol?
    
    // MARK: - Methods
    func updateView() {
        SVProgressHUD.show()
        interactor?.fetchItems()
    }
    
    func getItemsCount() -> Int {
        return interactor?.items?.count ?? 0
    }
    
    func getItem(index: Int) -> ItemModel? {
        return interactor?.items?[index]
    }
}

// MARK: - HomePageInteractorToPresenterProtocol
extension HomePagePresenter: HomePageInteractorToPresenterProtocol {
    
    func itemsFetched() {
        SVProgressHUD.dismiss()
        view?.showItems()
    }
    
    func itemsFetchedFailed(message: String) {
        SVProgressHUD.dismiss()
        view?.showError(message: message)
    }
}
