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
    }

    override func viewWillAppear(_ animated: Bool) {
        populateView()
    }

    func setProduct(_ productViewModel:ProductViewModel) {
        self.productViewModel = productViewModel
    }
    
    private func populateView() {
        
        productNameLabel.text = productViewModel?.productText
        productPriceLabel.text = productViewModel?.priceText
        productDescriptionLabel.text = self.productViewModel?.descText
        productImageView.image = UIImage(data: productViewModel?.imageData as! Data)
    }
    
}


