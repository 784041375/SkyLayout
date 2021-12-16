//
//  MulitiAnchor.swift
//  
//
//  Created by bytedance on 2021/12/4.
//

import UIKit

public final class SkyMultiAnchor<EqualToConstant> {

    private var view: UIView
    
    private var xPaths = [KeyPath<UIView, NSLayoutXAxisAnchor>]()
    
    private var yPaths = [KeyPath<UIView, NSLayoutYAxisAnchor>]()
    
    private var dimensionPaths = [KeyPath<UIView, NSLayoutDimension>]()

    init(_ view: UIView) {
        self.view = view
    }
    
    public var left: SkyMultiAnchor<DisableEqualToConstant> {
        addPath(\UIView.leftAnchor)
        return toDisableEqualToConstant()
    }
    public var right: SkyMultiAnchor<DisableEqualToConstant> {
        xPaths.append(\.rightAnchor)
        return toDisableEqualToConstant()
    }
    public var top: SkyMultiAnchor<DisableEqualToConstant> {
        yPaths.append(\.topAnchor)
        return toDisableEqualToConstant()
    }
    public var bottom: SkyMultiAnchor<DisableEqualToConstant> {
        yPaths.append(\.bottomAnchor)
        return toDisableEqualToConstant()
    }
    public var centerX: SkyMultiAnchor<DisableEqualToConstant> {
        xPaths.append(\.centerXAnchor)
        return toDisableEqualToConstant()
    }
    public var centerY: SkyMultiAnchor<DisableEqualToConstant> {
        yPaths.append(\.centerYAnchor)
        return toDisableEqualToConstant()
    }
    public var height: SkyMultiAnchor {
        dimensionPaths.append(\.heightAnchor)
        return self
    }
    public var width: SkyMultiAnchor {
        dimensionPaths.append(\.widthAnchor)
        return self
    }
    
    func toDisableEqualToConstant() -> SkyMultiAnchor<DisableEqualToConstant> {
        let newAnchor = SkyMultiAnchor<DisableEqualToConstant>(view)
        newAnchor.xPaths = xPaths
        newAnchor.yPaths = yPaths
        newAnchor.dimensionPaths = dimensionPaths
        return newAnchor
    }
    
    @discardableResult
    func addPath<T>(_ path: T) -> SkyMultiAnchor {
        return self
    }
    @discardableResult
    func addPath<T>(_ path: T) -> SkyMultiAnchor where T: KeyPath<UIView, NSLayoutXAxisAnchor> {
        xPaths.append(path)
        return self
    }
    @discardableResult
    func addPath<T>(_ path: T) -> SkyMultiAnchor where T: KeyPath<UIView, NSLayoutYAxisAnchor> {
        yPaths.append(path)
        return self
    }
    @discardableResult
    func addPath<T>(_ path: T) -> SkyMultiAnchor where T: KeyPath<UIView, NSLayoutDimension> {
        dimensionPaths.append(path)
        return self
    }
    
    @discardableResult
    public static func ==(l: SkyMultiAnchor, r: UIView) -> [NSLayoutConstraint] {
        var cons = [NSLayoutConstraint]()
        for xPath in l.xPaths {
            cons.append(SkyAnchor(l.view, xPath) == r)
        }
        for yPath in l.yPaths {
            cons.append(SkyAnchor(l.view, yPath) == r)
        }
        for dimensionPath in l.dimensionPaths {
            cons.append(SkyAnchor(l.view, dimensionPath) == r)
        }
        return cons
    }
    
    @discardableResult
    public static func ==(l: SkyMultiAnchor, r: CGFloat) -> [NSLayoutConstraint] where EqualToConstant: EnableEqualToConstant {
        var cons = [NSLayoutConstraint]()
        for dimensionPath in l.dimensionPaths {
            let con = l.view[keyPath: dimensionPath].constraint(equalToConstant: r)
            con.isActive = true
            cons.append(con)
        }
        return cons
    }
}

public protocol EnableEqualToConstant {}

public protocol DisableEqualToConstant {}
