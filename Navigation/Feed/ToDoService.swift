import Foundation

struct ToDo {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

struct ToDoService {
    static func request(for id: Int, completionHandler: @escaping (ToDo?) -> Void) {
        let url = URL(string: AppConfiguration.todo.rawValue + "\(id)")
        let session = URLSession(configuration: .default)
        
        guard let url else {
            return print("Упс...урл сломался")
        }
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            if let error {
                print(error.localizedDescription)
                completionHandler(nil)
                return
            }
            guard let httpURLResponse = response as? HTTPURLResponse else {
                print("response is not httpURLResponse")
                completionHandler(nil)
                return
            }
            print("statusCode \(httpURLResponse.statusCode)")
            print("allHeaderFields: \(httpURLResponse.allHeaderFields)")
            
            if httpURLResponse.statusCode != 200 {
                print("statusCode is not 200")
                completionHandler(nil)
                return
            }
            guard let data else {
                print("data is nil")
                completionHandler(nil)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                guard let dictionary = json as? [String: Any] else {
                    completionHandler(nil)
                    return
                }
                guard
                    let userId = dictionary["userId"] as? Int,
                    let id = dictionary["id"] as? Int,
                    let title = dictionary["title"] as? String,
                    let completed = dictionary["completed"] as? Bool
                else {
                    completionHandler(nil)
                    return
                }
                completionHandler(ToDo(
                    userId: userId,
                    id: id,
                    title: title,
                    completed: completed)
                )
            } catch {
                completionHandler(nil)
            }
        }
        dataTask.resume()
    }
}
