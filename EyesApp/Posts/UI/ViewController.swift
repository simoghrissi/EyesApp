//
//  ViewController.swift
//  EyesApp
//
//  Created by simo on 21/08/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,loadDataDelegate {

    @IBOutlet weak var timeLine: UITableView!
 
    var posts = [PostEyes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  posts = DBManager.getPostsFromDatas()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let cameraVC = storyboard.instantiateViewController(withIdentifier: "CameraViewController")as? CameraViewController
                    cameraVC?.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        timeLine.reloadData()
    }

     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "EyesTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EyesTableViewCell  else {
            fatalError("Error cell TableVIew.")
        }
        cell.post = self.posts[indexPath.row]
        
        return cell
    }
    
    func addDataToTm(imageProfil: UIImage?, nameProfil: String, postImage: UIImage?, description: String) {
        let postEyes = PostEyes(imageProfil: imageProfil, nameProfil: nameProfil, postImage: postImage, description: description)
        posts.append(postEyes!)
        
     
    }
   
   
 
}

