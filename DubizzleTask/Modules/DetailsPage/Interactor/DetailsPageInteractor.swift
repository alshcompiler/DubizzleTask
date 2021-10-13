//
//  DetailsPageInteractor.swift
//  DubizzleTask
//
//  Created by Mostafa.Sultan on 10/13/21.
//

import Foundation
import Alamofire

class DetailsPageInteractor: DetailsPagePresentorToInteractorProtocol {
    
    // MARK: - Properties
    weak var presenter: DetailsPageInteractorToPresenterProtocol?
    var item: ItemModel?
}
