//
//  DigioService.swift
//  ProjectDigio
//
//  Created by Thiago dos Santos Martins on 30/05/24.
//

import Foundation

class DigioService {
    static let shared = DigioService()
    
    let endpoint = "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox/products"
    
    private init() { }
}
