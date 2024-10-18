//
//  LoadingView.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2024/10/18.
//

import UIKit

class LoadingView: UIView {
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading, please wait..."
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    init(frame: CGRect, needIndicator: Bool) {
        super.init(frame: frame)
        setupView(needIndicator: needIndicator)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView(needIndicator: Bool = true) {
        backgroundColor = UIColor(white: 0, alpha: 0.6)
        guard needIndicator else { return }
        
        addSubview(activityIndicator)
        addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20),
            
            messageLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func setMessage(_ message: String?) {
        messageLabel.text = message
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
        removeFromSuperview()
    }
}
