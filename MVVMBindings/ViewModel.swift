//
//  ViewModel.swift
//  MVVMBindings
//
//  Created by Tim Akhm on 03.02.2023.
//

import Foundation

protocol ViewModelProtocol {
    var users: Box<[UserModel]> { get }
    func getData(completion: @escaping ((Bool) -> Void))
}

class ViewModel: ViewModelProtocol {
    var users: Box<[UserModel]> = Box([])
    
    func getData(completion: @escaping ((Bool) -> Void)) {
        let service = NetworkService()
        print("VM: getData START")
        
        service.fetchData { result in
            switch result {
            case .success(let files):
                self.users.value = files
                print("VM: getData success")
                completion(true)
            case .failure(let error):
                print("VM: getData error", error)
                completion(false)
            }
        }
    }
}
