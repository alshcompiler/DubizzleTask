//
//  HomePageInteractor.swift
//  DubizzleTask
//
//  Created by Mostafa.Sultan on 10/12/21.
//

import Foundation
import Alamofire

class HomePageInteractor: HomePagePresentorToInteractorProtocol {
    
    // MARK: - Properties
    weak var presenter: HomePageInteractorToPresenterProtocol?
    var items: [ItemModel]?
    
    // MARK: - Methods
    func fetchItems() {
//        Alamofire.request("Constants.URL").response { response in
//            if(response.response?.statusCode == 200){
//                guard let data = response.data else { return }
//                do {
//                    let decoder = JSONDecoder()
//                    let newsResponse = try decoder.decode(NewsResponse.self, from: data)
//                    guard let articles = newsResponse.articles else { return }
//                    self.news = articles
//                    self.presenter?.liveNewsFetched()
//                } catch let error {
//                    print(error)
//                }
//            }
//            else {
//                self.presenter?.liveNewsFetchedFailed()
//            }
//        }
    }
}
