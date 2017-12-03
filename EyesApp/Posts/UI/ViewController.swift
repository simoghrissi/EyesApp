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
        posts = DBManager.getPostsFromDatas()
        
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

//    @IBAction func SegmentedIndexChange(_ sender: Any) {
//        switch segmentedControl.selectedSegmentIndex {
//        case 0:
//            print("first one")
//            break
//        case 1:
//            let storyboard = UIStoryboard(name: "Camera", bundle: nil)
//            let cameraVC = storyboard.instantiateViewController(withIdentifier: "CameraViewController")as? CameraViewController
//            cameraVC?.delegate = self
//            self.navigationController?.pushViewController(cameraVC!, animated: true)
//            break
//        case 2:
//            let storyboard = UIStoryboard(name: "Maps", bundle: nil)
//            let mapsVC = storyboard.instantiateViewController(withIdentifier: "MapsViewController")as? MapsViewController
//            self.navigationController?.pushViewController(mapsVC!, animated: true)
//            break
//        default:
//            break
//        }
//        
//        
//    }
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
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
            let post = posts[indexPath.row]
            cell.imageProfilCell.image = post.imageProfil
            cell.nameProfilCell.text = post.nameProfil
            cell.postImageCell.image = post.postImage
            cell.descriptionCell.text = post.description
        print("voila : \(String(describing: cell.descriptionCell.text))")
        return cell
    }
    
    func addDataToTm(imageProfil: UIImage?, nameProfil: String, postImage: UIImage?, description: String) {
        let postEyes = PostEyes(imageProfil: imageProfil, nameProfil: nameProfil, postImage: postImage, description: description)
        posts.append(postEyes!)
        
     
    }
   
   
 
}

