//
//  UIViewExtensions.swift

#if os(iOS) || os(tvOS)
import UIKit
import MapKit
// MARK: - enums

public enum ShakeDirection {
	case horizontal
	case vertical
}

public enum AngleUnit {
	case degrees
	case radians
}

public enum ShakeAnimationType {
	case linear
	case easeIn
	case easeOut
	case easeInOut
}
let backgroundView = UIView(frame: UIScreen.main.bounds)

// MARK: - Properties
public extension UIView {
	
    @IBInspectable var borderColor: UIColor? {
		get {
			guard let color = layer.borderColor else {
				return nil
			}
			return UIColor(cgColor: color)
		}
		set {
			guard let color = newValue else {
				layer.borderColor = nil
				return
			}
			layer.borderColor = color.cgColor
		}
	}
	
    @IBInspectable var borderWidth: CGFloat {
		get {
			return layer.borderWidth
		}
		set {
			layer.borderWidth = newValue
		}
	}
    @IBInspectable var cornerRadius: CGFloat {
		get {
			return layer.cornerRadius
		}
		set {
			layer.masksToBounds = true
			layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
		}
	}
    var firstResponder: UIView? {
		guard !isFirstResponder else {
			return self
		}
		for subView in subviews where subView.isFirstResponder {
			return subView
		}
		return nil
	}
	
    var height: CGFloat {
		get {
			return frame.size.height
		}
		set {
			frame.size.height = newValue
		}
	}
	
    var isRightToLeft: Bool {
		if #available(iOS 10.0, *, tvOS 10.0, *) {
			return effectiveUserInterfaceLayoutDirection == .rightToLeft
		} else {
			return false
		}
	}
	
    var screenshot: UIImage? {
		UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
		defer {
			UIGraphicsEndImageContext()
		}
		guard let context = UIGraphicsGetCurrentContext() else {
			return nil
		}
		layer.render(in: context)
		return UIGraphicsGetImageFromCurrentImageContext()
	}
	
    @IBInspectable var shadowColor: UIColor? {
		get {
			guard let color = layer.shadowColor else {
				return nil
			}
			return UIColor(cgColor: color)
		}
		set {
			layer.shadowColor = newValue?.cgColor
		}
	}
    @IBInspectable var shadowOffset: CGSize {
		get {
			return layer.shadowOffset
		}
		set {
			layer.shadowOffset = newValue
		}
	}
    @IBInspectable var shadowOpacity: Float {
		get {
			return layer.shadowOpacity
		}
		set {
			layer.shadowOpacity = newValue
		}
	}
    @IBInspectable var shadowRadius: CGFloat {
		get {
			return layer.shadowRadius
		}
		set {
			layer.shadowRadius = newValue
		}
	}
    var size: CGSize {
		get {
			return frame.size
		}
		set {
			width = newValue.width
			height = newValue.height
		}
	}
    var parentViewController: UIViewController? {
		weak var parentResponder: UIResponder? = self
		while parentResponder != nil {
			parentResponder = parentResponder!.next
			if let viewController = parentResponder as? UIViewController {
				return viewController
			}
		}
		return nil
	}
    var width: CGFloat {
		get {
			return frame.size.width
		}
		set {
			frame.size.width = newValue
		}
	}
    var x: CGFloat {
		get {
			return frame.origin.x
		}
		set {
			frame.origin.x = newValue
		}
	}
	
    var y: CGFloat {
		get {
			return frame.origin.y
		}
		set {
			frame.origin.y = newValue
		}
	}
	
}
// MARK: - Methods
public extension UIView {
    func takeScreenshot() -> UIImage {
        
        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        
        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if (image != nil)
        {
            return image!
        }
        return UIImage()
    }
    func shake(count : Float = 4,for duration : TimeInterval = 0.3,withTranslation translation : Float = -5) {
        
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.byValue = translation
        layer.add(animation, forKey: "shake")
    }
    
