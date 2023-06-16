import Foundation

protocol LoginFactory {
    static func makeLoginInspector() -> LoginInspector
}


struct MyLoginFactory: LoginFactory {
    static func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}