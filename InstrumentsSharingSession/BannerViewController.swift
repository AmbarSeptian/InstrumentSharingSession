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
        flowLayout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    let backgroundView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    let banners = Banner.defaultBanners
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView: do {
            view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            view.addSubview(backgroundView)
            view.addSubview(collectionView)
        }
        
        collectionView: do {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(BannerCell.self, forCellWithReuseIdentifier: "BannerCell")
        }
        
        updateBackgroundImage(bannerIndex: currentIndex)
    }
    
    func updateBackgroundImage(bannerIndex: Int) {
        let banner = self.banners[bannerIndex]
        self.backgroundView.image = banner.image.blurEffect(radius: 200)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let backgroundHeight = view.bounds.width * 2 / 3
        backgroundView.frame = CGRect(x: 0,
                                      y: 0,
                                      width: view.bounds.width,
                                      height: backgroundHeight)
        
        let collectionHeight = view.bounds.width * 0.4
        collectionView.frame = CGRect(x: 0,
                                      y: backgroundView.frame.maxY - collectionHeight + 40,
                                      width: view.bounds.width,
                                      height: collectionHeight)
    }
}

extension BannerViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
        cell.bind(banners[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}

extension BannerViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let newIndex = max(0, Int((scrollView.contentOffset.x / scrollView.bounds.width).rounded(.down)))
        guard newIndex != currentIndex else { return }
        currentIndex = newIndex
        updateBackgroundImage(bannerIndex: newIndex)
    }
}
