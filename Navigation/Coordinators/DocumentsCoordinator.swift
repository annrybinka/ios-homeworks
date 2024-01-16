import UIKit

final class DocumentsCoordinator: Coordinatable {
    
    private var nc: UINavigationController?    
    
    func startView() -> UIViewController {
        let documentsViewModel = DocumentsViewModel(
            fileManager: FileManagerService(),
            rootPath: NSSearchPathForDirectoriesInDomains(
                .documentDirectory,
                .userDomainMask,
                true
            )[0]
        )
        documentsViewModel.coordinator = self
        let vc = DocumentsViewController(viewModel: documentsViewModel)
        vc.title =  "Documents"
        nc = UINavigationController(rootViewController: vc)
        nc?.navigationBar.prefersLargeTitles = true
        nc?.modalTransitionStyle = .coverVertical
        nc?.modalPresentationStyle = .pageSheet
        return nc!
    }
    
    func startNextView(path: String, title: String) {
        guard nc != nil else { fatalError() }
        let documentsViewModel = DocumentsViewModel(
            fileManager: FileManagerService(),
            rootPath: path
        )
        documentsViewModel.coordinator = self
        let vc = DocumentsViewController(viewModel: documentsViewModel)
        vc.title = title
        nc?.pushViewController(vc, animated: true)
    }
    
    func presentImagePicker(delegate: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        guard nc != nil else { fatalError() }
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = delegate
        nc?.present(imagePicker, animated: true)
    }
}
