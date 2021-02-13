//
//  ViewController.swift
//  WebViewSample
//
//  Created by kou yamamoto on 2021/02/12.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa
import RxOptional
import RxWebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
    
    private func setupWebView() {
        //ColdなObservableを以下3回subcribe(bind)しているので、3個のストリームが生成するのを防ぐために、share()でHotなObservableに変換してストリームが1回で済むようにしている
        //loadingの値True、False
        let loadingObservable = webView.rx.loading.share()
        loadingObservable.map { return !$0 }.observeOn(MainScheduler.instance).bind(to: progressView.rx.isHidden).disposed(by: disposeBag)
        loadingObservable.bind(to: UIApplication.shared.rx.isNetworkActivityIndicatorVisible).disposed(by: disposeBag)
        webView.rx.title.filterNil().observeOn(MainScheduler.instance).bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        
        webView.rx.estimatedProgress.map { return Float($0)}.observeOn(MainScheduler.instance).bind(to: progressView.rx.progress).disposed(by: disposeBag)
        
        guard let url = URL(string: "https://www.google.com/") else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}
