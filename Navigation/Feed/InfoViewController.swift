import UIKit

class InfoViewController: UIViewController {
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        label.text = "Взбейте белок с сахаром. Выложите на противень в форме пик. Поместите в разогретую до 180 градусов духовку. Выпекайте 20 минут."
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    let alertButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Оценить рецепт", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        title = "Подробнее"
        
        view.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            textLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
        ])
        
        view.addSubview(alertButton)
        NSLayoutConstraint.activate([
            alertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        alertButton.addTarget(
            self,
            action: #selector(alertButonPressed(_:)),
            for: .touchUpInside
        )
    }
    
    @objc func alertButonPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Оцените рецепт", message: "Если вам понравился рецепт, нажмите like, если нет - dislike", preferredStyle: .alert)
        
        let likeAction = UIAlertAction(title: "Like", style: .default) {_ in print("Пользователь поставил Like")
        }
    
        let dislikeAction = UIAlertAction(title: "Dislike", style: .default) {_ in
            print("Пользователь поставил Dislike")
        }
        
        alertController.addAction(likeAction)
        alertController.addAction(dislikeAction)
        present(alertController, animated: true)
    }

}
