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
        
        let view = HomePageViewController()
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
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
}
