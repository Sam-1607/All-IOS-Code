
import UIKit

class StoreItemListTableViewController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var filterSegmentedControl: UISegmentedControl!
    
    // add item controller property
    
    var items = [StoreItem]()
    let networkController = StoreItemController()
    let queryOptions = ["movie", "music", "software", "ebook"]
    
   // var storeItem = StoreItemsController 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func fetchMatchingItems() {
        
        self.items = []
        self.tableView.reloadData()
        
        let searchTerm = searchBar.text ?? ""
        let mediaType = queryOptions[filterSegmentedControl.selectedSegmentIndex]
        
        if !searchTerm.isEmpty {
            let query = [
                "term": searchTerm,
                "media": mediaType,
                "lang": "en_us",
                
                "limit": "10"
            ]
            
            // set up query dictionarys
            networkController.fetchItems(matching: query) { result in
                //what the function does
                switch result {
                case .success(let items):
                    DispatchQueue.main.async {
                        self.items = items
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
                
            }
            // use the item controller to fetch items
            // if successful, use the main queue to set self.items and reload the table view
            // otherwise, print an error to the console
        }
    }
    
    func configure(cell: ItemCell, forItemAt indexPath: IndexPath) {
        
        let item = items[indexPath.row]
        cell.titleLabel.text = item.trackName
        cell.detailLabel.text = item.artistName
        cell.itemImageView.image = UIImage(systemName: "photo")
        
        networkController.fetchImage(from: item.artWorkURL) { (result) in
            switch result {
            case.success(let image):
                DispatchQueue.main.async {
                    cell.itemImageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
        
        // set cell.titleLabel to the item's name
        
        // set cell.detailLabel to the item's artist
        
        // set cell.itemImageView to the system image "photo"
        
        // initialize a network task to fetch the item's artwork
        
        // if successful, use the main queue capture the cell, to initialize a UIImage, and set the cell's image view's image to the
    }
    
    @IBAction func filterOptionUpdated(_ sender: UISegmentedControl) {
        
        fetchMatchingItems()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath) as! ItemCell
        configure(cell: cell, forItemAt: indexPath)

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension StoreItemListTableViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        fetchMatchingItems()
        searchBar.resignFirstResponder()
    }
}

