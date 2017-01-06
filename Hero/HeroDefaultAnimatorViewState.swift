// The MIT License (MIT)
//
// Copyright (c) 2016 Luke Zhao <me@lkzhao.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

// CALayer keyPath map to NSValue for animation
func viewState(for view:UIView, with composition:HeroComposition) -> [String:Any]{
  var rtn = [String:Any]()
  
  if let size = composition.size{
    rtn["bounds.size"] = NSValue(cgSize:size)
  }
  if let position = composition.position{
    rtn["position"] = NSValue(cgPoint:position)
  }
  if let opacity = composition.opacity{
    rtn["opacity"] = NSNumber(value: opacity.native)
  }
  if let cornerRadius = composition.cornerRadius{
    rtn["cornerRadius"] = NSNumber(value: cornerRadius.native)
  }
  if let transform = composition.transform{
    rtn["transform"] = NSValue(caTransform3D:transform)
  }
  return rtn
}
