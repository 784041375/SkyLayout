//
//  ScrollView+Constraints.swift
//  
//
//  Created by ccy on 2021/12/5.
//

import UIKit

//MARK: - extension for frameLayoutGuide

@available(iOS 11.0, *)
public extension UIScrollView {
    
    var frameLeft: NSLayoutXAxisAnchor {
        frameLayoutGuide.leftAnchor
    }
    var frameRight: NSLayoutXAxisAnchor {
        frameLayoutGuide.rightAnchor
    }
    var frameTop: NSLayoutYAxisAnchor {
        frameLayoutGuide.topAnchor
    }
    var frameBottom: NSLayoutYAxisAnchor {
        frameLayoutGuide.bottomAnchor
    }
    var frameCenterX: NSLayoutXAxisAnchor {
        frameLayoutGuide.centerXAnchor
    }
    var frameCenterY: NSLayoutYAxisAnchor {
        frameLayoutGuide.centerYAnchor
    }
    var frameHeight: NSLayoutDimension {
        frameLayoutGuide.heightAnchor
    }
    var frameWidth: NSLayoutDimension {
        frameLayoutGuide.widthAnchor
    }
}
