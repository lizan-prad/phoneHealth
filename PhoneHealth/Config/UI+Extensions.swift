//
//  UI+Extensions.swift
//  VenueFinder
//
//  Created by Lizan on 22/12/2021.
//

import UIKit


extension UIViewController {
    
    class func instantiateFromStoryboard(_ name: String) -> Self {
        return instantiateFromStoryboardHelper(name)
    }
    
    fileprivate class func instantiateFromStoryboardHelper<T>(_ name: String) -> T {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let viewControllerIdentifier = String(describing: self) + StringConstants.controller
        let controller = storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier) as! T
        return controller
    }
    
}

extension UIImageView {
    func setImage(from url: String, completion: (() -> Void)?) {
        
        guard let imageURL = URL(string: url) else { return }
        
        QueueConfig.backgroundQueue.async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                self.image = image
                completion?()
            }
        }
    }
}

extension UIView {
    
    func setStandardCornerRadius() {
        self.layer.cornerRadius = 4
    }
    
    
    func activityStartAnimating(_ activityColor: UIColor? = .white, backgroundColor: UIColor? = .clear) {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = 475647
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.color = activityColor
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
        
        backgroundView.addSubview(activityIndicator)
        
        self.addSubview(backgroundView)
    }
    
    func activityStopAnimating() {
        if let background = viewWithTag(475647) {
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
    
    func addStandardBorder() {
        self.layer.borderColor = UIColor.init(hex: "C0C0C0").cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 4
    }
    
    func addHighlightedBorder() {
        self.layer.borderColor = UIColor.init(hex: "ffffff").cgColor
        self.layer.borderWidth = 2.0
    }
    
    func removeHighlightedBorder() {
        self.layer.borderWidth = 0
    }
    
    func setGradient(_ startColor: UIColor, endColor: UIColor) {
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.colors = [startColor.cgColor, startColor.cgColor, startColor.cgColor, startColor.cgColor, 
                                endColor.cgColor]
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addChildViewController(_ childVc: UIViewController, parentViewController parentVc: UIViewController) {
        parentVc.addChild(childVc)
        childVc.didMove(toParent: parentVc)
        childVc.view.frame = self.bounds
        self.addSubview(childVc.view)
    }
}

extension UIColor {
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1)
    }
    
    convenience init(hex: String, alpha: CGFloat) {
        var hexWithoutSymbol = hex
        if hexWithoutSymbol.hasPrefix("#") {
            hexWithoutSymbol = hex.replacingOccurrences(of: "#", with: "")
        }
        
        let scanner = Scanner(string: hexWithoutSymbol)
        var hexInt: UInt64 = 0x0
        scanner.scanHexInt64(&hexInt)
        
        var red: UInt64!, green: UInt64!, blue: UInt64!
        switch hexWithoutSymbol.count {
        case 3: // #RGB
            red = ((hexInt >> 4) & 0xf0 | (hexInt >> 8) & 0x0f)
            green = ((hexInt >> 0) & 0xf0 | (hexInt >> 4) & 0x0f)
            blue = ((hexInt << 4) & 0xf0 | hexInt & 0x0f)
        case 6: // #RRGGBB
            red = (hexInt >> 16) & 0xff
            green = (hexInt >> 8) & 0xff
            blue = hexInt & 0xff
        default:
            print("Hex error!")
        }
        
        self.init(
            red: (CGFloat(red)/255),
            green: (CGFloat(green)/255),
            blue: (CGFloat(blue)/255),
            alpha: alpha)
    }
    
    func toHexString() -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let rgb: Int = (Int)(red*255)<<16 | (Int)(green*255)<<8 | (Int)(blue*255)<<0
        
        return NSString(format: "#%06x", rgb) as String
    }
}

extension Double {
    
    var inKilometerOrMeter: String  {
        return (self/1000) < 1 ? "\(Int(self))m" : "\(self/1000)km"
    }
}
