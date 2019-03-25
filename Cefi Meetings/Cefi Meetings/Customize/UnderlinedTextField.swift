

import UIKit

@IBDesignable
class UnderlinedTextField: UITextField {
    
    let red = UIColor(red: 234.0/255.0, green: 36.0/255.0, blue: 37.0/255.0, alpha: 1.0)
    
    @IBInspectable var width: CGFloat = 0.0
    @IBInspectable var color: UIColor = UIColor(red: 234.0/255.0, green: 36.0/255.0, blue: 37.0/255.0, alpha: 0.5)
    @IBInspectable var placeholderColor: UIColor = UIColor.white
    @IBInspectable var icon:UIImage?
    @IBInspectable var iconIndent:Int=0
    @IBInspectable var icony:CGFloat=0
    @IBInspectable var indentation:CGFloat=20
    
    
    
    override func draw(_ rect: CGRect) {
        let underline = CALayer()
        underline.borderColor = color.cgColor
        underline.frame = CGRect(x: 5, y: self.frame.size.height - width , width:  self.frame.size.width, height: self.frame.size.height + 10)
        underline.borderWidth = width
        self.layer.addSublayer(underline)
        self.layer.masksToBounds = true
        
        if(self.attributedPlaceholder?.string != nil){
            let placholderString = NSMutableAttributedString(string: self.attributedPlaceholder!.string, attributes: [NSAttributedString.Key.foregroundColor:placeholderColor])
            self.attributedPlaceholder = placholderString
        }
        
        if(icon != nil){
            if(iconIndent>0){
                let imageView = UIImageView(frame: CGRect(x: 60, y: 10, width: 16, height: 16))
                imageView.center.y=self.icony
                imageView.contentMode=UIView.ContentMode.scaleAspectFit
                imageView.image = icon?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                self.addSubview(imageView)
            }
            else{
                let imageView = UIImageView(frame: CGRect(x: 60, y: 0, width: 16, height: 16))
                imageView.contentMode=UIView.ContentMode.scaleAspectFit
                imageView.image = icon?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                self.leftView = imageView
                self.leftViewMode = UITextField.ViewMode.always
                self.addSubview(imageView)
                imageView.backgroundColor = UIColor.blue
            }
        }
        
    }
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: indentation, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: indentation, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
    
    enum Direction {
        case Left
        case Right
    }
    
    // add image to textfield
    func withImage(direction: Direction, image: UIImage, colorSeparator: UIColor, colorBorder: UIColor){
        let mainView = UIView(frame: CGRect(x: 5, y: 0, width: 50, height: 45))
        mainView.layer.cornerRadius = 5
        
        let view = UIView(frame: CGRect(x: 0, y: 14, width: 30, height: 30))
       // view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.layer.borderWidth = CGFloat(0.5)
        view.layer.borderColor = colorBorder.cgColor
        mainView.addSubview(view)
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 5, y: 0, width: 16.0, height: 16.0)
        view.addSubview(imageView)
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = colorSeparator
        mainView.addSubview(seperatorView)
        
        if(Direction.Left == direction){ // image left
            seperatorView.frame = CGRect(x: 0, y: 0, width: 0, height: 45)
            self.leftViewMode = .always
            self.leftView = mainView
        } else { // image right
            seperatorView.frame = CGRect(x: 0, y: 0, width: 0, height: 45)
            self.rightViewMode = .always
            self.rightView = mainView
        }
        
        self.layer.borderColor = colorBorder.cgColor
        self.layer.borderWidth = CGFloat(0.5)
        self.layer.cornerRadius = 5
    }
    

}
