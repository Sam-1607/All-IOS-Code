//
//  StoreItemCollectionViewSectionHeader.swift
//  iTunesSearch
//
//  Created by Sam Hiatt  on 4/1/22.
//

import Foundation
import UIKit

class StoreItemCollectionViewSectionHeader: UICollectionReusableView {
    static let reuseIdentifier = "StoreItemCollectionViewSectionHeader"
    
    let titleLable: UILabel =  {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 17)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    func setTitle(_ title: String) {
        titleLable.text = title
    }
    
    func setUpView() {
        backgroundColor = .systemGray
        addSubview(titleLable)
        
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([titleLable.topAnchor.constraint(equalTo: topAnchor, constant: 2),
                                     titleLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
                                     titleLable.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
                                     titleLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)])
        
    }
    
}
