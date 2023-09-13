import Foundation

struct NetworkService {
    static func request(for configuration: AppConfiguration) {
        let url = URL(string: configuration.rawValue)
        let session = URLSession(configuration: .default)
        
        guard let url else {
            return print("Упс...урл сломался")
        }
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            if let error {
                print(error.localizedDescription)
                return
            }
            guard let httpURLResponse = response as? HTTPURLResponse else {
                print("response is not httpURLResponse")
                return
            }
            print("statusCode \(httpURLResponse.statusCode)")
            print("allHeaderFields: \(httpURLResponse.allHeaderFields)")
            
            if httpURLResponse.statusCode != 200 {
                print("statusCode is not 200")
                return
            }
            guard let data else {
                print("data is nil")
                return
            }
            guard let string = String(data: data, encoding: .utf8) else {
                print("data is not string")
                return
            }
            print(string)
        }
        dataTask.resume()
    }
}
