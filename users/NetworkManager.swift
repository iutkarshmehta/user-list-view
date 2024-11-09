import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case decodingError
    case invalidResponse
    case decodingFailed(Error)
}
class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {} // Singleton pattern
    
    func performRequest<T: Decodable>(with url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let decodingError {
                completion(.failure(.decodingFailed(decodingError)))
            }
        }.resume()
    }
}
