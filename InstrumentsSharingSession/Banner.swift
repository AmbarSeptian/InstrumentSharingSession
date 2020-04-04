//
//  Banner.swift
//  InstrumentsSharingSession
//
//  Created by Ambar Septian on 05/04/20.
//  Copyright © 2020 Ambar Septian. All rights reserved.
//

import UIKit

struct Banner {
    let image: UIImage
    
    static var defaultBanners: [Banner] {
        return (1...4).map { index -> Banner in
            return Banner(image: UIImage(named: "image-\(index)") ?? UIImage())
        }
    }
}
