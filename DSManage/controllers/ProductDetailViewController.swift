import UIKit
import Social
import Alamofire

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    private var productViewModel: ProductViewModel?

    
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

    public func setProductViewModel(productViewModel:ProductViewModel){
        self.productViewModel = productViewModel
        
    }
    
    private func populateView(){
        self.productNameLabel.text = self.productViewModel?.productText
        self.productPriceLabel.text = self.productViewModel?.priceText
        self.productDescriptionLabel.text = self.productViewModel?.descText
        self.productImageView.image = UIImage(named: (self.productViewModel?.photoText)!)

        downloadImage()
    }
    
    func downloadImage(){

        Alamofire.download("https://robohash.org/123.png").responseData { response in

            if let data = response.result.value {
                self.productImageView.image = UIImage(data: data)
            }
        }
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
            facebookSheet.setInitialText(self.productViewModel?.productText)
            self.present(facebookSheet, animated: true, completion: nil)
        } else {
            self.showOkAlertMessage(withTitle: "Couldn't Post it", andBody: "Please login to a Facebook account to share.")
        }
    }

}


