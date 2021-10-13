//
//  DetailsPageRoute.swift
//  DubizzleTask
//
//  Created by Mostafa.Sultan on 10/13/21.
//

import Foundation
import UIKit

class DetailsPageRouter: DetailsPagePresenterToRouterProtocol{
    
    // MARK: - Methods
    
    class func createModule(with item: ItemModel) -> UIViewController {
        
        let storyboard = UIStoryboard(storyboard: .main)
        let view: DetailsPageViewController = storyboard.instantiateViewController()
        let presenter: DetailsPageViewToPresenterProtocol = DetailsPagePresenter()
        let interactor: DetailsPagePresentorToInteractorProtocol = DetailsPageInteractor()
        let router: DetailsPagePresenterToRouterProtocol = DetailsPageRouter()
        
        view.presenter = presenter
        interactor.item = item
        presenter.router = router
        presenter.interactor = interactor
        return view
    }
}
