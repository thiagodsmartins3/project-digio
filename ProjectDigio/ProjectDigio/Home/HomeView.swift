import UIKit

protocol HomeViewDelegate where Self: UIViewController {
    func sendDataBackToParent(_ data: Data)
}

final class HomeView: UIView, UICollectionViewDelegate {
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
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.tag = 1
        collectionView.backgroundColor = .blue
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    lazy var cashCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.tag = 2
        collectionView.backgroundColor = .red
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    lazy var productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.tag = 3
        collectionView.backgroundColor = .green
        collectionView.delegate = self
        collectionView.dataSource = self
        
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
            
            spotlightCollectionView.heightAnchor.constraint(equalToConstant: 200),
            cashCollectionView.heightAnchor.constraint(equalToConstant: 200),
            productsCollectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

extension HomeView: UICollectionViewDataSource,
                    UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 1:
            return 8
        case 2:
            return 16
        case 3:
            return 24
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .systemIndigo
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .systemIndigo
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .systemIndigo
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 500, height: 500)
    }
}
