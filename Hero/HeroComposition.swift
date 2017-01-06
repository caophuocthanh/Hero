//
//  HeroViewState.swift
//  HeroExamples
//
//  Created by YiLun Zhao on 2017-01-05.
//  Copyright © 2017 Luke Zhao. All rights reserved.
//

import UIKit

public struct HeroComposition{
  internal var opacity:CGFloat?
  internal var cornerRadius:CGFloat?
  internal var position:CGPoint?
  internal var size:CGSize?
  internal var transform:CATransform3D?
  internal var spring:(CGFloat, CGFloat)?
  internal var delay:TimeInterval = 0
  internal var duration:TimeInterval?
  internal var timingFunction:CAMediaTimingFunction?
  internal var arc:CGFloat?
  internal var zPosition:CGFloat?
  internal var zPositionIfMatched:CGFloat?
  internal var source:String?
  internal var cascade:(TimeInterval, CascadePreprocessor.CascadeDirection)?
  internal var ignoreSubviewModifiers = false

  internal var custom:[String:Any]?
  
  init(modifiers:[HeroModifier]) {
    append(contentsOf: modifiers)
  }
  
  mutating func append(contentsOf modifiers:[HeroModifier]){
    var transform = self.transform ?? CATransform3DIdentity
    for modifier in modifiers {
      switch modifier{
      case .fade:
        self.opacity = 0
      case .position(let position):
        self.position = position
      case .size(let size):
        self.size = size
      case .perspective(let perspective):
        transform.m34 = 1.0 / -perspective
      case .transform(let t):
        transform = t
      case .scale(let x, let y, let z):
        transform = CATransform3DScale(transform, x, y, z)
      case .rotate(let x, let y, let z):
        transform = CATransform3DRotate(transform, x, 1, 0, 0)
        transform = CATransform3DRotate(transform, y, 0, 1, 0)
        transform = CATransform3DRotate(transform, z, 0, 0, 1)
      case .translate(let x, let y, let z):
        transform = CATransform3DTranslate(transform, x, y, z)
      case .spring(let stiffness, let damping):
        self.spring = (stiffness, damping)
      case .zPosition(let zPosition):
        self.zPosition = zPosition
      case .zPositionIfMatched(let zPositionIfMatched):
        self.zPositionIfMatched = zPositionIfMatched
      case .duration(let duration):
        self.duration = duration
      case .timingFunction(let timingFunction):
        self.timingFunction = timingFunction
      case .delay(let delay):
        self.delay = delay
      case .arc(let intensity):
        self.arc = intensity
      case .source(let heroID):
        self.source = heroID
      case .cascade(let delta, let direction):
        self.cascade = (delta, direction)
      case .ignoreSubviewModifiers:
        self.ignoreSubviewModifiers = true
      }
    }
    if transform != CATransform3DIdentity{
      self.transform = transform
    }
  }
  
  /**
   - Returns: custom item for a specific key
   */
  public subscript(key: String) -> Any? {
    get {
      return custom?[key]
    }
    set(newValue) {
      if custom == nil {
        custom = [:]
      }
      custom![key] = newValue
    }
  }
  
  public init(arrayLiteral elements: HeroModifier...) {
    append(contentsOf: elements)
  }
}

extension HeroComposition: ExpressibleByArrayLiteral {
}
