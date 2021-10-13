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

    @IBOutlet private weak var itemPageControl: FSPageControl! {
        didSet {
                self.itemPageControl.numberOfPages = presenter?.getItem(index: itemIndex)?.imageUrls?.count ?? 0
                self.itemPageControl.contentHorizontalAlignment = .center
                self.itemPageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
                self.itemPageControl.isHidden = (presenter?.getItem(index: itemIndex)?.imageUrls?.count ?? 0) <= 1
                self.itemPageControl.roundCorners(radius: 5, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
            }
    }
    @IBOutlet private weak var itemPagerView: FSPagerView! {
        didSet {
                self.itemPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
                self.itemPagerView.roundCorners(radius: 5)
                self.itemPagerView.isInfinite = (presenter?.getItem(index: itemIndex)?.imageUrls?.count ?? 0) > 1
            }
    }

    @IBOutlet private weak var itemPriceLabel: UILabel!
    @IBOutlet private weak var itemNameLabel: UILabel!
    weak var presenter: HomePageViewToPresenterBaseProtocol? // made this base presenter to prevent the cell from accessing updateView method in HomePageViewToPresenterProtocol to be consistent with SOLID principles
    private var itemIndex: Int = 0
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private let screenHeight: CGFloat = UIScreen.main.bounds.width / 3.0
    private weak var delegate: HomePageTableCellDelegate?
    
    func configure(homePresenter: HomePageViewToPresenterProtocol?, homeDelegate: HomePageTableCellDelegate,cellIndex: Int) {
        presenter = homePresenter
        delegate = homeDelegate
        itemIndex = cellIndex
        let item = presenter?.getItem(index: itemIndex)
        itemNameLabel.text = item?.name
        itemPriceLabel.text = item?.price
        itemPageControl.currentPage = 0 // to avoid cell reusability issue
    }
    
    fileprivate func loadImage(_ imageURL: String?, _ cell: FSPagerViewCell) {
        
        guard let url = URL(string: imageURL ?? "") else {return}
        
//        cell.imageView?.af.cancelImageRequest()
        let filter: AspectScaledToFillSizeFilter = AspectScaledToFillSizeFilter(
            // small enough for memory( images were large ), large enough for details screen
            size: CGSize(width: screenWidth, height: screenHeight)
        )
        cell.imageView?.af.setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "Dubizzle"),filter: filter, imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: false){imageResponse in
            // work around because the downloaded image has no extension
            
                UIView.transition(with: cell.imageView ?? UIImageView(),
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                    cell.imageView?.image =  UIImage(data: imageResponse.data ?? Data()) ?? UIImage() },
                                  completion: nil)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemPagerView.reloadData()
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
        loadImage(item?.imageUrls?[0], cell)
        return cell
    }
}

extension ItemsTableViewCell: FSPagerViewDelegate {
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        delegate?.navigateToDetailsScreen(at: itemIndex)
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        itemPageControl.currentPage = targetIndex
    }
}
