//
//  ViewController.swift
//  InstrumentsSharingSession
//
//  Created by Ambar Septian on 05/04/20.
//  Copyright © 2020 Ambar Septian. All rights reserved.
//

import UIKit

class BannerViewController: UIViewController {

    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView: do {
            view.backgroundColor = .white
            view.addSubview(collectionView)
        }
        
        setupConstraints: do {
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
               collectionView.topAnchor.constraint(equalTo: view.topAnchor),
               collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
               collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
           ])
        }
        
        collectionView: do {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(BannerCell.self, forCellWithReuseIdentifier: "BannerCell")
        }
    }
}

extension BannerViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
}