    func addTapGestureToView()
    {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap(sender: UITapGestureRecognizer)
    {
        self.endEditing(true)
    }
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
		let maskPath = UIBezierPath(roundedRect: bounds,
									byRoundingCorners: corners,
									cornerRadii: CGSize(width: radius, height: radius))
		let shape = CAShapeLayer()
		shape.path = maskPath.cgPath
		layer.mask = shape
	}
    func addShadow(ofColor color: UIColor = UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0), radius: CGFloat = 3, offset: CGSize = .zero, opacity: Float = 0.5) {
		layer.shadowColor = color.cgColor
		layer.shadowOffset = offset
		layer.shadowRadius = radius
		layer.shadowOpacity = opacity
		layer.masksToBounds = true
	}
    func addSubviews(_ subviews: [UIView]) {
		subviews.forEach({self.addSubview($0)})
	}
	
    func fadeIn(duration: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
		if isHidden {
			isHidden = false
		}
		UIView.animate(withDuration: duration, animations: {
			self.alpha = 1
		}, completion: completion)
	}
    func fadeOut(duration: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
		if isHidden {
			isHidden = false
		}
		UIView.animate(withDuration: duration, animations: {
			self.alpha = 0
		}, completion: completion)
	}
	
    class  func loadNibAtIndex(named name: String, bundle: Bundle? = nil,index:Int) -> UIView {
        return (UINib(nibName: name, bundle: bundle).instantiate(withOwner: nil, options: nil)[index] as? UIView)!
    }
    class func loadFromNib(named name: String, bundle: Bundle? = nil) -> UIView? {
		return UINib(nibName: name, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView
	}
	
    func removeSubviews() {
		subviews.forEach({$0.removeFromSuperview()})
	}
	
    func removeGestureRecognizers() {
		gestureRecognizers?.forEach(removeGestureRecognizer)
	}

    func rotate(byAngle angle: CGFloat, ofType type: AngleUnit, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
		let angleWithType = (type == .degrees) ? CGFloat.pi * angle / 180.0 : angle
		let aDuration = animated ? duration : 0
		UIView.animate(withDuration: aDuration, delay: 0, options: .curveLinear, animations: { () -> Void in
			self.transform = self.transform.rotated(by: angleWithType)
		}, completion: completion)
	}

    func rotate(toAngle angle: CGFloat, ofType type: AngleUnit, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
		let angleWithType = (type == .degrees) ? CGFloat.pi * angle / 180.0 : angle
		let aDuration = animated ? duration : 0
		UIView.animate(withDuration: aDuration, animations: {
			self.transform = self.transform.concatenating(CGAffineTransform(rotationAngle: angleWithType))
		}, completion: completion)
	}
    func zoomIn()
    {
        if self.isHidden
        {self.isHidden = false}
        self.alpha = 0
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            self.alpha = 1
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: {(_ finished: Bool) -> Void in
        })
    }
    func zoomOut()
    {
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }, completion: {(_ finished: Bool) -> Void in
            self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        })
    }
    func scale(by offset: CGPoint, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
		if animated {
			UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { () -> Void in
				self.transform = self.transform.scaledBy(x: offset.x, y: offset.y)
			}, completion: completion)
		} else {
			transform = transform.scaledBy(x: offset.x, y: offset.y)
			completion?(true)
		}
	}
   
    func animateview(vw1 : UIView,vw2:UIView)
    {
        UIView.animate(withDuration: 0.1,
                       delay: 0.1,
                       options: UIView.AnimationOptions.curveEaseIn,
                       animations: { () -> Void in
                        vw1.alpha = 0;
                        vw2.alpha = 1;
        }, completion: { (finished) -> Void in
            vw1.isHidden = true;
        })
    }
    func createBlurBackground()
    {
       backgroundView.backgroundColor = UIColor(white: 0.0, alpha: 0.6)
        self.addSubview(backgroundView)
    }
    func viewDropFromRight(Toview:UIView)
    {
       self.addSubview(Toview)
        Toview.center = self.center
       Toview.frame.origin.x = UIScreen.main.bounds.size.width
        UIView.animate(withDuration: 0.3, animations: {
            Toview.frame.origin.x = 0
        }, completion: { (done) in
        })
        
    }
    func viewDropFromRightWithoutAddingSubview(Toview:UIView)
    {
        Toview.isHidden = false
        Toview.frame.origin.x = UIScreen.main.bounds.size.width
        UIView.animate(withDuration: 0.2, animations: {
            Toview.frame.origin.x = 0
        }, completion: { (done) in
        })
    }
    func viewDismissFromLeftWithoutAddingSubview(Toview:UIView)
    {
        UIView.animate(withDuration: 0.2, animations: {
           Toview.frame.origin.x = -UIScreen.main.bounds.size.width
        }, completion: { (done) in
            Toview.isHidden = true
        })
    }
    func viewDismissFromLeft()
    {
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.origin.x = -UIScreen.main.bounds.size.width
        }, completion: { (done) in
            self.removeFromSuperview()
        })
    }
    func viewDropFromTop(Toview:UIView)
    {
        self.createBlurBackground()
        backgroundView.alpha = 0
        self.addSubview(Toview)
        Toview.center.x = self.center.x
        Toview.frame.origin.y = -UIScreen.main.bounds.size.height
        UIView.animate(withDuration: 0.3, animations: {
            backgroundView.alpha = 1
             Toview.center = CGPoint.init(x: self.center.x, y: self.center.y + 10)
        }, completion: { (done) in
            
            UIView.animate(withDuration: 0.2, animations:
                {
                    Toview.center = self.center
            }, completion: { (bool) in
            })
        })
    }
    func viewDismissFromBottom()
    {
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.origin.y = UIScreen.main.bounds.size.height
        }, completion: { (done) in
            backgroundView.removeFromSuperview()
            self.removeFromSuperview()
        })
    }
    func viewDismiss()
    {
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.origin.y = CGFloat((self.accessibilityValue! as NSString).floatValue)
                //(self.accessibilityValue?.cgFloat())!
        }, completion: { (done) in
            self.isHidden = true
        })
    }
    func viewSlideIn()
    {
        self.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.origin.y = CGFloat((self.accessibilityValue! as NSString).floatValue)
        }, completion: { (done) in
        })
    }
    func viewSlideInFromBottom(toTop views: UIView)
    {
        let transition = CATransition()
        transition.duration = 0.8
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        views.layer.add(transition, forKey: nil)
    }
    func viewSlideInFromTop(toBottom views: UIView)
    {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom
        views.layer.add(transition, forKey: nil)
    }
	public func shake(direction: ShakeDirection = .horizontal, duration: TimeInterval = 1, animationType: ShakeAnimationType = .easeOut, completion:(() -> Void)? = nil) {
		
		CATransaction.begin()
		let animation: CAKeyframeAnimation
		switch direction {
		case .horizontal:
			animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
		case .vertical:
			animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
		}
		switch animationType {
		case .linear:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
		case .easeIn:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
		case .easeOut:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
		case .easeInOut:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
		}
		CATransaction.setCompletionBlock(completion)
		animation.duration = duration
		animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
		layer.add(animation, forKey: "shake")
		CATransaction.commit()
	}
	
	@available(iOS 9, *) public func addConstraints(withFormat: String, views: UIView...) {
		// https://videos.letsbuildthatapp.com/
		var viewsDictionary: [String: UIView] = [:]
		for (index, view) in views.enumerated() {
			let key = "v\(index)"
			view.translatesAutoresizingMaskIntoConstraints = false
			viewsDictionary[key] = view
		}
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: withFormat, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
	}
	
	/// SwifterSwift: Anchor all sides of the view into it's superview.
	@available(iOS 9, *) public func fillToSuperview() {
		// https://videos.letsbuildthatapp.com/
		translatesAutoresizingMaskIntoConstraints = false
		if let superview = superview {
			leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
			rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
			topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
			bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
		}
	}
	
    @available(iOS 9, *) @discardableResult func anchor(
		top: NSLayoutYAxisAnchor? = nil,
		left: NSLayoutXAxisAnchor? = nil,
		bottom: NSLayoutYAxisAnchor? = nil,
		right: NSLayoutXAxisAnchor? = nil,
		topConstant: CGFloat = 0,
		leftConstant: CGFloat = 0,
		bottomConstant: CGFloat = 0,
		rightConstant: CGFloat = 0,
		widthConstant: CGFloat = 0,
		heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
		// https://videos.letsbuildthatapp.com/
		translatesAutoresizingMaskIntoConstraints = false
		
		var anchors = [NSLayoutConstraint]()
		
		if let top = top {
			anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
		}
		
		if let left = left {
			anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
		}
		
		if let bottom = bottom {
			anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
		}
		
		if let right = right {
			anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
		}
		
		if widthConstant > 0 {
			anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
		}
		
		if heightConstant > 0 {
			anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
		}
		
		anchors.forEach({$0.isActive = true})
		
		return anchors
	}

    @available(iOS 9, *) func anchorCenterXToSuperview(constant: CGFloat = 0) {
		translatesAutoresizingMaskIntoConstraints = false
		if let anchor = superview?.centerXAnchor {
			centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
		}
	}

    @available(iOS 9, *) func anchorCenterYToSuperview(constant: CGFloat = 0) {
		translatesAutoresizingMaskIntoConstraints = false
		if let anchor = superview?.centerYAnchor {
			centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
		}
	}
	

    @available(iOS 9, *) func anchorCenterSuperview() {
		anchorCenterXToSuperview()
		anchorCenterYToSuperview()
	}
   
    func setViewBottomBorder(borderColor: UIColor)
    {
        self.backgroundColor = UIColor.clear
        let width = 0.5
        
        let borderLine = UIView()
        borderLine.removeFromSuperview()
        borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - width, width: Double(self.frame.width), height: width)
        borderLine.tag = 99999;
        borderLine.backgroundColor = borderColor
        for v in self.subviews
        {
            if v.tag == 99999
            {
                v.removeFromSuperview()
            }
        }
        self.addSubview(borderLine)
    }
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    func addTapGesture(tapNumber : Int, target: Any , action : Selector) {
        
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    func dropShadow(scale: Bool = true)
    {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 0.4
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    
    func rotateWithLimit(duration: Double = 1)
    {
        if layer.animation(forKey: "rotationanimationkey") == nil
        {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = 10
            layer.add(rotationAnimation, forKey: "rotationanimationkey")
        }
    }
    
    func shadowAccordingRadius()
    {
        var shadowLayer: CAShapeLayer!
        if shadowLayer == nil
        {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.frame.size.height/2).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor
            
            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            shadowLayer.shadowOpacity = 0.4
            shadowLayer.shadowRadius = 2
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    func keepCenterAndApplyAnchorPoint(_ point: CGPoint) {
        
        guard layer.anchorPoint != point else { return }
        
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)
        
        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)
        
        var c = layer.position
        c.x -= oldPoint.x
        c.x += newPoint.x
        
        c.y -= oldPoint.y
        c.y += newPoint.y
        
        layer.position = c
        layer.anchorPoint = point
    }
}
#endif
public extension MKMapView
{
        func fitAll() {
            var zoomRect            = MKMapRect.null;
            for annotation in annotations {
                let annotationPoint = MKMapPoint(annotation.coordinate)
                let pointRect       = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.01, height: 0.01);
                zoomRect            = zoomRect.union(pointRect);
            }
            setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
        }
    
        func fitAll(in annotations: [MKAnnotation], andShow show: Bool) {
            var zoomRect:MKMapRect  = MKMapRect.null
            
            for annotation in annotations
            {
                let aPoint          = MKMapPoint(annotation.coordinate)
                let rect            = MKMapRect(x: aPoint.x, y: aPoint.y, width: 0.1, height: 0.1)
                zoomRect = zoomRect.union(rect)
            }
            if(show) {
                addAnnotations(annotations)
            }
            setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
        }    
}



