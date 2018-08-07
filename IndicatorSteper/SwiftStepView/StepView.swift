//
//  StepView.swift
//  IndicatorSteper
//
//  Created by Soemsak on 7/8/2561 BE.
//  Copyright © 2561 Soemsak. All rights reserved.
//

import UIKit

@IBDesignable
public class StepView: UIView {
    @IBInspectable public var numberOfSteps: Int = 3 { didSet { setNeedsDisplay() } }
    @IBInspectable public var currentStep: Int = 1 {
        didSet {
            if (currentStep < 1) { currentStep = 1; return }
            if (currentStep > numberOfSteps) { currentStep = numberOfSteps; return }
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var lineWidth: CGFloat = 4 { didSet { setNeedsDisplay() } }
    
    @IBInspectable public var normalColor: UIColor = .lightGray { didSet { setNeedsDisplay() } }
    @IBInspectable public var highlightColor: UIColor = .blue { didSet { setNeedsDisplay() } }
    @IBInspectable public var normalTextColor: UIColor = .darkGray { didSet { setNeedsDisplay() } }
    @IBInspectable public var highlightTextColor: UIColor = .black { didSet { setNeedsDisplay() } }
    @IBInspectable public var fontSize: CGFloat = 14.0 { didSet { setNeedsDisplay() } }
    
    // MARK: - Drawing
    private var pointRaidus: CGFloat { return pointDiameter / 2 }
    private var pointDiameter: CGFloat { return bounds.size.height - 50 }
    private var halfOfHeight: CGFloat { return bounds.size.height / 2 }
    
    private var lineLength: CGFloat {
        return (bounds.size.width - CGFloat(numberOfSteps)*pointDiameter - CGFloat(numberOfSteps-1)) / CGFloat(numberOfSteps - 1)
    }
    
    public override func draw(_ rect: CGRect) {
        drawPointsWith(count: numberOfSteps, color: normalColor)
        drawLinesWith(count: numberOfSteps, color: normalColor)
        
        drawPointsWith(count: currentStep, color: highlightColor)
        drawLinesWith(count: currentStep, color: highlightColor, isDoing: true)
        
        drawTexts()
    }
    
    private func drawPointsWith(count: Int, color: UIColor) {
        let path = UIBezierPath()
        
        // draw points
        for i in 0 ..< count {
            var point: CGPoint = .zero
            point.x = pointRaidus + (lineLength + pointDiameter) * CGFloat(i)
            point.y = halfOfHeight
            
            path.addArc(withCenter: point, radius: pointRaidus, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
        }
        
        color.setStroke()
        color.setFill()
        
        path.fill()
    }
    
    private func drawLinesWith(count: Int, color: UIColor, isDoing: Bool = false) {
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        path.lineCapStyle = .round
        
        // draw line
        for i in 0 ..< (count - 1) {
            let start = CGPoint(x: (pointDiameter) + (lineLength + pointDiameter) * CGFloat(i), y: halfOfHeight)
            let end = CGPoint(x: start.x + lineLength, y: halfOfHeight)
            
            path.move(to: start)
            path.addLine(to: end)
        }
        
        color.setStroke()
        color.setFill()
        
        path.stroke()
    }
    
    private func drawTexts() {
        let textFont = UIFont.systemFont(ofSize: fontSize)
        for i in 0 ..< currentStep {
            let text = "\(i+1)"
            if i == currentStep - 1 {
                print("item", text)
            }
            let point: CGPoint = CGPoint(x: pointRaidus + (lineLength + pointDiameter) * CGFloat(i), y: halfOfHeight)
            let size = text.size(inFont: textFont)
            let rect = CGRect(x: point.x - size.width / 2, y: point.y - size.height / 2, width: size.width, height: size.height)
            drawText(text, inRect: rect, withFont: textFont, withColor: highlightTextColor, alignment: .center)
            
            let text2 = "Text"
            let size2 = text2.size(inFont: textFont)
            let rect2 = CGRect(x: point.x - size2.width / 2, y: (point.y - size2.height / 2) + 40, width: size2.width, height: size2.height)
            drawText(text2, inRect: rect2, withFont: textFont, withColor: UIColor.red, alignment: .center)
        }
        
        for i in currentStep ..< numberOfSteps {
            let text = "\(i+1)"
            let point: CGPoint = CGPoint(x: pointRaidus + (lineLength + pointDiameter) * CGFloat(i), y: halfOfHeight)
            let size = text.size(inFont: textFont)
            let rect = CGRect(x: point.x - size.width / 2, y: point.y - size.height / 2, width: size.width, height: size.height)
            drawText(text, inRect: rect, withFont: textFont, withColor: normalTextColor, alignment: .center)
        }
    }
    
    private func drawText(_ text: String, inRect rect: CGRect, withFont font: UIFont, withColor color: UIColor, alignment: NSTextAlignment) {
        let paragrahStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragrahStyle.lineBreakMode = .byTruncatingTail
        paragrahStyle.alignment = alignment
        (text as NSString).draw(in: rect, withAttributes: [.paragraphStyle: paragrahStyle, .font: font, .foregroundColor: color])
    }
}

extension String {
    func size(inFont font: UIFont) -> CGSize {
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let rect = (self as NSString).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return rect.size
    }
}

