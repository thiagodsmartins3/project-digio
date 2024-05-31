import UIKit
import RestService

protocol HomeViewDelegate where Self: UIViewController {
    func didSelectProduct(_ description: String, image: String)
}

protocol HomeDisplay: AnyObject {
    func displayData(_ products: ProductsModel)
}

final class HomeView: UIView {
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
    
    private var products: ProductsModel? {
        didSet {
            spotlightCollectionView.reloadData()
            cashCollectionView.reloadData()
            productsCollectionView.reloadData()
        }
    }
    
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
        homeStackView.addArrangedSubview(cashCollectionView)
        homeStackView.addArrangedSubview(productsCollectionView)
        
        homeScrollview.addSubview(homeStackView)
        
        addSubview(homeScrollview)
        
        setupContraints()
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            homeScrollview.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            homeScrollview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            homeScrollview.bottomAnchor.constraint(equalTo: bottomAnchor),
            homeScrollview.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            homeStackView.topAnchor.constraint(equalTo: homeScrollview.topAnchor),
            homeStackView.leadingAnchor.constraint(equalTo: homeScrollview.leadingAnchor),
            homeStackView.bottomAnchor.constraint(equalTo: homeScrollview.bottomAnchor),
            homeStackView.trailingAnchor.constraint(equalTo: homeScrollview.trailingAnchor),
            homeStackView.widthAnchor.constraint(equalTo: homeScrollview.widthAnchor),
            
            spotlightCollectionView.heightAnchor.constraint(equalToConstant: 200),
            cashCollectionView.heightAnchor.constraint(equalToConstant: 200),
            productsCollectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

extension HomeView: HomeDisplay {
    func displayData(_ products: ProductsModel) {
        self.products = products
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
                    print(error)
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
                case .failure(let error):
                    print(error)
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
                case .failure(let error):
                    print(error)
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
