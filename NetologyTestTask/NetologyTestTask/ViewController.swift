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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
               let post = try? JSONDecoder().decode(Post.self, from: data) {
                print(post)
            }
        }.resume()
    }

}

