
import UIKit

class StoreItemContainerViewController: UIViewController, UISearchResultsUpdating {
    
    @IBOutlet var tableContainerView: UIView!
    @IBOutlet var collectionContainerView: UIView!
    
    let searchController = UISearchController()
    let storeItemController = StoreItemController()
    
    var tableViewDataSource: UITableViewDiffableDataSource<String, StoreItem>!
    var collectionViewDataSource: UICollectionViewDiffableDataSource<String, StoreItem>!
    
    //   var items = [StoreItem]()
    //    var itemsSnapshot: NSDiffableDataSourceSnapshot<String, StoreItem> {
    //        var snapshot = NSDiffableDataSourceSnapshot<String, StoreItem>()
    //        snapshot.appendSections(["Results"])
    //        snapshot.appendItems(items)
    //
    //        return snapshot
    //    }
    var itemsSnapshot = NSDiffableDataSourceSnapshot<String, StoreItem>()
    //    let queryOptions = ["movie", "music", "software", "ebook"]
    
    var selectedSearchScope: SearchScope {
        let selectedIndex = searchController.searchBar.selectedScopeButtonIndex
        let searchScope = SearchScope.allCases[selectedIndex]
        
        return searchScope
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        
        searchController.searchBar.scopeButtonTitles = SearchScope.allCases.map { $0.title }
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
            collectionViewController.configureCollectionViewLayout(for: selectedSearchScope)
            configureCollectionViewDataSource(collectionViewController.collectionView)
        }
    }
    
    // MARK: I MAY HAVE SCREWED THIS PART UP IDK
    
    func configureTableViewDataSource2(_ tableView: UITableView) {
        tableViewDataSource = UITableViewDiffableDataSource<String, StoreItem>(tableView: tableView, cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath) as! ItemTableViewCell
            cell.configure(for: item, storeItemController: self.storeItemController)

            return cell
        })
    }
    
    func configureTableViewDataSource(_ tableView: UITableView) -> UITableViewDiffableDataSource<String, StoreItem>?  {
       tableViewDataSource = StoreItemTableViewDiffableDataSource(tableView: tableView, storeItemController: storeItemController)
            
        return tableViewDataSource
    }
    
    func configureCollectionViewDataSource(_ collectionView: UICollectionView) {
        collectionViewDataSource = .init(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Item", for: indexPath) as! ItemCollectionViewCell
            cell.configure(for: item, storeItemController: self.storeItemController)
            
            return cell
        })
        
        collectionViewDataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: "Header", withReuseIdentifier: StoreItemCollectionViewSectionHeader.reuseIdentifier, for: indexPath) as! StoreItemCollectionViewSectionHeader
            let title = self.itemsSnapshot.sectionIdentifiers[indexPath.section]
            headerView.setTitle(title)
            
            return headerView
        }
    }
    
    func configureCollectionViewLayout(for searchScope: SearchScope) {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 5, bottom: 8, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .absolute(166))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(28))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "Header", alignment: .topLeading)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [headerItem]
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        collectionView?.collectionViewLayout = layout
        
            }
    
    func createSectionedSnapshot(from items: [StoreItem]) ->
       NSDiffableDataSourceSnapshot<String, StoreItem> {
           
        let movies = items.filter { $0.kind == "feature-movie" }
        let music = items.filter { $0.kind == "song" || $0.kind == "album" }
        let apps = items.filter { $0.kind == "software" }
        let books = items.filter { $0.kind == "ebook" }
        let grouped: [(SearchScope, [StoreItem])] = [
            (.movies, movies),
            (.music, music),
            (.apps, apps),
            (.books, books)
        ]
        var snapshot = NSDiffableDataSourceSnapshot<String, StoreItem>()
        grouped.forEach { (scope, items) in
            if items.count > 0 {
                snapshot.appendSections([scope.title])
                snapshot.appendItems(items, toSection: scope.title)
            }
        }
        return snapshot
    }
    
    func handleFetchedItems(_ items: [StoreItem]) {
        let currentSnapshotItems = itemsSnapshot.itemIdentifiers
        itemsSnapshot = createSectionedSnapshot(from:
           currentSnapshotItems + items)
        
        tableViewDataSource.apply(itemsSnapshot,
           animatingDifferences: true, completion: nil)
        collectionViewDataSource.apply(itemsSnapshot,
           animatingDifferences: true, completion: nil)
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
        itemsSnapshot.deleteAllItems()
        
        // apply data source changes
        tableViewDataSource.apply(itemsSnapshot, animatingDifferences: true, completion: nil)
        collectionViewDataSource.apply(itemsSnapshot, animatingDifferences: true, completion: nil)
        
        let searchScopes: [SearchScope]
        if selectedSearchScope == .all {
            searchScopes = [.movies, .music, .apps, .books]
        } else {
            searchScopes = [selectedSearchScope]
        }
        
        let searchTerm = searchController.searchBar.text ?? ""
        if !searchTerm.isEmpty {
            // set up query dictionary
            let query = [
                "term": searchTerm,
                "media": selectedSearchScope.mediaType,
                "lang": "en_us",
                "limit": "20"
            ]
            
            for searchScope in searchScopes {
                let query = [
                    "term": searchTerm,
                    "media": searchScope.mediaType,
                    "lang": "en_us",
                    "limit": "20"
                ]
                storeItemController.fetchItems(matching: query) { (result) in
                    switch result {
                    case .success(let items):
                        DispatchQueue.main.async {
                            guard searchTerm ==
                                    self.searchController.searchBar.text else {
                                return
                            }
                            self.handleFetchedItems(items)
//                            self.tableViewDataSource.apply(self.itemsSnapshot,
//                                                           animatingDifferences: true, completion: nil)
//                            self.collectionViewDataSource.apply(self.itemsSnapshot,
//                                                                animatingDifferences: true, completion: nil)
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            
            
            
            //        use the item controller to fetch items
            //            storeItemController.fetchItems(matching: query) { (result) in
            //                switch result {
            //                case .success(let items):
            //                    // if successful, use the main queue to set self.items and reload the table view
            //                    DispatchQueue.main.async {
            //                        guard searchTerm == self.searchController.searchBar.text else {
            //                            return
            //                        }
            //
            //                        // apply data source changes
            //                        self.tableViewDataSource.apply(self.itemsSnapshot, animatingDifferences: true, completion: nil)
            //                        self.collectionViewDataSource.apply(self.itemsSnapshot, animatingDifferences: true, completion: nil)
            //                    }
            //                case .failure(let error):
            //                    // otherwise, print an error to the console
            //                    print(error)
            //                }
        }
    }
}


