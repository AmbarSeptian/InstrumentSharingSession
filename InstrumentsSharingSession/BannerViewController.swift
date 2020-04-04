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
    
    let backgroundView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView: do {
            view.backgroundColor = .white
            backgroundView.backgroundColor = .red
            view.addSubview(collectionView)
        }
        
        setupConstraints: do {
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                backgroundView.topAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                constant: 20),
                backgroundView.widthAnchor
                    .constraint(equalTo: view.widthAnchor),
                backgroundView.centerXAnchor
                    .constraint(equalTo: view.centerXAnchor),
                backgroundView.heightAnchor
                    .constraint(equalTo: backgroundView.widthAnchor,
                                multiplier: 2/3),

                collectionView.topAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                constant: 40),
                collectionView.widthAnchor
                    .constraint(equalTo: view.widthAnchor),
                collectionView.centerXAnchor
                    .constraint(equalTo: view.centerXAnchor),
                collectionView.heightAnchor
                    .constraint(equalTo: collectionView.widthAnchor,
                                multiplier: 1/3)
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

