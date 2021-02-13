//
//  ViewController.swift
//  WebViewSample
//
//  Created by kou yamamoto on 2021/02/13.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var toWebViewButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
    }
    
    private func setupButton() {
        toWebViewButton.rx.tap
            .subscribe { [unowned self] _ in
                let webViewController = self.storyboard?.instantiateViewController(identifier: "WebViewController") as! WebViewController
                webViewController.modalPresentationStyle = .fullScreen
                self.present(webViewController, animated: true, completion: nil)
            }
    }
}
