//
//  YAnchor.swift
//  
//
//  Created by bytedance on 2021/12/4.
//
import UIKit

public class SkyYAnchor {
    
    private var view: UIView
    
    private var path: KeyPath<UIView, NSLayoutYAxisAnchor>
    
    private var constant: CGFloat = 0
    
    init(_ view: UIView, _ path: KeyPath<UIView, NSLayoutYAxisAnchor>) {
        self.path = path
        self.view = view
    }
    
    public var left: SkyMultiAnchor {
        return .init(view: view, x: [\.leftAnchor], y: [path])
    }
    public var right: SkyMultiAnchor {
        return .init(view: view, x: [\.rightAnchor], y: [path])
    }
    public var top: SkyMultiAnchor {
        return .init(view: view, y: [path, \.topAnchor])
    }
    public var bottom: SkyMultiAnchor {
        return .init(view: view, y: [path, \.bottomAnchor])
    }
    public var centerX: SkyMultiAnchor {
        return .init(view: view, x: [\.centerXAnchor], y: [path])
    }
    public var centerY: SkyMultiAnchor {
        return .init(view: view, y: [path, \.centerYAnchor])
    }
    public var height: SkyMultiAnchor {
        return .init(view: view, y: [path], dimension: [\.heightAnchor])
    }
    public var width: SkyMultiAnchor {
        return .init(view: view, y: [path], dimension: [\.widthAnchor])
    }
    
    public static func +(l: SkyYAnchor, r: CGFloat) -> SkyYAnchor {
        l.constant += r
        return l
    }
    
    public static func -(l: SkyYAnchor, r: CGFloat) -> SkyYAnchor {
        l.constant -= r
        return l
    }
    
    @discardableResult
    public static func ==(l: SkyYAnchor, r: UIView) -> NSLayoutConstraint {
        return l == SkyYAnchor(r, l.path)
    }
    
    @discardableResult
    public static func ==(l: SkyYAnchor, r: SkyYAnchor) -> NSLayoutConstraint {
        let cons = l.view[keyPath: l.path].constraint(equalTo: r.view[keyPath: r.path], constant: r.constant - l.constant)
        cons.isActive = true
        return cons
    }
}
