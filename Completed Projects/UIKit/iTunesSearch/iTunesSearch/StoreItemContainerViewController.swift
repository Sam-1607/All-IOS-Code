
import UIKit

class StoreItemContainerViewController: UIViewController, UISearchResultsUpdating {
    
    @IBOutlet var tableContainerView: UIView!
    @IBOutlet var collectionContainerView: UIView!
    
    let searchController = UISearchController()
    let storeItemController = StoreItemController()

    var tableViewDataSource: UITableViewDiffableDataSource<String, StoreItem>!
    var collectionViewDataSource: UICollectionViewDiffableDataSource<String, StoreItem>!
    
    var items = [StoreItem]()
    var itemsSnapshot: NSDiffableDataSourceSnapshot<String, StoreItem> {
        
        var snapshot = NSDiffableDataSourceSnapshot<String, StoreItem>()
        snapshot.appendSections(["Results"])
        snapshot.appendItems(items)
        
        return snapshot
    }
    
    let queryOptions = ["movie", "music", "software", "ebook"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.automaticallyShowsSearchResultsController = true
        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.scopeButtonTitles = ["Movies", "Music", "Apps", "Books"]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tableViewController = segue.destination as? StoreItemListTableViewController {
            configureTableViewDataSource(tableViewController.tableView)
        }
        if let collectionViewController = segue.destination as? StoreItemCollectionViewController {
            configureCollectionViewDataSource(collectionViewController.collectionView)
        }
    }
    
    func configureTableViewDataSource(_ tableView: UITableView) {
        tableViewDataSource = UITableViewDiffableDataSource<String, StoreItem>(tableView: tableView, cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath) as! ItemTableViewCell
           // cell.configure(for: item, storeItemController: self.storeItemController)
            
            cell.titleLabel.text = item.name
            cell.detailLabel.text = item.artist
            cell.itemImageView?.image = UIImage(systemName: "photo")
            
            self.storeItemController.fetchImage(from: item.artworkURL) { (result) in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        cell.itemImageView.image = image
                    }
                case .failure(let error):
                    print("Error fetching Image \(error.localizedDescription)")
                }
            }
            return cell
        })
    }
    
    func configureCollectionViewDataSource(_ collectionView: UICollectionView) {
        collectionViewDataSource = UICollectionViewDiffableDataSource<String, StoreItem>(collectionView: collectionView, cellProvider: {(collectionView, indexPath, item) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Item", for: indexPath) as! ItemCollectionViewCell
            
            cell.titleLabel.text = item.name
            cell.detailLabel.text = item.artist
            cell.itemImageView?.image = UIImage(systemName: "photo")
            
            self.storeItemController.fetchImage(from: item.artworkURL) { (result) in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        cell.itemImageView.image = image
                    }
                case.failure(let error):
                    print("Error Fetching image: \(error.localizedDescription)")
                }
            }
            return cell
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(fetchMatchingItems), object: nil)
        perform(#selector(fetchMatchingItems), with: nil, afterDelay: 0.3)
    }
                
    @IBAction func switchContainerView(_ sender: UISegmentedControl) {
        tableContainerView.isHidden.toggle()
        collectionContainerView.isHidden.toggle()
    }
    
    @objc func fetchMatchingItems() {
        
        self.items = []
        
        tableViewDataSource.apply(itemsSnapshot, animatingDifferences: true, completion: nil)
        collectionViewDataSource.apply(itemsSnapshot, animatingDifferences: true, completion: nil)
        
        let searchTerm = searchController.searchBar.text ?? ""
        let mediaType = queryOptions[searchController.searchBar.selectedScopeButtonIndex]
        
        if !searchTerm.isEmpty {
            
            let query = [
                "term": searchTerm,
                "media": mediaType,
                "lang": "en_us",
                "limit": "20"
            ]
            
            storeItemController.fetchItems(matching: query) { (result) in
                switch result {
                case .success(let items):
                    DispatchQueue.main.async {
                        guard searchTerm == self.searchController.searchBar.text else {
                            return
                        }
                        
                        self.items = items
                        self.tableViewDataSource.apply(self.itemsSnapshot, animatingDifferences: true, completion: nil)
                        self.collectionViewDataSource.apply(self.itemsSnapshot, animatingDifferences: true, completion: nil)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
}
