//
//  SkyAnchor.swift
//
//
//  Created by ccy on 2021/12/4.
//

import UIKit

public final class SkyAnchor<AnchorType, InnerAnchorType> where AnchorType: NSLayoutAnchor<InnerAnchorType> {
    
    private var view: UIView
    
    private var path: KeyPath<UIView, AnchorType>
    
    private var multipier: CGFloat = 1
    
    private var constant: CGFloat = 0
    
    init(_ view: UIView, _ path: KeyPath<UIView, AnchorType>) {
        self.path = path
        self.view = view
    }
    
    public var left: SkyMultiAnchor<DisableEqualToConstant> {
        .init(view)
        .addPath(\.leftAnchor)
    }
    public var right: SkyMultiAnchor<DisableEqualToConstant> {
        .init(view)
        .addPath(\.rightAnchor)
    }
    public var top: SkyMultiAnchor<DisableEqualToConstant> {
        .init(view)
        .addPath(\.topAnchor)
    }
    public var bottom: SkyMultiAnchor<DisableEqualToConstant> {
        .init(view)
        .addPath(\.bottomAnchor)
    }
    public var centerX: SkyMultiAnchor<DisableEqualToConstant> {
        .init(view)
        .addPath(\.centerXAnchor)
    }
    public var centerY: SkyMultiAnchor<DisableEqualToConstant> {
        .init(view)
        .addPath(\.centerYAnchor)
    }
    public var height: SkyMultiAnchor<EnableEqualToConstant> {
        .init(view)
        .addPath(\.heightAnchor)
    }
    public var width: SkyMultiAnchor<EnableEqualToConstant> {
        .init(view)
        .addPath(\.widthAnchor)
    }
    
    public static func +(l: SkyAnchor, r: CGFloat) -> SkyAnchor {
        l.constant += r
        return l
    }
    
    public static func -(l: SkyAnchor, r: CGFloat) -> SkyAnchor {
        l.constant -= r
        return l
    }
    
    @discardableResult
    public static func ==(l: SkyAnchor, r: UIView) -> NSLayoutConstraint {
        return l == SkyAnchor(r, l.path)
    }
    
    @discardableResult
    public static func ==(l: SkyAnchor, r: SkyAnchor) -> NSLayoutConstraint {
        let cons = l.view[keyPath: l.path].constraint(equalTo: r.view[keyPath: r.path], constant: r.constant - l.constant)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    public static func ==(l: SkyAnchor, r: NSLayoutAnchor<InnerAnchorType>) -> NSLayoutConstraint {
        let cons = l.view[keyPath: l.path].constraint(equalTo: r, constant: -l.constant)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    public static func ==(l: NSLayoutAnchor<InnerAnchorType>, r: SkyAnchor) -> NSLayoutConstraint {
        return r == l
    }
}

//MARK: - extension for NSLayoutDimension

extension SkyAnchor where AnchorType == NSLayoutDimension, InnerAnchorType == NSLayoutDimension {
    
    public static func *(l: SkyAnchor, r: CGFloat) -> SkyAnchor {
        l.multipier *= r
        return l
    }
    
    @discardableResult
    public static func ==(l: SkyAnchor, r: UIView) -> NSLayoutConstraint {
        return l == SkyAnchor(r, l.path)
    }
    
    @discardableResult
    public static func ==(l: SkyAnchor, r: CGFloat) -> NSLayoutConstraint {
        let cons = l.view[keyPath: l.path].constraint(equalToConstant: (r - l.constant) / l.multipier)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    public static func ==(l: SkyAnchor, r: SkyAnchor) -> NSLayoutConstraint {
        let cons = l.view[keyPath: l.path].constraint(equalTo: r.view[keyPath: r.path], multiplier:  r.multipier / l.multipier, constant: (r.constant - l.constant) / l.multipier)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    public static func ==(l: SkyAnchor, r: NSLayoutDimension) -> NSLayoutConstraint {
        let cons = l.view[keyPath: l.path].constraint(equalTo: r, multiplier: 1 / l.multipier, constant: -l.constant)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    public static func ==(l: NSLayoutDimension, r: SkyAnchor) -> NSLayoutConstraint {
        return r == l
    }
}
