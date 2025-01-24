//
//  CustomAlert.swift
//  MovieFinder
//
//  Created by Bruno Moura on 20/01/25.
//

import UIKit

final class CustomAlert {
    private let parentView: UIView
    
    /// Inicializa o CustomAlert com a view pai onde o alerta será exibido.
    init(parentView: UIView) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            fatalError("Nenhuma UIWindow foi encontrada.")
        }
        self.parentView = window
    }
    
    /// Exibe um alerta customizado com título e mensagem.
    /// - Parameters:
    ///   - title: O título do alerta.
    ///   - message: A mensagem do alerta.
    ///   - duration: O tempo em segundos para o alerta desaparecer automaticamente.
    func showAlert(title: String, message: String, duration: TimeInterval = 3.0) {
        if parentView.subviews.contains(where: { $0.tag == 999 }) {
            return
        }
        let alertView = createAlertView(title: title, message: message)
        alertView.tag = 999
        parentView.addSubview(alertView)
        
        // Posiciona a view fora da tela para iniciar a animação
        alertView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            alertView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
            alertView.topAnchor.constraint(equalTo: parentView.topAnchor),
            alertView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150)
        ])
        
        // Animação de entrada
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            alertView.transform = CGAffineTransform(translationX: 0, y: alertView.frame.height)
        }) { _ in
            // Remoção após o tempo definido
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.hideAlert(alertView)
            }
        }
    }
    
    /// Cria a view do alerta.
    private func createAlertView(title: String, message: String) -> UIView {
        let alertView = UIView()
        alertView.backgroundColor = .red
        alertView.layer.cornerRadius = 8
        alertView.clipsToBounds = true
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textAlignment = .center
        
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, messageLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        
        alertView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: alertView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -16)
        ])
        
        return alertView
    }
    
    /// Remove o alerta da view com animação.
    private func hideAlert(_ alertView: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            alertView.transform = CGAffineTransform(translationX: 0, y: -alertView.frame.height)
        }) { _ in
            alertView.removeFromSuperview()
        }
    }
}
