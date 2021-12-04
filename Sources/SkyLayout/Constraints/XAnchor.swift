//
//  XAnchor.swift
//
//
//  Created by bytedance on 2021/12/4.
//
import UIKit

public class SkyXAnchor {
    
    private var view: UIView
    
    private var path: KeyPath<UIView, NSLayoutXAxisAnchor>
    
    private var constant: CGFloat = 0
    
    init(_ view: UIView, _ path: KeyPath<UIView, NSLayoutXAxisAnchor>) {
        self.path = path
        self.view = view
    }
    
    public var left: SkyMultiAnchor {
        return .init(view: view, x: [path, \.leftAnchor])
    }
    public var right: SkyMultiAnchor {
        return .init(view: view, x: [path, \.rightAnchor])
    }
    public var top: SkyMultiAnchor {
        return .init(view: view, x: [path], y: [\.topAnchor])
    }
    public var bottom: SkyMultiAnchor {
        return .init(view: view, x: [path], y: [\.bottomAnchor])
    }
    public var centerX: SkyMultiAnchor {
        return .init(view: view, x: [path, \.centerXAnchor])
    }
    public var centerY: SkyMultiAnchor {
        return .init(view: view, x: [path], y: [\.centerYAnchor])
    }
    public var height: SkyMultiAnchor {
        return .init(view: view, x: [path], dimension: [\.heightAnchor])
    }
    public var width: SkyMultiAnchor {
        return .init(view: view, x: [path], dimension: [\.widthAnchor])
    }
    
    public static func +(l: SkyXAnchor, r: CGFloat) -> SkyXAnchor {
        l.constant += r
        return l
    }
    
    public static func -(l: SkyXAnchor, r: CGFloat) -> SkyXAnchor {
        l.constant -= r
        return l
    }
    
    @discardableResult
    public static func ==(l: SkyXAnchor, r: UIView) -> NSLayoutConstraint {
        return l == SkyXAnchor(r, l.path)
    }
    
    @discardableResult
    public static func ==(l: SkyXAnchor, r: SkyXAnchor) -> NSLayoutConstraint {
        let cons = l.view[keyPath: l.path].constraint(equalTo: r.view[keyPath: r.path], constant: r.constant - l.constant)
        cons.isActive = true
        return cons
    }
}
