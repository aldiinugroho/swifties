//
//  ViewController.swift
//  swifties
//
//  Created by aldinugroho on 04/12/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - model
    struct homeviewModel {
        let title: String
        let desc: String
    }
    
    // MARK: - declaration
    let baseColoring: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "pink2")
        view.widthAnchor.constraint(equalToConstant: 140).isActive = true
        view.heightAnchor.constraint(equalToConstant: 36).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleBaseColoring: UILabel = {
        let label = UILabel()
        label.text = "SWIFTIES"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageview: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "testimage2")
        iv.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 240).isActive = true
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let labelViewTitleQuote: PaddingLabel = {
        let label = PaddingLabel()
        label.padding(20, 20, 20, 20)
        label.backgroundColor = .white
        label.text = "-"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8.0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelViewDescQuote: PaddingLabel = {
        let label = PaddingLabel()
        label.padding(20, 20, 20, 20)
        label.backgroundColor = .white
        label.text = "-"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8.0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let icontopress: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "arrow.down.circle"), for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 36).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 36).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    // MARK: - component life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        layout()
        fetching()
    }

}

extension HomeViewController {
    private func setup() {
        view.addSubview(baseColoring)
        baseColoring.addSubview(titleBaseColoring)
        view.addSubview(imageview)
        view.addSubview(labelViewTitleQuote)
        view.addSubview(labelViewDescQuote)
        icontopress.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        view.addSubview(icontopress)
        
        // baseColoring
        NSLayoutConstraint.activate([
            baseColoring.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            baseColoring.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 2)
        ])
        
        // titleBaseColoring
        NSLayoutConstraint.activate([
            titleBaseColoring.leadingAnchor.constraint(equalToSystemSpacingAfter: baseColoring.leadingAnchor, multiplier: 1.5),
            titleBaseColoring.bottomAnchor.constraint(equalTo: baseColoring.bottomAnchor)
        ])
        
        // imageview
        NSLayoutConstraint.activate([
            imageview.topAnchor.constraint(equalToSystemSpacingBelow: baseColoring.bottomAnchor, multiplier: 5),
            imageview.leadingAnchor.constraint(equalTo: baseColoring.leadingAnchor),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: imageview.trailingAnchor, multiplier: 2)
        ])
        
        // labelViewTitleQuote
        NSLayoutConstraint.activate([
            labelViewTitleQuote.topAnchor.constraint(equalToSystemSpacingBelow: imageview.bottomAnchor, multiplier: 5),
            labelViewTitleQuote.leadingAnchor.constraint(equalTo: imageview.leadingAnchor),
            labelViewTitleQuote.trailingAnchor.constraint(equalTo: imageview.trailingAnchor)
        ])
        
        // labelViewDescQuote
        NSLayoutConstraint.activate([
            labelViewDescQuote.topAnchor.constraint(equalToSystemSpacingBelow: labelViewTitleQuote.bottomAnchor, multiplier: 5),
            labelViewDescQuote.leadingAnchor.constraint(equalTo: labelViewTitleQuote.leadingAnchor),
            labelViewDescQuote.trailingAnchor.constraint(equalTo: labelViewTitleQuote.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            icontopress.topAnchor.constraint(equalTo: baseColoring.topAnchor),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: icontopress.trailingAnchor, multiplier: 2)
        ])
    }
    
    private func layout() {
    }
    
    private func fetching() {
        let data = homeviewModel(title: "-", desc: "-")
        self.configure(parameters: data)
        networkings().fetchdataswifties() { results in
            switch results {
            case .success(let success):
                print(success)
                let data = homeviewModel(title: success.song, desc: success.quote)
                self.configure(parameters: data)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}


extension HomeViewController {
    func configure(parameters: homeviewModel) {
        labelViewTitleQuote.text = parameters.title
        labelViewDescQuote.text = parameters.desc
    }
    
    @objc func pressed() {
        self.fetching()
    }
}
