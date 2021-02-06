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
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentDirectoryURL.appendingPathComponent("post.json")
        if let data = try? Data(contentsOf: fileURL) {
            let post = try! JSONDecoder().decode(Post.self, from: data)
            print(post)
        } else {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                let post = try! JSONDecoder().decode(Post.self, from: data!)
                let postData = try! JSONEncoder().encode(post)
                try! postData.write(to: fileURL)
                print("Save to disk")
            }.resume()
        }
    }

}

