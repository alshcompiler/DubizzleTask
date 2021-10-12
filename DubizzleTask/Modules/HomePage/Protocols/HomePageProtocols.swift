//
//  HomePageProtocols.swift
//  DubizzleTask
//
//  Created by Mostafa.Sultan on 10/12/21.
//

import Foundation
import UIKit

protocol HomePagePresenterToViewProtocol: class {
    func showItems()
    func showError()
}

protocol HomePageInteractorToPresenterProtocol: class {
    func itemsFetched()
    func itemsFetchedFailed()
}

protocol HomePagePresentorToInteractorProtocol: class {
    var presenter: HomePageInteractorToPresenterProtocol? { get set }
    var items: [ItemModel]? { get }
    
    func fetchItems()
}

protocol HomePageViewToPresenterProtocol: class {
    var view: HomePagePresenterToViewProtocol? { get set }
    var interactor: HomePagePresentorToInteractorProtocol? { get set }
    var router: HomePagePresenterToRouterProtocol? { get set }
    
    func updateView()
    func getItemsCount() -> Int?
    func getItem(index: Int) -> ItemModel?
}

protocol HomePagePresenterToRouterProtocol: class {
    static func createModule() -> UIViewController
}
