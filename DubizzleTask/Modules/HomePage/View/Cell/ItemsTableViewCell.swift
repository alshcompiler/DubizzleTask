//
//  ItemsTableViewCell.swift
//  DubizzleTask
//
//  Created by Mostafa.Sultan on 10/12/21.
//

import UIKit
import FSPagerView
import AlamofireImage

class ItemsTableViewCell: UITableViewCell {
    
    static let cellIdentifier: String = "\(ItemsTableViewCell.self)"

    @IBOutlet weak var itemPageControl: FSPagerView! {
        didSet {
                self.itemPageControl.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            }
    }

    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    weak var presenter: HomePageViewToPresenterBaseProtocol? // made this base presenter to prevent the cell from accessing updateView method in HomePageViewToPresenterProtocol to be consistent with SOLID principles
    private var itemIndex: Int = 0
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    
    func configure(homePresenter: HomePageViewToPresenterProtocol?,cellIndex: Int) {
        presenter = homePresenter
        itemIndex = cellIndex
        let item = presenter?.getItem(index: itemIndex)
        itemNameLabel.text = item?.name
        itemPriceLabel.text = item?.price
    }
    
    fileprivate func loadImage(_ imageURL: String?, _ cell: FSPagerViewCell) {
        
        guard let url = URL(string: imageURL ?? "") else {return}
        
//        cell.imageView?.af.cancelImageRequest()
//        cell.imageView?.image = nil
        let filter: AspectScaledToFillSizeFilter = AspectScaledToFillSizeFilter(
            // small enough for memory( images were large ), large enough for details screen
            size: CGSize(width: screenWidth, height: screenWidth)
        )
        cell.imageView?.af.setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "Dubizzle"),filter: filter, imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: false){imageResponse in
            // work around because the downloaded image has no extension
            UIView.transition(with: cell.imageView ?? UIImageView(),
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: {  cell.imageView?.image =  UIImage(data: imageResponse.data ?? Data()) ?? UIImage() },
                              completion: nil)
        }
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemPageControl.reloadData()
     }
    
}

extension ItemsTableViewCell: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        presenter?.getItem(index: itemIndex)?.imageUrls?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
//        photoImageView.af.cancelImageRequest()
//        photoImageView.image = nil
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let item = presenter?.getItem(index: itemIndex)
        cell.imageView?.contentMode = .scaleAspectFill
        loadImage(item?.imageUrls?[index], cell)
        return cell
    }
}

extension ItemsTableViewCell: FSPagerViewDelegate {
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
    }
}
