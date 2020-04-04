//
//  BannerCell.swift
//  InstrumentsSharingSession
//
//  Created by Ambar Septian on 05/04/20.
//  Copyright © 2020 Ambar Septian. All rights reserved.
//

import UIKit

class BannerCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView: do {
            imageView.contentMode = .scaleAspectFill
            addSubview(imageView)
        }
        
        setupConstraints: do {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                imageView.topAnchor
                    .constraint(equalTo: topAnchor,constant: 20),
                imageView.widthAnchor
                    .constraint(equalTo: widthAnchor),
                imageView.centerXAnchor
                    .constraint(equalTo: centerXAnchor),
                imageView.bottomAnchor
                    .constraint(equalTo: bottomAnchor)
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func bind(_ banner: Banner) {
        imageView.image = banner.image
    }
}
