//
//  HomeController.swift
//  Refresh
//
//  Created by Jose Torres-Vargas on 7/17/21.
//

import UIKit


class HomeController: UICollectionViewController {
    // MARK: Properties
    let cellId = "cellId"
    let cellId1 = "cellId1"
    let animeInfoController = AnimeInfoController() 
    var referenceNestedCell: NestedCollectionViewCell?
    
    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RowCellView.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(NestedCollectionViewCell.self, forCellWithReuseIdentifier: cellId1)
        
        navigationItem.title = "Summer 2021"
        navigationController?.navigationBar.isTranslucent = false
        
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.delegate = self
        
        //Fetch data
        AnimeClient.shared.getAnimeFor(season: "WINTER", vc: self, currentPage: 1)
    }
}

extension HomeController: UICollectionViewDelegateFlowLayout {
    //number of cells in my collection view
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AnimeClient.shared.animeData?.count ?? 0
    }
    
    //dequeue cells that will be used
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(indexPath.item == 0) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId1, for: indexPath) as! NestedCollectionViewCell
            self.referenceNestedCell = cell
            return cell
        }
    
        let rowCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RowCellView
        if let animeData = AnimeClient.shared.animeData {
            rowCell.data = animeData[indexPath.item - 1]
        }
        rowCell.backgroundColor = .secondarySystemBackground
        return rowCell
    }
    
    //cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.item == 0){
            return CGSize(width: view.frame.width, height: 300)
        }
        return CGSize(width: view.frame.width, height: 192)
    }
    
    //get rid of extra spacing in between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.item == 0) {return}
        
        if let navigator = navigationController {
            if let animeData = AnimeClient.shared.animeData {
                self.animeInfoController.animeData = animeData[indexPath.item - 1]
                navigator.pushViewController(animeInfoController, animated: false)
            }
        }
    }
}
