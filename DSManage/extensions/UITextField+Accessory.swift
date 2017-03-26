import UIKit

private var nextTextFieldKey: UInt8 = 0

extension UITextField {
    
   private var nextTextField: UITextField! {
        get {
            return objc_getAssociatedObject(self, &nextTextFieldKey) as? UITextField
        }
        set {
            objc_setAssociatedObject(self, &nextTextFieldKey, newValue, objc_AssociationPolicy(rawValue:1)!)
        }
    }
    
    func setAccessoryBar(with nextTextField: UITextField?) {
        
        self.nextTextField = nextTextField
        self.inputAccessoryView = createToolbar()
    }
    
    @objc private func doneBarButtonItemTouched() {
        
        if self.nextTextField == nil {
            self.resignFirstResponder()
            
        } else {
            self.nextTextField.becomeFirstResponder()
        }
    }
    
    private func createToolbar() -> UIView {
        
        let toolbar = UIToolbar()
        let rect = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: UIScreen.main.bounds.size.width, height: 44)
        toolbar.frame = rect
        toolbar.backgroundColor = .white
        
        let title:UILabel = self.setLabel(withTitle: self.placeholder ?? "")
        
        let doneBarButtonItem: UIBarButtonItem = UIBarButtonItem()
        doneBarButtonItem.target = self
        doneBarButtonItem.action = #selector(doneBarButtonItemTouched)
        doneBarButtonItem.title = nextTextField == nil ? "Done" : "Next"
        
        let flexible:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        var items = [UIBarButtonItem]()
        items.append(flexible)
        items.append(doneBarButtonItem)
        
        toolbar.items = items
        toolbar.addSubview(title)
        toolbar.sizeToFit()
        
        return toolbar
    }
    
    private func setLabel(withTitle title: String) -> UILabel {
        
        let titleLabel:UILabel = UILabel()
        let rect = CGRect(x: 16, y: 0, width: 200, height: 40)
        
        titleLabel.frame = rect
        titleLabel.text = title
        titleLabel.textAlignment = NSTextAlignment.left
        titleLabel.textColor = .darkGray
        
        return titleLabel
    }
}
