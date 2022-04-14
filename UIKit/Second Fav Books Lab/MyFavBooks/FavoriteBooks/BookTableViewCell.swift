//
//  BookTableViewCell.swift
//  FavoriteBooks
//
//  Created by Sam Hiatt  on 10/18/21.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    
    @IBOutlet weak var bookAuthorLabel: UILabel!
    
    @IBOutlet weak var bookGenreLabel: UILabel!
    
    @IBOutlet weak var bookLenghtLabel: UILabel!
    
    func update(with book: Book) {
        bookTitleLabel.text = book.title
        bookAuthorLabel.text = book.author
        bookGenreLabel.text = book.genre
        bookLenghtLabel.text = book.length
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
