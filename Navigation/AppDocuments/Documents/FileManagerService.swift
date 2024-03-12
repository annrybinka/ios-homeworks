import Foundation

protocol FileManagerServiceProtocol {
    func contentsOfDirectory(path: String) -> [String]
    func isDirectory(path: String) -> Bool
    func createFile(atPath: String, data: Data?)
}

final class FileManagerService: FileManagerServiceProtocol {
    private let fileManager = FileManager.default
    
    func contentsOfDirectory(path: String) -> [String] {
        do {
            return try fileManager.contentsOfDirectory(atPath: path)
        } catch {
            print("===\(error)")
        }
        return []
    }
    
    func isDirectory(path: String) -> Bool {
        var isDir: ObjCBool = false
        if fileManager.fileExists(atPath: path, isDirectory: &isDir) {
            return isDir.boolValue
        } else {
            return false
        }
    }
    
    func createFile(atPath: String, data: Data?) {
        fileManager.createFile(atPath: atPath, contents: data)
    }
}
