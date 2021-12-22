//
//  UIView+Constraints.swift
//  
//
//  Created by ccy on 2021/12/4.
//

import UIKit

//MARK: - extension for SkyAnchor

public extension UIView {
    var left: SkyAnchor<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor> {
        .init(self, \.leftAnchor)
    }
    var right: SkyAnchor<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor> {
        .init(self, \.rightAnchor)
    }
    var top: SkyAnchor<NSLayoutYAxisAnchor, NSLayoutYAxisAnchor> {
        .init(self, \.topAnchor)
    }
    var bottom: SkyAnchor<NSLayoutYAxisAnchor, NSLayoutYAxisAnchor> {
        .init(self, \.bottomAnchor)
    }
    var centerX: SkyAnchor<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor> {
        return.init(self, \.centerXAnchor)
    }
    var centerY: SkyAnchor<NSLayoutYAxisAnchor, NSLayoutYAxisAnchor> {
        .init(self, \.centerYAnchor)
    }
    var height: SkyAnchor<NSLayoutDimension, NSLayoutDimension> {
        .init(self, \.heightAnchor)
    }
    var width: SkyAnchor<NSLayoutDimension, NSLayoutDimension> {
        .init(self, \.widthAnchor)
    }
    var edges: SkyMultiAnchor<DisableEqualToConstant> {
        .init(self)
        .addPath(\UIView.leftAnchor)
        .addPath(\UIView.rightAnchor)
        .addPath(\UIView.topAnchor)
        .addPath(\UIView.bottomAnchor)
    }
}

//MARK: - extension safeAreaLayoutGuide

@available(iOS 11.0, *)
public extension UIView {
    var safeLeft: SkyAnchor<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor> {
        .init(self, \.safeAreaLayoutGuide.leftAnchor)
    }
    var safeRight: SkyAnchor<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor> {
        .init(self, \.safeAreaLayoutGuide.rightAnchor)
    }
    var safeTop: SkyAnchor<NSLayoutYAxisAnchor, NSLayoutYAxisAnchor> {
        .init(self, \.safeAreaLayoutGuide.topAnchor)
    }
    var safeBottom: SkyAnchor<NSLayoutYAxisAnchor, NSLayoutYAxisAnchor> {
        .init(self, \.safeAreaLayoutGuide.bottomAnchor)
    }
    var safeCenterX: SkyAnchor<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor> {
        .init(self, \.safeAreaLayoutGuide.centerXAnchor)
    }
    var safeCenterY: SkyAnchor<NSLayoutYAxisAnchor, NSLayoutYAxisAnchor> {
        .init(self, \.safeAreaLayoutGuide.centerYAnchor)
    }
    var safeHeight: SkyAnchor<NSLayoutDimension, NSLayoutDimension> {
        .init(self, \.safeAreaLayoutGuide.heightAnchor)
    }
    var safeWidth: SkyAnchor<NSLayoutDimension, NSLayoutDimension> {
        .init(self, \.safeAreaLayoutGuide.widthAnchor)
    }
}
