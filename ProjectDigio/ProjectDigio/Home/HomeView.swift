import UIKit

protocol HomeViewDelegate where Self: UIViewController {
    func sendDataBackToParent(_ data: Data)
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
        let collectionView = UICollectionView(frame: .zero, 
                                              collectionViewLayout: UICollectionViewLayout())
        collectionView.backgroundColor = .blue
        return collectionView
    }()
    
    lazy var cashCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, 
                                              collectionViewLayout: UICollectionViewLayout())
        collectionView.backgroundColor = .red
        return collectionView
    }()
    
    lazy var productsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, 
                                              collectionViewLayout: UICollectionViewLayout())
        collectionView.backgroundColor = .green
        return collectionView
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
        homeStackView.addArrangedSubview(cashCollectionView)
        homeStackView.addArrangedSubview(productsCollectionView)
        
        homeScrollview.addSubview(homeStackView)
        
        addSubview(homeScrollview)
        
        setupContraints()
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            homeScrollview.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            homeScrollview.leadingAnchor.constraint(equalTo: leadingAnchor),
            homeScrollview.bottomAnchor.constraint(equalTo: bottomAnchor),
            homeScrollview.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            homeStackView.topAnchor.constraint(equalTo: homeScrollview.topAnchor),
            homeStackView.leadingAnchor.constraint(equalTo: homeScrollview.leadingAnchor),
            homeStackView.bottomAnchor.constraint(equalTo: homeScrollview.bottomAnchor),
            homeStackView.trailingAnchor.constraint(equalTo: homeScrollview.trailingAnchor),
            homeStackView.widthAnchor.constraint(equalTo: homeScrollview.widthAnchor),
            
            spotlightCollectionView.heightAnchor.constraint(equalToConstant: 600),
            cashCollectionView.heightAnchor.constraint(equalToConstant: 600),
            productsCollectionView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
}
