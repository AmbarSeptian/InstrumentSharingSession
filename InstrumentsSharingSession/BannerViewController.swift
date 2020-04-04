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
            view.backgroundColor = .white
            view.addSubview(backgroundView)
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
        let newIndex = Int((scrollView.contentOffset.x / scrollView.bounds.width).rounded(.down))
        guard newIndex != currentIndex else { return }
        currentIndex = newIndex
//        backgroundView.image = banners[currentIndex].image.blurEffect()
        
        DispatchQueue.global().async {
                  let image = self.banners[self.currentIndex].image.blurEffect()
                  DispatchQueue.main.async {
                      self.backgroundView.image = image
                  }
              }
    }
}

extension UIImage {
    func blurEffect() -> UIImage {
        let currentFilter = CIFilter(name: "CIGaussianBlur")
        let beginImage = CIImage(image: self)!
        currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter!.setValue(20, forKey: kCIInputRadiusKey)

        let cropFilter = CIFilter(name: "CICrop")
        cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
        cropFilter!.setValue(CIVector(cgRect: beginImage.extent), forKey: "inputRectangle")

        let output = cropFilter!.outputImage
        let context = CIContext()
        let cgimg = context.createCGImage(output!, from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        return processedImage
    }

}

