//
//  HeroModifier.swift
//  HeroExamples
//
//  Created by YiLun Zhao on 2017-01-05.
//  Copyright © 2017 Luke Zhao. All rights reserved.
//

import UIKit

public enum HeroModifier{
  case fade
  case position(CGPoint)
  case size(CGSize)
  case perspective(CGFloat)
  case scale(x:CGFloat, y:CGFloat, z:CGFloat)
  case rotate(x:CGFloat, y:CGFloat, z:CGFloat)
  case translate(x:CGFloat, y:CGFloat, z:CGFloat)
  case transform(CATransform3D)
  case spring(stiffness:CGFloat, damping:CGFloat)
  case zPosition(CGFloat)
  case zPositionIfMatched(CGFloat)
  case duration(TimeInterval)
  case delay(TimeInterval)
  case timingFunction(CAMediaTimingFunction)
  case cascade(delta:TimeInterval, direction:CascadePreprocessor.CascadeDirection)
  case arc(intensity:CGFloat)
  case source(heroID:String)
  case ignoreSubviewModifiers
  
  init?(name:String, parameters:[String]){
    var modifier:HeroModifier?
    switch name {
    case "fade":
      modifier = .fade
    case "position":
      modifier = .position(CGPoint(x: parameters.getCGFloat(0) ?? 0, y: parameters.getCGFloat(1) ?? 0))
    case "size":
      modifier = .size(CGSize(width: parameters.getCGFloat(0) ?? 0, height: parameters.getCGFloat(1) ?? 0))
    case "scale":
      if parameters.count == 1 {
        modifier = .scale(x: parameters.getCGFloat(0) ?? 1, y: parameters.getCGFloat(0) ?? 1, z: 1)
      } else {
        modifier = .scale(x: parameters.getCGFloat(0) ?? 1,
                      y: parameters.getCGFloat(1) ?? 1,
                      z: parameters.getCGFloat(2) ?? 1)
      }
    case "rotate":
      if parameters.count == 1 {
        modifier = .rotate(x: 0, y: 0, z: parameters.getCGFloat(0) ?? 0)
      } else {
        modifier = .rotate(x: parameters.getCGFloat(0) ?? 0,
                           y: parameters.getCGFloat(1) ?? 0,
                           z: parameters.getCGFloat(2) ?? 0)
      }
    case "translate":
      modifier = .translate(x: parameters.getCGFloat(0) ?? 0,
                            y: parameters.getCGFloat(1) ?? 0,
                            z: parameters.getCGFloat(2) ?? 0)
    case "zPosition":
      if let zPosition = parameters.getCGFloat(0){
        modifier = .zPosition(zPosition)
      }
    case "duration":
      if let duration = parameters.getDouble(0){
        modifier = .duration(duration)
      }
    case "delay":
      if let delay = parameters.getDouble(0){
        modifier = .delay(delay)
      }
    case "spring":
      modifier = .spring(stiffness: parameters.getCGFloat(0) ?? 250, damping: parameters.getCGFloat(1) ?? 30)
    case "timingFunction":
      if let c1 = parameters.getFloat(0),
        let c2 = parameters.getFloat(1),
        let c3 = parameters.getFloat(2),
        let c4 = parameters.getFloat(3){
        modifier = .timingFunction(CAMediaTimingFunction(controlPoints: c1, c2, c3, c4))
      } else if let name = parameters.get(0), let timingFunction = CAMediaTimingFunction.from(name:name){
        modifier = .timingFunction(timingFunction)
      }
    case "arc":
      modifier = .arc(intensity: parameters.getCGFloat(0) ?? 1)
    case "cascade":
      var cascadeDirection = CascadePreprocessor.CascadeDirection.topToBottom
      if let directionString = parameters.get(1),
         let direction = CascadePreprocessor.CascadeDirection(directionString) {
        cascadeDirection = direction
      }
      modifier = .cascade(delta: parameters.getDouble(0) ?? 0.02, direction: cascadeDirection)
    case "sourceID":
      if let heroID = parameters.get(0){
        modifier = .source(heroID: heroID)
      }
    case "ignoreSubviewModifiers":
      modifier = .ignoreSubviewModifiers
    case "zPosition":
      if let zPosition = parameters.getCGFloat(0){
        modifier = .zPosition(zPosition)
      }
    case "zPositionIfMatched":
      if let zPosition = parameters.getCGFloat(0){
        modifier = .zPositionIfMatched(zPosition)
      }
    default: break
    }
    if let modifier = modifier{
      self = modifier
    } else {
      return nil
    }
  }
}
