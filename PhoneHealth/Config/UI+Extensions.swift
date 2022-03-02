//
//  UI+Extensions.swift
//  VenueFinder
//
//  Created by Lizan on 22/12/2021.
//

import UIKit
import MBProgressHUD


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
    
    func setGradientLeftRight(_ startColor: UIColor, endColor: UIColor) {
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.colors = [startColor.cgColor,  endColor.cgColor, 
                                endColor.cgColor]
        gradientLayer.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width + 100, height: self.bounds.height)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setGradientLeftRightNoExtra(_ startColor: UIColor, endColor: UIColor) {
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.colors = [startColor.cgColor,  endColor.cgColor,
                                endColor.cgColor]
        gradientLayer.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addChildViewController(_ childVc: UIViewController, parentViewController parentVc: UIViewController) {
        parentVc.addChild(childVc)
        childVc.didMove(toParent: parentVc)
        childVc.view.frame = self.bounds
        self.addSubview(childVc.view)
    }
}

extension UIImage {
    func png(isOpaque: Bool = true) -> Data? { flattened(isOpaque: isOpaque).pngData() }
    func flattened(isOpaque: Bool = true) -> UIImage {
        if imageOrientation == .up { return self }
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in draw(at: .zero) }
    }
    
    func rotateImage() -> UIImage
        {
            var rotatedImage = UIImage();
            switch self.imageOrientation
            {
            case UIImage.Orientation.right:
                rotatedImage = UIImage(cgImage: self.cgImage!, scale: 1, orientation:UIImage.Orientation.down);
                
            case UIImage.Orientation.down:
                rotatedImage = UIImage(cgImage: self.cgImage!, scale: 1, orientation:UIImage.Orientation.left);
                
            case UIImage.Orientation.left:
                rotatedImage = UIImage(cgImage:self.cgImage!, scale: 1, orientation:UIImage.Orientation.up);
        
                 default:
                rotatedImage = UIImage(cgImage: self.cgImage!, scale: 1, orientation:UIImage.Orientation.right);
            }
            return rotatedImage;
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

struct Associate {
    static var hud: UInt8 = 0
    static var empty: UInt8 = 0
}

extension UIViewController{
    private func setProgressHud() -> MBProgressHUD {
        
        let progressHud:  MBProgressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHud.tintColor = UIColor.darkGray
        progressHud.removeFromSuperViewOnHide = true
        objc_setAssociatedObject(self, &Associate.hud, progressHud, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return progressHud
    }
    
    var progressHud: MBProgressHUD {
        if let progressHud = objc_getAssociatedObject(self, &Associate.hud) as? MBProgressHUD {
            progressHud.isUserInteractionEnabled = true
            return progressHud
        }
        return setProgressHud()
    }
    
    var progressHudIsShowing: Bool {
        return self.progressHud.isHidden
    }
    
    func showProgressHud() {
        self.progressHud.show(animated: false)
    }
    func showMessageHud(_ message: String) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = message
        hud.isUserInteractionEnabled = false
    }
    func hideHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func hideProgressHud() {
        self.progressHud.label.text = ""
        self.progressHud.completionBlock = {
            objc_setAssociatedObject(self, &Associate.hud, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        self.progressHud.hide(animated: false)
    }
    
}
