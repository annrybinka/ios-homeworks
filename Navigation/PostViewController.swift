//
//  PostViewController.swift
//  Navigation
//
//  Created by Zhukova on 10.03.2023.
//

import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        
        let infoButton: UIButton = .init(type: .system)
        infoButton.setTitle("Подробнее", for: .normal)
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoButton)
        infoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        infoButton.addTarget(self, action: #selector(onButonPressed(_:)), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    
    @objc func onButonPressed(_ sender: UIButton) {
        let infoViewController = InfoViewController()
        infoViewController.modalTransitionStyle = .coverVertical
        infoViewController.modalPresentationStyle = .fullScreen
        
        present(infoViewController, animated: true)
        
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
