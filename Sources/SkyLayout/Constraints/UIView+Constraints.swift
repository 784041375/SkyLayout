//
//  UIView+Constraints.swift
//  
//
//  Created by bytedance on 2021/12/4.
//
import UIKit

public extension UIView {
    var left: SkyXAnchor {
        return .init(self, \.leftAnchor)
    }
    var right: SkyXAnchor {
        return .init(self, \.rightAnchor)
    }
    var top: SkyYAnchor {
        return .init(self, \.topAnchor)
    }
    var bottom: SkyYAnchor {
        return .init(self, \.bottomAnchor)
    }
    var centerX: SkyXAnchor {
        return .init(self, \.centerXAnchor)
    }
    var centerY: SkyYAnchor {
        return .init(self, \.centerYAnchor)
    }
    var height: SkyDimension {
        return .init(self, \.heightAnchor)
    }
    var width: SkyDimension {
        return .init(self, \.widthAnchor)
    }
    var edges: SkyMultiAnchor {
        return .init(view: self, x: [\.leftAnchor, \.rightAnchor], y: [\.topAnchor, \.bottomAnchor])
    }
}
