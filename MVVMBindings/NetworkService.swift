//
//  NetworkService.swift
//  MVVMBindings
//
//  Created by Tim Akhm on 03.02.2023.
//

import Foundation

class NetworkService {
    
    func fetchData(completion: @escaping (Result<[UserModel], Error>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        print("NS fetchData START")
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            do {
                let userModels = try JSONDecoder().decode([UserModel].self, from: data)
                print("NS fetchData success")
                completion(.success(userModels))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
