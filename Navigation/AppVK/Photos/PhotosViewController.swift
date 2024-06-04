import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    private static let spacing: CGFloat = 8.0
    
    var photosNames: [String] = []
    private var photos: [UIImage] = [] {
        didSet {
            DispatchQueue.main.async { self.photosCollectionView.reloadData() }
        }
    }
    
    private var photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppVKСolor.forBackground
        setupCollection()
        setupUI()
        applyFilter()
    }
    
    private func applyFilter() {
        let imageProcessor = ImageProcessor()
        let photos = photosNames.compactMap { UIImage(named: $0) }
        let startTime = Date().timeIntervalSince1970
        imageProcessor.processImagesOnThread(
            sourceImages: photos,
            filter: .sepia(intensity: 0.6),
            qos: .default
        ) { filteredImages in
            self.photos = filteredImages.map { image in
                guard let image else { return UIImage() }
                return UIImage(cgImage: image)
            }
            let endTime = Date().timeIntervalSince1970
            print("время работы фильтра: ", (endTime - startTime))
        }
    }
    
    private func setupCollection() {
        photosCollectionView.register(
            PhotosCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotosCollectionViewCell.id
        )
        photosCollectionView.backgroundColor = AppVKСolor.forBackground
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
    }
    
    private func setupUI() {
        view.addSubview(photosCollectionView)
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            photosCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photosCollectionView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        let totalSpacing: CGFloat = 2 * PhotosViewController.spacing + (itemsInRow - 1) * PhotosViewController.spacing
        let width = (view.frame.width - totalSpacing) / itemsInRow
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(
            top: PhotosViewController.spacing,
            left: PhotosViewController.spacing,
            bottom: PhotosViewController.spacing,
            right: PhotosViewController.spacing
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        PhotosViewController.spacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        PhotosViewController.spacing
    }
}