extension UIScrollView
{
    func setContentViewSize(offset:CGFloat = 0.0) {
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
        var maxHeight : CGFloat = 0
        for view in subviews {
            if view.isHidden {
                continue
            }
            let newHeight = view.frame.origin.y + view.frame.height
            if newHeight > maxHeight {
                maxHeight = newHeight
            }
        }
        // set content size
        contentSize = CGSize(width: contentSize.width, height: maxHeight + offset)
        // show scroll indicators
        showsHorizontalScrollIndicator = true
        showsVerticalScrollIndicator = true
    }
}
extension UIView
{
    func copyView<T: UIView>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }
    func addHeight(_ height: CGFloat) {
        self.frame = CGRect(origin: self.frame.origin, size: CGSize(width: self.frame.width, height: self.frame.height + height))
    }
}

extension UIView.KeyframeAnimationOptions {
    
    static var curveEaseIn: UIView.KeyframeAnimationOptions {
        get {
            return UIView.KeyframeAnimationOptions(animationOptions: .curveEaseIn)
        }
    }
    
    static var curveEaseOut: UIView.KeyframeAnimationOptions {
        get {
            return UIView.KeyframeAnimationOptions(animationOptions: .curveEaseOut)
        }
    }
    
    static var curveEaseInOut: UIView.KeyframeAnimationOptions {
        get {
            return UIView.KeyframeAnimationOptions(animationOptions: .curveEaseInOut)
        }
    }
    
