//
//  FeedViewController.swift
//  Navigation
//
//  Created by Zhukova on 10.03.2023.
//

import UIKit

class FeedViewController: UIViewController {
    
    let postTitle = "Мои лучшие рецепты"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Лента новостей"
        view.backgroundColor = .systemOrange
        
        let postButton: UIButton = .init(type: .system)
        postButton.setTitle("Посмотреть пост", for: .normal)
        postButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postButton)
        postButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        postButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        postButton.addTarget(self, action: #selector(onButonPressed(_:)), for: .touchUpInside)
        

        // Do any additional setup after loading the view.
    }
    
    @objc func onButonPressed(_ sender: UIButton) {
        let postViewController = PostViewController()
        postViewController.title = postTitle
        self.navigationController?.pushViewController(postViewController, animated: true)
        
       // show(postViewController, sender: self)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
