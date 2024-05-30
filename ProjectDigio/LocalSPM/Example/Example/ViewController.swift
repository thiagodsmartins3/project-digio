//
//  ViewController.swift
//  Example
//
//  Created by Thiago dos Santos Martins on 29/05/24.
//

import UIKit
import RestService
import LogPrint

class ViewController: UIViewController {
    lazy var imageLoader: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "square.and.arrow.up.badge.clock.fill"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        RestService.shared.request("https://brasilapi.com.br/api/banks/v1",
//                                   requestType: .GET, 
//                                   dataType: [ResponseModel].self) {
//            result in
//            
//            switch result {
//            case .success(let data):
//                logPrint(.success, "Success")
//            case .failure(let error):
//                logPrint(.error, "Error")
//            }
//        }
        
        setupViews()
        
        
        RestService.shared.downloadImage("https://s3-sa-east-1.amazonaws.com/digio-exame/uber_banner.png") {
            result in
            
            switch result {
            case .success(let data):
                self.imageLoader.image = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupViews() {
        view.addSubview(imageLoader)
        
        setupContraints()
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            imageLoader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageLoader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageLoader.widthAnchor.constraint(equalToConstant: 100),
            imageLoader.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
}