    static var curveLinear: UIView.KeyframeAnimationOptions {
        get {
            return UIView.KeyframeAnimationOptions(animationOptions: .curveLinear)
        }
    }
    
    init(animationOptions: UIView.AnimationOptions) {
        self.init(rawValue: animationOptions.rawValue)
    }
}
extension UIView {
    
    // Transform a view's shape into circle
    func asCircle() {
        self.layer.cornerRadius = self.frame.width / 2;
        self.layer.masksToBounds = true
    }
    
    func setTintColor(_ color: UIColor, recursive: Bool) {
        tintColor = color
        if recursive {
            subviews.forEach({$0.setTintColor(color, recursive: true)})
        }
    }
}
extension CGRect {
    var center: CGPoint {
        get {
            return CGPoint(x: midX, y: midY)
        }
    }
}
extension UIView {
    
    private struct AssociatedKeys {
        static var descriptiveName = "AssociatedKeys.DescriptiveName.blurView"
    }
    
    private (set) var blurView: BlurView {
        get {
            if let blurView = objc_getAssociatedObject(
                self,
                &AssociatedKeys.descriptiveName
                ) as? BlurView {
                return blurView
            }
            self.blurView = BlurView(to: self)
            return self.blurView
        }
        set(blurView) {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.descriptiveName,
                blurView,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    class BlurView {
        
        private var superview: UIView
        private var blur: UIVisualEffectView?
        private var editing: Bool = false
        private (set) var blurContentView: UIView?
        private (set) var vibrancyContentView: UIView?
        
        var animationDuration: TimeInterval = 0.1
        
        /**
         * Blur style. After it is changed all subviews on
         * blurContentView & vibrancyContentView will be deleted.
         */
        var style: UIBlurEffect.Style = .light {
            didSet {
                guard oldValue != style,
                    !editing else { return }
                applyBlurEffect()
            }
        }
        /**
         * Alpha component of view. It can be changed freely.
         */
        var alpha: CGFloat = 0 {
            didSet {
                guard !editing else { return }
                if blur == nil {
                    applyBlurEffect()
                }
                let alpha = self.alpha
                UIView.animate(withDuration: animationDuration) {
                    self.blur?.alpha = alpha
                }
            }
        }
        
        init(to view: UIView) {
            self.superview = view
        }
        
        func removeBlur()
        {
            self.blur?.removeFromSuperview()
            self.blur?.alpha = 0
            self.blur?.isHidden = true
        }
        func setup(style: UIBlurEffect.Style, alpha: CGFloat) -> Self {
            self.editing = true
            
            self.style = style
            self.alpha = alpha
            
            self.editing = false
            
            return self
        }
        
        func enable(isHidden: Bool = false) {
            if blur == nil {
                applyBlurEffect()
            }
            
            self.blur?.isHidden = isHidden
        }
        
        private func applyBlurEffect() {
            blur?.removeFromSuperview()
            
            applyBlurEffect(
                style: style,
                blurAlpha: alpha
            )
        }
        
        private func applyBlurEffect(style: UIBlurEffect.Style,
                                     blurAlpha: CGFloat) {
            superview.backgroundColor = UIColor.clear
            
            let blurEffect = UIBlurEffect(style: style)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            
            let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
            let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
            blurEffectView.contentView.addSubview(vibrancyView)
            
            blurEffectView.alpha = blurAlpha
            
            superview.insertSubview(blurEffectView, at: 0)
            
            blurEffectView.addAlignedConstrains()
            vibrancyView.addAlignedConstrains()
            
            self.blur = blurEffectView
            self.blurContentView = blurEffectView.contentView
            self.vibrancyContentView = vibrancyView.contentView
        }
    }
    
    private func addAlignedConstrains() {
        translatesAutoresizingMaskIntoConstraints = false
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.top)
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.leading)
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.trailing)
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.bottom)
    }
    
    private func addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute) {
        superview?.addConstraint(
            NSLayoutConstraint(
                item: self,
                attribute: attribute,
                relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: superview,
                attribute: attribute,
                multiplier: 1,
                constant: 0
            )
        )
    }
}

