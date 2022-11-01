//
//  ViewController.swift
//  RxSwiftUICollectionViewCompositionalLayout
//
//  Created by Aaron Hanwe LEE on 2022/10/31.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func testAction(_ sender: Any) {
        let vc = TestViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func txTestAction(_ sender: Any) {
        let vc = RxTestViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}

