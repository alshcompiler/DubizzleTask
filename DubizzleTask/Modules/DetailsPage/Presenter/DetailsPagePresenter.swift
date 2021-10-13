//
//  DetailsPagePresenter.swift
//  DubizzleTask
//
//  Created by Mostafa.Sultan on 10/13/21.
//

import Foundation
import SVProgressHUD

class DetailsPagePresenter: DetailsPageViewToPresenterProtocol {
    
    // MARK: - Properties
    var interactor: DetailsPagePresentorToInteractorProtocol?
    var router: DetailsPagePresenterToRouterProtocol?
    
    // MARK: - Methods
    
    func getItem() -> ItemModel? {
        return interactor?.item
    }
}
