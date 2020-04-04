//
//  BannerCell.swift
//  InstrumentsSharingSession
//
//  Created by Ambar Septian on 05/04/20.
//  Copyright © 2020 Ambar Septian. All rights reserved.
//

import UIKit

class BannerCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView: do {
            backgroundColor = .clear
            addSubview(imageView)
        }
        
        setupConstraints: do {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                imageView.topAnchor
                    .constraint(equalTo: topAnchor),
                imageView.leadingAnchor
                    .constraint(equalTo: leadingAnchor, constant: 20),
                imageView.trailingAnchor
                    .constraint(equalTo: trailingAnchor, constant: -20),
                imageView.bottomAnchor
                    .constraint(equalTo: bottomAnchor)
            ])
        }
        
        setupShadow: do {
            imageView.layer.shadowColor = UIColor.black.cgColor
            imageView.layer.shadowOpacity = 0.12
            imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
            imageView.layer.shadowRadius = 4
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func bind(_ banner: Banner) {
        imageView.image = banner.image
    }
}
