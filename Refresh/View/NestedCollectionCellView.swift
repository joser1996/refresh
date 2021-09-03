//
//  NestedCollectionCellView.swift
//  Refresh
//
//  Created by Jose Torres-Vargas on 7/17/21.
//

import UIKit

class NestedCollectionViewCell: BaseCellView {
    let cellId = "AlarmCell"
    var isShowingAlarms: Bool = false
    var dataSource: [NestedCellData]?
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        collectionView.register(NestedCellView.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        changeDataSourceToToday()
    }
    
    func refreshCollectionView() {
        if isShowingAlarms {
            changeDataSourceToAlarm()
        } else {
            changeDataSourceToToday()
            self.dataSource = self.dataSource?.sorted(by: {$0.date < $1.date})
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func changeDataSourceToAlarm() {
        print("Nothing yet")
    }
    
    func changeDataSourceToToday() {
        guard let airingToday = AnimeClient.shared.airingToday else {return}
        var tempArray: [NestedCellData] = []
        for episode in airingToday {
            let airingDate = Alarm.airingDay(seconds: episode.nextAiringEpisode?.airingAt ?? 0)
            let cellData = NestedCellData(title: episode.title.romaji ?? "N/A", imageURL: episode.coverImage.large ?? "", date: airingDate)
            tempArray.append(cellData)
        }
        self.dataSource = tempArray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NestedCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NestedCellView
        if let dataSource = self.dataSource {
            cell.cellData = dataSource[indexPath.item]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 300) //old height 250
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
