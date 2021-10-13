//
//  HomePageInteractor.swift
//  DubizzleTask
//
//  Created by Mostafa.Sultan on 10/12/21.
//

import Foundation
import Alamofire

typealias ItemsClosure = (Result<ItemsResult, Error>) -> Void
class HomePageInteractor: HomePagePresentorToInteractorProtocol {
    
    // MARK: - Properties
    weak var presenter: HomePageInteractorToPresenterProtocol?
    var items: [ItemModel]?
    
    // MARK: - Methods
    func fetchItems() {
        ItemsRouter.items.send(ItemsResult.self, then: { response in
            switch response {
            case .failure(let error):
                self.presenter?.itemsFetchedFailed(message: error.localizedDescription)
            case .success(let itemsResult):
                self.items = itemsResult.results
                self.presenter?.itemsFetched()
            }
        })
    }
}
