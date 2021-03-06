//
//  NestedCellView.swift
//  Refresh
//
//  Created by Jose Torres-Vargas on 7/17/21.
//

import UIKit

class NestedCellView: BaseCellView {
    var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var thumbNailView: UIImageView = {
        let tn = UIImageView()
        //DELETE THIS
        //tn.backgroundColor = .blue
        tn.translatesAutoresizingMaskIntoConstraints = false
        
        //set image here for now(dummy)
        tn.image = UIImage()
        tn.contentMode = .scaleAspectFill
        tn.clipsToBounds = true
        return tn
    }()
    
    var alarmLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        label.text = dateFormatter.string(from: date)
        label.textAlignment = .center
        return label
    }()
    
    var myFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        return formatter
    }()
    
    var cellData: NestedCellData? {
        didSet {
            //set the image
            if(cellData!.imageURL == "") {
                thumbNailView.image = nil
                thumbNailView.backgroundColor = .gray
            } else {
                thumbNailView.loadImageUsing(urlString: cellData!.imageURL) { image in
                    self.thumbNailView.image = image
                    self.thumbNailView.contentMode = .scaleAspectFill
                    self.thumbNailView.clipsToBounds = true
                }
            }
            //set the title
            title.text = cellData!.title
            //set the date
            alarmLabel.text = myFormatter.string(from: cellData!.date)
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        addSubview(title)
        addSubview(thumbNailView)
        addSubview(alarmLabel)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            thumbNailView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            thumbNailView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40),
            thumbNailView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            thumbNailView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            alarmLabel.topAnchor.constraint(equalTo: thumbNailView.bottomAnchor, constant: 5),
            alarmLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            alarmLabel.leadingAnchor.constraint(equalTo: thumbNailView.leadingAnchor),
            alarmLabel.trailingAnchor.constraint(equalTo: thumbNailView.trailingAnchor)
        ])
    }
}
