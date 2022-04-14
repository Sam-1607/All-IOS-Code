
import UIKit

class StoreItemCollectionViewController: UICollectionViewController {
    
    func configureCollectionViewLayout(for searchScope: SearchScope) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let availableWidth = view.frame.width
        let itemWidth = (availableWidth - (8*4)) / 3
        let itemSize = CGSize(width: itemWidth, height: itemWidth * 2)
        let minimumInterItemSpacing: CGFloat = 8
        let minimumLineSpacing: CGFloat = 12

      
        collectionView.register(StoreItemCollectionViewSectionHeader.self, forSupplementaryViewOfKind: "Header", withReuseIdentifier: StoreItemCollectionViewSectionHeader.reuseIdentifier)
    }
    
}
