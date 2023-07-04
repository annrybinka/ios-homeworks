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
    
    let alertButton = CustomButton(title: "Оценить рецепт", titleColor: .white)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        title = "Подробнее"
        
        view.addSubview(textLabel)
        view.addSubview(alertButton)
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            textLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
        
            alertButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            alertButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            alertButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        alertButton.tapAction = { [weak self] in
            self?.alertButonPressed()
        }
    }
    
    @objc func alertButonPressed() {
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
