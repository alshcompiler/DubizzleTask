//
//  HomePageRoute.swift
//  DubizzleTask
//
//  Created by Mostafa.Sultan on 10/12/21.
//

import Foundation
import UIKit

class HomePageRouter: HomePagePresenterToRouterProtocol{
    
    // MARK: - Methods
    
    class func createModule() -> UIViewController {
        
        let storyboard = UIStoryboard(storyboard: .main)
        let view: HomePageViewController = storyboard.instantiateViewController()
        let presenter: HomePageViewToPresenterProtocol & HomePageInteractorToPresenterProtocol = HomePagePresenter()
        let interactor: HomePagePresentorToInteractorProtocol = HomePageInteractor()
        let router: HomePagePresenterToRouterProtocol = HomePageRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return view
    }
}
