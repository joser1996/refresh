//
//  BaseCellView.swift
//  Refresh
//
//  Created by Jose Torres-Vargas on 7/17/21.
//

import UIKit

class BaseCellView: UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        
    }
    
    
}
