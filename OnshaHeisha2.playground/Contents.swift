//: Playground - noun: a place where people can play

import Cocoa

func BezierPolygon(numberOfSizes: UInt) -> NSBezierPath {
    let path = NSBezierPath()
    let length: CGFloat = 20.0
    let center = CGPointMake(length, length)
    let radius: CGFloat = length
    var firstPoint = true
    for i in 0..<(numberOfSizes - 1) {
        let theta = M_PI + Double(i) * 2.0 * M_PI / Double(numberOfSizes)
        let dTheta = 2.0 * M_PI / Double(numberOfSizes)
        
        var p = CGPointZero
        if firstPoint {
            p.x = center.x + radius * CGFloat(cos(theta))
            p.y = center.y + radius * CGFloat(sin(theta))
            path.moveToPoint(p)
            firstPoint = false
        }
        
        p.x = center.x + radius * CGFloat( cos(theta + dTheta) )
        p.y = center.y + radius * CGFloat( sin(theta + dTheta) )
        path.lineToPoint(p)
    }
    path.closePath()
    
    path.bounds
    
    return path
}

class Polygon: NSObject {
    func _BezierPolygon(numberOfSizes: UInt) -> NSBezierPath {
        return BezierPolygon(numberOfSizes)
    }
    
    var sides: UInt {
        didSet {
            sides = max(sides, 3)
            sides = min(sides, 10)
        }
    }
    
    init (_ sides: UInt = 3) {
        self.sides = sides
    }
    
    func debugQuickLookObject() -> AnyObject? {
        return _BezierPolygon(sides)
    }
}

Polygon(5)
