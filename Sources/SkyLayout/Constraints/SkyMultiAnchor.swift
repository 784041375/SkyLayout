//
//  MulitiAnchor.swift
//  
//
//  Created by bytedance on 2021/12/4.
//

import UIKit

public protocol EnableEqualToConstant {}

public protocol DisableEqualToConstant {}

public final class SkyMultiAnchor<EqualToConstant> {

    private var view: UIView
    
    private var xPaths = [KeyPath<UIView, NSLayoutXAxisAnchor>]()
    
    private var yPaths = [KeyPath<UIView, NSLayoutYAxisAnchor>]()
    
    private var dimensionPaths = [KeyPath<UIView, NSLayoutDimension>]()

    init(_ view: UIView) {
        self.view = view
    }
    
    public var left: SkyMultiAnchor<DisableEqualToConstant> {
        xPaths.append(\.leftAnchor)
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
    func addPath(_ path: KeyPath<UIView, NSLayoutXAxisAnchor>) -> SkyMultiAnchor {
        xPaths.append(path)
        return self
    }
    @discardableResult
    func addPath(_ path: KeyPath<UIView, NSLayoutYAxisAnchor>) -> SkyMultiAnchor {
        yPaths.append(path)
        return self
    }
    @discardableResult
    func addPath(_ path: KeyPath<UIView, NSLayoutDimension>) -> SkyMultiAnchor {
        dimensionPaths.append(path)
        return self
    }
    
    @discardableResult
    public static func ==(l: SkyMultiAnchor, r: UIView) -> [NSLayoutConstraint] {
        var cons = l.xPaths.map { SkyAnchor(l.view, $0) == r }
        cons.append(contentsOf: l.yPaths.map { SkyAnchor(l.view, $0) == r })
        cons.append(contentsOf: l.dimensionPaths.map { SkyAnchor(l.view, $0) == r })
        return cons
    }
}

//MARK: - extension for NSLayoutDimension

extension SkyMultiAnchor where EqualToConstant == EnableEqualToConstant {
    
    @discardableResult
    public static func ==(l: SkyMultiAnchor, r: CGFloat) -> [NSLayoutConstraint] {
        return l.dimensionPaths.map { SkyAnchor(l.view, $0) == r }
    }
}
