//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Sam Hiatt  on 12/2/21.
//

import UIKit
protocol ToCellDelegate: AnyObject {
    func checkMarkTapped(sender: ToDoCell)
}

class ToDoCell: UITableViewCell {
    
    @IBOutlet weak var isCompleteButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func completeButtonTapped(_ sender: UIButton) {
        delegate?.checkMarkTapped(sender: self)
    }
    weak var delegate: ToCellDelegate?
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
