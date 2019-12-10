//
//  UIColor+Ext.swift
//  FirebaseChat
//
//  Created by Chad Rutherford on 12/10/19.
//  Copyright © 2019 chadarutherford.com. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: 1)
    }
}
