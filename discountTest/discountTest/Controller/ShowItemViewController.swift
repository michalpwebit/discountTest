//
//  ShowItemViewController.swift
//  discountTest
//
//  Created by michal packter on 20/05/2022.
//

import UIKit
import WebKit

class ShowItemViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    var selectedItemURL: String?
    private var loadingObservation: NSKeyValueObservation?

    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .green
        spinner.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        return spinner
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadingObservation = webView.observe(\.isLoading, options: [.new, .old]) { [weak self] (_, change) in
            guard let strongSelf = self else { return }

            if change.newValue! && !change.oldValue! {
                strongSelf.view.addSubview(strongSelf.loadingIndicator)
                strongSelf.loadingIndicator.startAnimating()
                NSLayoutConstraint.activate([strongSelf.loadingIndicator.centerXAnchor.constraint(equalTo: strongSelf.view.centerXAnchor),
                                             strongSelf.loadingIndicator.centerYAnchor.constraint(equalTo: strongSelf.view.centerYAnchor)])
                strongSelf.view.bringSubviewToFront(strongSelf.loadingIndicator)
            }
            
            else if !change.newValue! && change.oldValue! {
                strongSelf.loadingIndicator.stopAnimating()
                strongSelf.loadingIndicator.removeFromSuperview()
            }
        }
        
        selectedItemURL =  selectedItemURL?.replacingOccurrences(of: " ", with:"")
        selectedItemURL =  selectedItemURL?.replacingOccurrences(of: "\n", with:"")
        webView.backgroundColor = .white
        webView.load(URLRequest(url: URL(string: selectedItemURL! as String)!))    }
 
}
