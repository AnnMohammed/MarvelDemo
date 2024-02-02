//
//  ViewController.swift
//  Rezerva
//
//  Created by Mohamed Nawar on 5/4/19.
//

import UIKit
import CDAlertView

@IBDesignable extension UIView {
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }
    
    
    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 0, height: 3.0),
                   shadowOpacity: Float = 0.2,
                   shadowRadius: CGFloat = 5.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
        
    }
}

extension UIView {
    
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
}
extension UITabBar {
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 90
        return sizeThatFits
    }
}
extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[kCTForegroundColorAttributeName as NSAttributedString.Key: newValue!])
        }
    }
}

extension UIViewController{
    func makeDoneAlert(title: String, SubTitle: String, Image : UIImage) {
        let alert = CDAlertView(title: title, message: SubTitle, type: .notification)
        let doneAction = CDAlertViewAction(title:NSLocalizedString("Done", comment: ""))
        alert.circleFillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        doneAction.buttonTextColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        alert.add(action: doneAction)
        alert.show()
    }
    
    func makeOkAlert(title: String, SubTitle: String, Image : UIImage) {
        let alert = CDAlertView(title: title, message: SubTitle, type: .notification)
        let doneAction = CDAlertViewAction(title:NSLocalizedString("Ok", comment: "") )
        alert.circleFillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        doneAction.buttonTextColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        alert.add(action: doneAction)
        alert.show()
    }
    
    func makeTrueAlert(title: String, SubTitle: String, Image : UIImage) {
        let alert = CDAlertView(title: title, message: SubTitle, type: .success)
        let doneAction = CDAlertViewAction(title: NSLocalizedString("Done", comment: ""))
        alert.circleFillColor = .black
        alert.add(action: doneAction)
        alert.show()
    }
    func checkLoginAlert(title: String, SubTitle: String, Image : UIImage) {
        let alert = CDAlertView(title: title, message: SubTitle, type: .success)
        let logiAction = CDAlertViewAction(title: NSLocalizedString("Login", comment: ""))
        let cancilction = CDAlertViewAction(title: NSLocalizedString("Cancel", comment: ""))
        alert.circleFillColor = .black
        alert.add(action: logiAction)
        alert.add(action: cancilction)
        alert.show()
    }
}

@IBDesignable class RadialGradientView: UIView {

    @IBInspectable var outsideColor: UIColor = UIColor.red
    @IBInspectable var insideColor: UIColor = UIColor.green

    override func awakeFromNib() {
        super.awakeFromNib()

        applyGradient()
    }

    func applyGradient() {
        let colors = [insideColor.cgColor, outsideColor.cgColor] as CFArray
        let endRadius = sqrt(pow(frame.width/2, 2) + pow(frame.height/2, 2))
        let center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
        let context = UIGraphicsGetCurrentContext()

        context?.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: endRadius, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        #if TARGET_INTERFACE_BUILDER
            applyGradient()
        #endif
    }
}

extension UIView {
  func addDashedBorder() {
    let color = UIColor.black.cgColor

    let shapeLayer:CAShapeLayer = CAShapeLayer()
    let frameSize = self.frame.size
    let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

    shapeLayer.bounds = shapeRect
    shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = color
    shapeLayer.lineWidth = 2
    shapeLayer.lineJoin = CAShapeLayerLineJoin.round
    shapeLayer.lineDashPattern = [6,3]
    shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath

    self.layer.addSublayer(shapeLayer)
    }
}
