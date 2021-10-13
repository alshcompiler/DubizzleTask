//
//  DetailsPageViewController.swift
//  DubizzleTask
//
//  Created by Mostafa.Sultan on 10/13/21.
//

import UIKit
import FSPagerView
import AlamofireImage
import ImageCaching

class DetailsPageViewController: UIViewController {

    @IBOutlet private weak var detailsPageControl: FSPageControl! {
        didSet {
                self.detailsPageControl.numberOfPages = presenter?.getItem()?.imageUrls?.count ?? 0
                self.detailsPageControl.contentHorizontalAlignment = .center
                self.detailsPageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
                self.detailsPageControl.isHidden = (presenter?.getItem()?.imageUrls?.count ?? 0) <= 1
                self.detailsPageControl.roundCorners(radius: 5, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
            }
    }
    @IBOutlet private weak var detailsPageView: FSPagerView! {
        didSet {
            self.detailsPageView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.detailsPageView.roundCorners(radius: 5)
            self.detailsPageView.isInfinite = (presenter?.getItem()?.imageUrls?.count ?? 0) > 1
        }
    }
    @IBOutlet private weak var itemPriceLabel: UILabel!
    @IBOutlet private weak var itemNameLabel: UILabel!
    @IBOutlet private weak var itemDateLabel: UILabel!
    
    var presenter: DetailsPageViewToPresenterProtocol?
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private let screenHeight: CGFloat = UIScreen.main.bounds.width / 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    fileprivate func setupView() {
        itemPriceLabel.text = presenter?.getItem()?.price
        itemNameLabel.text = presenter?.getItem()?.name
        itemDateLabel.text = "Created At: \(presenter?.getItem()?.createdAt?.formattedDate() ?? "")"
    }
}

extension DetailsPageViewController: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        presenter?.getItem()?.imageUrls?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let item = presenter?.getItem()
        cell.imageView?.contentMode = .scaleAspectFill
        guard let cellImageView = cell.imageView else {return cell}
        ImageCaching.shared.loadImage(url: item?.imageUrls?[index] ?? "", imageView: cellImageView, placeholder: #imageLiteral(resourceName: "Dubizzle"))
        return cell
    }
}

extension DetailsPageViewController: FSPagerViewDelegate {
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        detailsPageControl.currentPage = targetIndex
    }
}
