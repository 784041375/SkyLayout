//
//  Dimensioin.swift
//  
//
//  Created by bytedance on 2021/12/4.
//
import UIKit

public class SkyDimension {
    
    private var view: UIView
    
    private var path: KeyPath<UIView, NSLayoutDimension>
    
    private var multipier: CGFloat = 1
    
    private var constant: CGFloat = 0
    
    init(_ view: UIView, _ path: KeyPath<UIView, NSLayoutDimension>) {
        self.path = path
        self.view = view
    }
    
    public var left: SkyMultiAnchor<DisableEqualToConstant> {
        return .init(view: view, x: [\.leftAnchor], dimension: [path])
    }
    public var right: SkyMultiAnchor<DisableEqualToConstant> {
        return .init(view: view, x: [\.rightAnchor], dimension: [path])
    }
    public var top: SkyMultiAnchor<DisableEqualToConstant> {
        return .init(view: view, y: [\.topAnchor], dimension: [path])
    }
    public var bottom: SkyMultiAnchor<DisableEqualToConstant> {
        return .init(view: view, y: [\.bottomAnchor], dimension: [path])
    }
    public var centerX: SkyMultiAnchor<DisableEqualToConstant> {
        return .init(view: view, x: [\.centerXAnchor], dimension: [path])
    }
    public var centerY: SkyMultiAnchor<DisableEqualToConstant> {
        return .init(view: view, y: [\.centerYAnchor], dimension: [path])
    }
    public var height: SkyMultiAnchor<EnableEqualToConstant> {
        return .init(view: view, dimension: [path, \.heightAnchor])
    }
    public var width: SkyMultiAnchor<EnableEqualToConstant> {
        return .init(view: view, dimension: [path, \.widthAnchor])
    }
    
    public static func +(l: SkyDimension, r: CGFloat) -> SkyDimension {
        l.constant += r
        return l
    }
    
    public static func -(l: SkyDimension, r: CGFloat) -> SkyDimension {
        l.constant -= r
        return l
    }
    
    public static func *(l: SkyDimension, r: CGFloat) -> SkyDimension {
        l.multipier *= r
        return l
    }
    
    @discardableResult
    public static func ==(l: SkyDimension, r: UIView) -> NSLayoutConstraint {
        return l == SkyDimension(r, l.path)
    }
    
    @discardableResult
    public static func ==(l: SkyDimension, r: SkyDimension) -> NSLayoutConstraint {
        let cons = l.view[keyPath: l.path].constraint(equalTo: r.view[keyPath: r.path], multiplier: r.multipier / l.multipier, constant: (r.constant - l.constant) / l.multipier)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    public static func ==(l: SkyDimension, r: CGFloat) -> NSLayoutConstraint {
        let cons = l.view[keyPath: l.path].constraint(equalToConstant: r)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    public static func ==(l: SkyDimension, r: NSLayoutDimension) -> NSLayoutConstraint {
        let cons = l.view[keyPath: l.path].constraint(equalTo: r, multiplier: 1 / l.multipier, constant: -l.constant / l.multipier)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    public static func ==(l: NSLayoutDimension, r: SkyDimension) -> NSLayoutConstraint {
        let cons = l.constraint(equalTo: r.view[keyPath: r.path], multiplier: r.multipier, constant: r.constant)
        cons.isActive = true
        return cons
    }
}
