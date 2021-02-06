//
//  ViewController.swift
//  NetologyTestTask
//
//  Created by k.shakhansky on 06.02.2021.
//

import UIKit

struct Post: Codable {
    let title: String
    let body: String
    let id: Int
    let userId: Int
}

class ViewController: UIViewController {

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        return label
    }()

    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: stackView.topAnchor),
            view.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bodyLabel)

        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/2")!
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentDirectoryURL.appendingPathComponent("post.json")
        if let data = try? Data(contentsOf: fileURL) {
            let post = try! JSONDecoder().decode(Post.self, from: data)
            titleLabel.text = post.title
            bodyLabel.text = post.body
        } else {
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                let post = try! JSONDecoder().decode(Post.self, from: data!)
                let postData = try! JSONEncoder().encode(post)
                try! postData.write(to: fileURL)
                DispatchQueue.main.async {
                    self?.titleLabel.text = post.title
                    self?.bodyLabel.text = post.body
                }
            }.resume()
        }
    }

}

