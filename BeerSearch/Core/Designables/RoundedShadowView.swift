import UIKit

@IBDesignable
class RoundedShadowView: UIView {
    
    // if cornerRadius variable is set/changed, change the corner radius of the UIView
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
//            layer.cornerRadius = cornerRadius
//            layer.masksToBounds = cornerRadius > 0
            self.changeCorners()
        }
    }
    
    @IBInspectable var onlyTopCorners: Bool = false {
        didSet {
            self.changeCorners()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    func changeCorners(){
        if(cornerRadius > 0 && onlyTopCorners){
        self.roundCorners([.topLeft, .topRight], radius: cornerRadius)
            layer.masksToBounds = true
        }else{
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         layer.mask = mask
    }
    //Necesario actualizar si se usa autolayout
    override func layoutSubviews() {
        super.layoutSubviews()

        self.changeCorners()
    }
    
}

