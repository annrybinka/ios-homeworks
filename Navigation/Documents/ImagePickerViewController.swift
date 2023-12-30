import UIKit

protocol ImagePickerViewControllerDelegate: AnyObject {
    func onImagePressed(image: UIImage)
}

final class ImagePickerViewController: UIViewController {
    
    private static let spacing: CGFloat = 8.0
    
    private var imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    var photos: [UIImage] = [] {
        didSet {
            DispatchQueue.main.async { self.imagesCollectionView.reloadData() }
        }
    }
    
    weak var delegate: ImagePickerViewControllerDelegate?
    
    override func loadView() {
        super.loadView()
        view = imagesCollectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollection()
    }
    
    private func setupCollection() {
        imagesCollectionView.register(
            PhotosCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotosCollectionViewCell.id
        )
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
    }
}

extension ImagePickerViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        photos.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotosCollectionViewCell.id,
            for: indexPath
        ) as! PhotosCollectionViewCell
        
        let photo = photos[indexPath.item]
        cell.configure(with: photo)
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let itemsInRow: CGFloat = 3
        let totalSpacing: CGFloat = 2 * ImagePickerViewController.spacing + (itemsInRow - 1) * ImagePickerViewController.spacing
        let width = (view.frame.width - totalSpacing) / itemsInRow
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(
            top: ImagePickerViewController.spacing,
            left: ImagePickerViewController.spacing,
            bottom: ImagePickerViewController.spacing,
            right: ImagePickerViewController.spacing
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        ImagePickerViewController.spacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        ImagePickerViewController.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onImagePressed(image: photos[indexPath.row])
    }
}
