//
//  MulitiAnchor.swift
//  
//
//  Created by bytedance on 2021/12/4.
//
import UIKit

public class SkyMultiAnchor {

    private var view: UIView
    
    private var xPaths: [KeyPath<UIView, NSLayoutXAxisAnchor>]
    
    private var yPaths: [KeyPath<UIView, NSLayoutYAxisAnchor>]
    
    private var dimensionPaths: [KeyPath<UIView, NSLayoutDimension>]

    init(view: UIView, x: [KeyPath<UIView, NSLayoutXAxisAnchor>] = [], y: [KeyPath<UIView, NSLayoutYAxisAnchor>] = [], dimension: [KeyPath<UIView, NSLayoutDimension>] = []) {
        self.view = view
        xPaths = x
        yPaths = y
        dimensionPaths = dimension
    }

    public var left: SkyMultiAnchor {
        xPaths.append(\.leftAnchor)
        return self
    }
    public var right: SkyMultiAnchor {
        xPaths.append(\.rightAnchor)
        return self
    }
    public var top: SkyMultiAnchor {
        yPaths.append(\.topAnchor)
        return self
    }
    public var bottom: SkyMultiAnchor {
        yPaths.append(\.bottomAnchor)
        return self
    }
    public var centerX: SkyMultiAnchor {
        xPaths.append(\.centerXAnchor)
        return self
    }
    public var centerY: SkyMultiAnchor {
        yPaths.append(\.centerYAnchor)
        return self
    }
    
    @discardableResult
    public static func ==(l: SkyMultiAnchor, r: UIView) -> [NSLayoutConstraint] {
        var cons = [NSLayoutConstraint]()
        for xPath in l.xPaths {
            cons.append(SkyXAnchor(l.view, xPath) == r)
        }
        for yPath in l.yPaths {
            cons.append(SkyYAnchor(l.view, yPath) == r)
        }
        for dimensionPath in l.dimensionPaths {
            cons.append(SkyDimension(l.view, dimensionPath) == r)
        }
        for con in cons {
            con.isActive = true
        }
        return cons
    }
}
