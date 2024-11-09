import SwiftUI
import Combine

class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var errorMessage: String?
    
    private var userService = UserService()
    
    func loadUsers() {
        userService.fetchUsers { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self?.users = users
                case .failure(let error):
                    self?.errorMessage = self?.handleError(error)
                }
            }
        }
    }
    
    private func handleError(_ error: NetworkError) -> String {
        switch error {
        case .invalidURL:
            return "Invalid URL."
        case .requestFailed(let underlyingError):
            return "Request failed: \(underlyingError.localizedDescription)"
        case .invalidResponse:
            return "Invalid response from server."
        case .decodingFailed:
            return "Failed to load data."
        case .decodingError:
            return "Failed to decode data."
        }
    }
}
