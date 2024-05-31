import UIKit
import RestService

protocol HomeViewDelegate where Self: UIViewController {
    func didSelectProduct(_ description: String, image: String)
}

protocol HomeDisplay: AnyObject {
    func displayData(_ products: ProductsModel)
}

final class HomeView: UIView {
    enum NumberConstants {
        static let spacing = 24.0
        static let spotlightHeight = 200.0
        static let cashHeight = 100.0
        static let productsHeight = 140.0
        static let topSpacing = 100.0
    }
    
    enum TextConstants {
        static let cashTitle = "digio Cash"
        static let productsTitle = "Produtos"
        static let errorMessage = "Ocorreu um erro no carremento dos dados. Tente novamente"
    }
    
    lazy var homeScrollview: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.bounces = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var homeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var spotlightCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.register(ProductCollectionViewCell.self,
                                forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collectionView.tag = 1
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    lazy var cashCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.register(ProductCollectionViewCell.self,
                                forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collectionView.tag = 2
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    lazy var productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.register(ProductCollectionViewCell.self,
                                forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collectionView.tag = 3
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    lazy var cashLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = .lightGray
        label.colorString(text: TextConstants.cashTitle,
                          coloredText: "digio",
                          color: .digioBlue)
        return label
    }()
    
    lazy var productsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = TextConstants.productsTitle
        return label
    }()
    
    private var products: ProductsModel? {
        didSet {
            spotlightCollectionView.reloadData()
            cashCollectionView.reloadData()
            productsCollectionView.reloadData()
        }
    }
    
    var loadingActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .large
        indicator.color = .digioBlue
        indicator.backgroundColor = .white
            
        indicator.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin,
            .flexibleTopMargin, .flexibleBottomMargin
        ]
        
        return indicator
    }()
    
    lazy var errorView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = TextConstants.errorMessage
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    weak var delegate: HomeViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        homeStackView.addArrangedSubview(spotlightCollectionView)
        homeStackView.addArrangedSubview(cashLabel)
        homeStackView.addArrangedSubview(cashCollectionView)
        homeStackView.addArrangedSubview(productsLabel)
        homeStackView.addArrangedSubview(productsCollectionView)
        
        homeScrollview.addSubview(homeStackView)
        homeScrollview.addSubview(loadingActivityIndicator)
        
        errorView.addSubview(errorLabel)
        
        addSubview(homeScrollview)
        addSubview(errorView)
        
        setupContraints()
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            homeScrollview.topAnchor.constraint(equalTo: topAnchor, constant: NumberConstants.topSpacing),
            homeScrollview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: NumberConstants.spacing),
            homeScrollview.bottomAnchor.constraint(equalTo: bottomAnchor),
            homeScrollview.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            homeStackView.topAnchor.constraint(equalTo: homeScrollview.topAnchor),
            homeStackView.leadingAnchor.constraint(equalTo: homeScrollview.leadingAnchor),
            homeStackView.bottomAnchor.constraint(equalTo: homeScrollview.bottomAnchor),
            homeStackView.trailingAnchor.constraint(equalTo: homeScrollview.trailingAnchor),
            homeStackView.widthAnchor.constraint(equalTo: homeScrollview.widthAnchor),
            
            spotlightCollectionView.heightAnchor.constraint(equalToConstant: NumberConstants.spotlightHeight),
            cashCollectionView.heightAnchor.constraint(equalToConstant: NumberConstants.cashHeight),
            productsCollectionView.heightAnchor.constraint(equalToConstant: NumberConstants.productsHeight),
            
            loadingActivityIndicator.topAnchor.constraint(equalTo: homeScrollview.topAnchor),
            loadingActivityIndicator.leadingAnchor.constraint(equalTo: homeScrollview.leadingAnchor),
            loadingActivityIndicator.bottomAnchor.constraint(equalTo: homeScrollview.bottomAnchor),
            loadingActivityIndicator.trailingAnchor.constraint(equalTo: homeScrollview.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: topAnchor),
            errorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            errorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: errorView.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: errorView.centerYAnchor),
            errorLabel.widthAnchor.constraint(equalTo: errorView.widthAnchor, multiplier: 0.5),
        ])
    }
    
    private func showLoader(_ isLoading: Bool) {
        if isLoading {
            loadingActivityIndicator.startAnimating()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self.loadingActivityIndicator.removeFromSuperview()
            }
        }
    }
    
    private func showError() {
        DispatchQueue.main.async {
            self.errorView.isHidden = false
            self.homeScrollview.isHidden = true
        }
    }
}

extension HomeView: HomeDisplay {
    func displayData(_ products: ProductsModel) {
        self.products = products
    }
    
    func displayLoading(_ isLoading: Bool) {
        showLoader(isLoading)
    }
    
    func displayError() {
        showError()
    }
}

extension HomeView: UICollectionViewDataSource,
                    UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = products else {
            return 0
        }
        
        switch collectionView.tag {
        case 1:
            return data.spotlight.count
        case 2:
            return 1
        case 3:
            return data.products.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
            
            RestService.shared.downloadImage(products!.spotlight[indexPath.row].bannerURL) {
                result in
                
                switch result {
                case .success(let data):
                    cell.backgroundImage.image = data
                case .failure(let error):
                    cell.backgroundImage.image = UIImage(named: "loadfailed")
                }
            }
            
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
            
            RestService.shared.downloadImage(products!.cash.bannerURL) {
                result in
                
                switch result {
                case .success(let data):
                    cell.backgroundImage.image = data
                case .failure(_):
                    cell.backgroundImage.image = UIImage(named: "loadfailed")
                }
            }
            
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
            
            RestService.shared.downloadImage(products!.products[indexPath.row].imageURL) {
                result in
                
                switch result {
                case .success(let data):
                    cell.backgroundImage.image = data
                case .failure(_):
                    cell.backgroundImage.image = UIImage(named: "loadfailed")
                }
            }
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 1:
            delegate?.didSelectProduct(products!.spotlight[indexPath.row].description, image: products!.spotlight[indexPath.row].bannerURL)
        case 2:
            delegate?.didSelectProduct(products!.cash.description, image: products!.cash.bannerURL)
        case 3:
            delegate?.didSelectProduct(products!.products[indexPath.row].description, image: products!.products[indexPath.row].imageURL)
        default:
            print("")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 1:
            let width = self.frame.size.width - 50
            let height = width * 1.5
            return CGSize(width: width, height: height)
        case 2:
            let width = self.frame.size.width - 50
            let height = width * 1.5
            return CGSize(width: width, height: height)
        case 3:
            let width = self.frame.size.width / 2
            let height = width / 2
            return CGSize(width: width, height: height)
        default:
            return .zero
        }
    }
}


extension UILabel {
    func colorString(text: String?, coloredText: String?, color: UIColor? = .red) {
        let attributedString = NSMutableAttributedString(string: text!)
        let range = (text! as NSString).range(of: coloredText!)
        attributedString.setAttributes([NSAttributedString.Key.foregroundColor: color!],
                                       range: range)
        self.attributedText = attributedString
    }
}
