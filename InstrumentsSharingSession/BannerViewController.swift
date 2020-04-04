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
    
    let horizontalView: UIView = {
        let horizontalView = UIView()
        horizontalView.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        return horizontalView
    }()
    
    let banners = Banner.defaultBanners
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView: do {
            view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            view.addSubview(backgroundView)
            view.addSubview(collectionView)
            view.addSubview(horizontalView)
        }
        
        setupConstraints: do {
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            horizontalView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                backgroundView.topAnchor
                    .constraint(equalTo: view.topAnchor),
                backgroundView.widthAnchor
                    .constraint(equalTo: view.widthAnchor),
                backgroundView.centerXAnchor
                    .constraint(equalTo: view.centerXAnchor),
                backgroundView.heightAnchor
                    .constraint(equalTo: backgroundView.widthAnchor,
                                multiplier: 2/3),
                
                collectionView.bottomAnchor
                    .constraint(equalTo: backgroundView.bottomAnchor, constant: 30),
                collectionView.widthAnchor
                    .constraint(equalTo: view.widthAnchor),
                collectionView.centerXAnchor
                    .constraint(equalTo: view.centerXAnchor),
                collectionView.heightAnchor
                    .constraint(equalTo: collectionView.widthAnchor,
                                multiplier: 0.4),
                
                horizontalView.topAnchor
                    .constraint(equalTo: backgroundView.bottomAnchor,
                                constant: 20),
                horizontalView.leadingAnchor
                        .constraint(equalTo: view.leadingAnchor,
                                    constant: -200),
                                
                horizontalView.widthAnchor
                    .constraint(equalToConstant: 200),
                horizontalView.heightAnchor
                    .constraint(equalToConstant: 4),
            ])
        }
        
        collectionView: do {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(BannerCell.self, forCellWithReuseIdentifier: "BannerCell")
        }
        
        animation: do {
            UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                self.horizontalView.frame.origin.x = 300
            }, completion: nil)
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
        let newIndex = max(0, Int((scrollView.contentOffset.x / scrollView.bounds.width).rounded(.down)))
        guard newIndex != currentIndex else { return }
        currentIndex = newIndex
        //        backgroundView.image = banners[currentIndex].image.blurEffect()
        
        DispatchQueue.global().async {
            let image = self.banners[newIndex].image.blurEffect()
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
        currentFilter!.setValue(100, forKey: kCIInputRadiusKey)
        
        let cropFilter = CIFilter(name: "CICrop")
        cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
        cropFilter!.setValue(CIVector(cgRect: beginImage.extent), forKey: "inputRectangle")
        
        let output = cropFilter!.outputImage
        let context = CIContext()
        let cgimg = context.createCGImage(output!, from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        return processedImage
    }
    
     func resizeImage(targetSize: CGSize) -> UIImage {
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
}

