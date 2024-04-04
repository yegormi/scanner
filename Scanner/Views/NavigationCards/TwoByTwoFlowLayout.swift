import UIKit

class TwoByTwoFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
        let widthPerItem = (availableWidth - minimumInteritemSpacing) / 2
        itemSize = CGSize(width: widthPerItem, height: 140)
        minimumLineSpacing = 10
        minimumInteritemSpacing = 10
        sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
