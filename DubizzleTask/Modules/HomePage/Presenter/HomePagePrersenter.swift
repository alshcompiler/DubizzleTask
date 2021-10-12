//
//  HomePagePrersenter.swift
//  DubizzleTask
//
//  Created by Mostafa.Sultan on 10/12/21.
//

import Foundation

class HomePagePresenter: HomePageViewToPresenterProtocol {
    
    // MARK: - Properties
    weak var view: HomePagePresenterToViewProtocol?
    var interactor: HomePagePresentorToInteractorProtocol?
    var router: HomePagePresenterToRouterProtocol?
    
    // MARK: - Methods
    func updateView() {
        interactor?.fetchItems()
    }
    
    func getItemsCount() -> Int? {
        return interactor?.items?.count
    }
    
    func getItem(index: Int) -> ItemModel? {
        return interactor?.items?[index]
    }
}

// MARK: - HomePageInteractorToPresenterProtocol
extension HomePagePresenter: HomePageInteractorToPresenterProtocol {
    
    func itemsFetched() {
        view?.showItems()
    }
    
    func itemsFetchedFailed() {
        view?.showError()
    }
}