public extension UIColor {
    static func fromHex(hexString: String) -> UIColor {
        let hex = hexString.trimmingCharacters(
            in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return UIColor.clear
        }
        
        return UIColor(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255,
            alpha: CGFloat(a) / 255)
    }
}
extension Sequence
{
    func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
        return Dictionary.init(grouping: self, by: key)
    }
}

extension UINavigationController {
    
    func backToViewController(viewController: Swift.AnyClass) {
        
        for element in viewControllers as Array {
            if element.isKind(of: viewController) {
                self.popToViewController(element, animated: true)
                break
            }
        }
    }
}

extension UIImagePickerController
{
    func changePickerTopBarColor(_ tintcolorname:UIColor, _ bartintcolorname:UIColor, _ textcolorname:UIColor)
    {
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = bartintcolorname
        self.navigationBar.tintColor = tintcolorname
        self.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : textcolorname
        ]
    }
}

extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
            
        case UIRectEdge.bottom:
            border.frame = CGRect(x:0, y: frame.height - thickness, width: frame.width, height:thickness)
            
        case UIRectEdge.left:
            border.frame = CGRect(x:0, y:0, width: thickness, height: frame.height)
            
        case UIRectEdge.right:
            border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
            
        default: do {}
        }
        
        border.backgroundColor = color.cgColor
        
        addSublayer(border)
    }
    
    
    
}
extension UIView
{
    @discardableResult
    func addBorders(edges: UIRectEdge,
                    color: UIColor,
                    inset: CGFloat = 0.0,
                    thickness: CGFloat = 1.0) -> [UIView] {
        
        var borders = [UIView]()
        
        @discardableResult
        func addBorder(formats: String...) -> UIView {
            let border = UIView(frame: .zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            addSubview(border)
            addConstraints(formats.flatMap {
                NSLayoutConstraint.constraints(withVisualFormat: $0,
                                               options: [],
                                               metrics: ["inset": inset, "thickness": thickness],
                                               views: ["border": border]) })
            borders.append(border)
            return border
        }
        
        
        if edges.contains(.top) || edges.contains(.all) {
            addBorder(formats: "V:|-0-[border(==thickness)]", "H:|-inset-[border]-inset-|")
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(formats: "V:[border(==thickness)]-0-|", "H:|-inset-[border]-inset-|")
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:|-0-[border(==thickness)]")
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:[border(==thickness)]-0-|")
        }
        
        return borders
    }
}
extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 0.6)
    }
    
    static var red: UIColor {
        return UIColor(red: 255, green: 59, blue: 48)
    }
    
    static var orange: UIColor {
        return UIColor(red: 255, green: 149, blue: 0)
    }
    
    static var yellow: UIColor {
        return UIColor(red: 255, green: 204, blue: 0)
    }
    
    static var green: UIColor {
        return UIColor(red: 76, green: 217, blue: 100)
    }
    
    static var tealBlue: UIColor {
        return UIColor(red: 90, green: 200, blue: 250)
    }
    
    static var blue: UIColor {
        return UIColor(red: 0, green: 122, blue: 255)
    }
    
    static var purple: UIColor {
        return UIColor(red: 88, green: 86, blue: 214)
    }
    
    static var pink: UIColor {
        return UIColor(red: 255, green: 45, blue: 85)
    }
    
    static let colors: [UIColor] = [.red, .orange, .yellow, .green, .tealBlue, .blue, .purple, .pink]
    
}
