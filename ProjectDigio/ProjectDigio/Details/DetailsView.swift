import UIKit
import RestService

protocol DetailsViewDelegate where Self: UIViewController {
    func displayProductDetail(_ description: String, image: String)
}

protocol DisplayProducts: AnyObject {
    func displayProducts(_ description: String, image: String)
}

final class DetailsView: UIView {
    enum NumberConstants {
        static let verticalSpacing = 100.0
        static let horizontalSpacing = 24.0
    }
    
    lazy var productImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "square.and.arrow.down"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var productDetailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    weak var delegate: DetailsViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        addSubview(productImageView)
        addSubview(productDetailLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: NumberConstants.verticalSpacing),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: NumberConstants.horizontalSpacing),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -NumberConstants.horizontalSpacing),
            productImageView.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: 0.2),
            
            productDetailLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10),
            productDetailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: NumberConstants.horizontalSpacing),
            productDetailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -NumberConstants.horizontalSpacing)
        ])
    }
}

extension DetailsView: DisplayProducts {
    func displayProducts(_ description: String, image: String) {
        RestService.shared.downloadImage(image) {
            result in
            
            switch result {
            case .success(let data):
                self.productImageView.image = data
            case .failure(_):
                self.productImageView.image = UIImage(named: "loadfailed")
            }
        }
        
        productDetailLabel.text = description
    }
}
