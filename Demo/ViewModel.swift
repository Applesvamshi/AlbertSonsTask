//
//  ViewModel.swift
//  Demo
//
//  Created by Vamshi on 17/07/24.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    @Published var hits: [Hits] = []
    @Published var isLoading = false
    @Published var error: String?

    private var cancellables = Set<AnyCancellable>()

    func fetchUsers() {
        isLoading = true
        error = nil
        let url = URL(string: constants.baseUrl)
        NetworkManager.shared.request(url: url, method: .get) { [weak self] (result: Result<Responsedata, NetworkError>) in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    self?.hits = response.hits ?? []
                case .failure(let error):
                    self?.error = error.localizedDescription
                }
            }
        }
    }
}
