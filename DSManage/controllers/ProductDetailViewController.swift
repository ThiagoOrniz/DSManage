import UIKit
import Social


class ProductDetailViewController: UIViewController {

    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    private var product = Product();

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
    }

    override func viewWillAppear(_ animated: Bool) {
        populateView()
    }
    
    private func setupNavigationController(){
        
        let shareButtomItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action,target: self,action: #selector(shareButtonTouched))
        
        self.navigationItem.setRightBarButton(shareButtomItem, animated: true)
    }

    public func setProduct(product:Product){
        self.product = product
        
    }
    
    private func populateView(){
        self.productNameLabel.text = self.product.product
        self.productPriceLabel.text = String(format:"%.2f",self.product.price)
        self.productDescriptionLabel.text = self.product.desc
        self.productImageView.image = UIImage(named: product.photoURL)

    }
    
    func shareButtonTouched(){
        let alert = UIAlertController(title: "Share This Product", message: "Sharing your products can help improve your sales!", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Facebook", style: .default) { action in
            self.shareWithFacebook()
        })
                
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        self.present(alert,animated: true,completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func shareWithFacebook(){
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook){
            let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText(self.product.product)
            self.present(facebookSheet, animated: true, completion: nil)
        } else {
            self.showOkAlertMessage(withTitle: "Couldn't Post it", andBody: "Please login to a Facebook account to share.")
        }
    }

}


