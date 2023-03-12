//
//  ViewController.swift
//  Navigation
//
//  Created by Zhukova on 01.03.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        // загрузить вью в память
        super.viewDidLoad()
        view.backgroundColor = .orange
        print("viewDidLoad")
 /*
        let button: UIButton = .init(type: .system)
        button.setTitle("Кнопка", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
  */
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // вью располагается по заданным параметрам
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }



}

