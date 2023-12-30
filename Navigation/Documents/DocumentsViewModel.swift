import UIKit

protocol DocumentsViewModelProtocol {
    var onItemsChanged: (([DocumentsViewModel.Item]) -> Void)? {get set}
    func onViewReady()
    func onItemPressed(index: Int)
    func showImagePicker()
    func onImagePressed(image: UIImage)
}

final class DocumentsViewModel: DocumentsViewModelProtocol {
    let fileManager: FileManagerServiceProtocol
    let rootPath: String
    var coordinator: DocumentsCoordinator?
    var onItemsChanged: (([Item]) -> Void)?
    
    private(set) var items: [Item] = [] {
        didSet {
            onItemsChanged?(items)
        }
    }
    
    init(fileManager: FileManagerServiceProtocol, rootPath: String) {
        self.fileManager = fileManager
        self.rootPath = rootPath
    }
    
    private func fullPath(itemTitle: String) -> String {
        rootPath + "/" + itemTitle
    }
    
    func refreshItems() {
        let documents = fileManager.contentsOfDirectory(path: rootPath)
        items = documents.map { name in
            Item(
                title: name,
                isDirectory: fileManager.isDirectory(path: self.fullPath(itemTitle: name))
            )
        }
    }
    
    func onViewReady() {
        refreshItems()
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
    
    func getImages() -> [UIImage] {
        let pathToLibrary = NSSearchPathForDirectoriesInDomains(.libraryDirectory,
        .userDomainMask, true)[0]
        let images = fileManager.contentsOfDirectory(path: pathToLibrary).compactMap { UIImage(named: $0) }
        return images
    }
    
    func showImagePicker() {
        coordinator?.presentImagePicker(
            delegate: self,
            images: getImages()
        )
    }
}

extension DocumentsViewModel: ImagePickerViewControllerDelegate {
    func onImagePressed(image: UIImage) {
        fileManager.createFile(
            atPath: fullPath(itemTitle: "new image.png"),
            data: image.pngData()
        )
        refreshItems()
    }
}
