import UIKit

protocol DocumentsViewModelProtocol {
    var onItemsChanged: (([DocumentsViewModel.Item]) -> Void)? {get set}
    func onViewReady()
    func currentSortState() -> Bool
    func onItemPressed(index: Int)
    func showImagePicker()
}

final class DocumentsViewModel: NSObject, DocumentsViewModelProtocol {
    private let fileManager: FileManagerServiceProtocol
    let rootPath: String
    var alphabeticalSortState: Bool
    var coordinator: DocumentsCoordinator?
    var onItemsChanged: (([Item]) -> Void)?
    
    private(set) var items: [Item] = [] {
        didSet {
            onItemsChanged?(items)
        }
    }
    
    init(fileManager: FileManagerServiceProtocol, rootPath: String, alphabeticalSortState: Bool) {
        self.fileManager = fileManager
        self.rootPath = rootPath
        self.alphabeticalSortState = alphabeticalSortState
    }
    
    private func fullPath(itemTitle: String) -> String {
        rootPath + "/" + itemTitle
    }
    
    private func refreshItems() {
        let documents = fileManager.contentsOfDirectory(path: rootPath)
        items = documents.map { name in
            Item(
                title: name,
                isDirectory: fileManager.isDirectory(path: self.fullPath(itemTitle: name))
            )
        }
        sortItems(alphabetical: alphabeticalSortState)
    }
    
    func sortItems(alphabetical: Bool) {
        if alphabetical {
            print("=== sort Items alphabetical")
        } else {
            print("=== sort Items in reverse alphabetical")
        }
    }
    
    func onViewReady() {
        refreshItems()
    }
    
    func currentSortState() -> Bool {
        UserDefaultsService.create.getSortState()
    }
    
    func onItemPressed(index: Int) {
        let item = items[index]
        if item.isDirectory {
            coordinator?.startNextView(
                path: self.fullPath(itemTitle: item.title),
                title: item.title
            )
        }
    }
    
    func showImagePicker() {
        coordinator?.presentImagePicker(delegate: self)
    }
}

extension DocumentsViewModel: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            if let image = info[.originalImage] as? UIImage {
                fileManager.createFile(
                    atPath: fullPath(itemTitle: "image\(url.lastPathComponent).\(url.pathExtension)"),
                    data: image.pngData()
                )
                refreshItems()
            }
        }
        picker.dismiss(animated: true)
    }
}
