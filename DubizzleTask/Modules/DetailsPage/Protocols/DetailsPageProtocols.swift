//
//  DetailsPageProtocol.swift
//  DubizzleTask
//
//  Created by Mostafa.Sultan on 10/13/21.
//

import Foundation
import UIKit

protocol DetailsPageInteractorToPresenterProtocol: class {
    func getItem()
}

 protocol DetailsPagePresentorToInteractorProtocol: class {
    var presenter: DetailsPageInteractorToPresenterProtocol? { get set }
    var item: ItemModel? { get set} 
    
}

protocol DetailsPageViewToPresenterProtocol: class {
    var interactor: DetailsPagePresentorToInteractorProtocol? { get set }
    var router: DetailsPagePresenterToRouterProtocol? { get set }
    
     func getItem() -> ItemModel?
}

protocol DetailsPageCellToPresenterProtocol: class {
    func getItemsCount() -> Int?
    func getItem(index: Int) -> ItemModel?
}

protocol DetailsPagePresenterToRouterProtocol: class {
    static func createModule(with item: ItemModel) -> UIViewController
}

