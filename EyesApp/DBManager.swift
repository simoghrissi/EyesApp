//
//  DBManager.swift
//  EyesApp
//
//  Created by simo on 07/09/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DBManager {
    
   static func  getPostsFromDatas()->[PostEyes]{
    var posts = [PostEyes]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Posts")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            if results.count > 0{
                for result in results as! [NSManagedObject]{
                    let postEyes = PostEyes()
                    if let name = result.value(forKey: "userName"){
                        postEyes.nameProfil = name as! String
                    }
                    if let imagePost = result.value(forKey: "imagePost"){
                        if let imageUI = UIImage(data: imagePost as! Data){
                            postEyes.postImage = imageUI

                        }
                    }
                    if let imageProfil = result.value(forKey: "imageProfil"){
                        if let imageUI = UIImage(data: imageProfil as! Data){
                            postEyes.imageProfil = imageUI
                            
                        }                    }
                    if let textPost = result.value(forKey: "textPost"){
                        postEyes.description = textPost as! String
                    }
                    posts.append(postEyes)
                }
                print("returned ✅")
            }
            
        } catch  {
            print("Error in getPostdata ❌")
        }
        return posts
    }
    
   static func  putPostInData(imageProfil: UIImage?, nameProfil: String, postImage: UIImage?, description: String){
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    let context = appDelegate.persistentContainer.viewContext
        
        let newPost = NSEntityDescription.insertNewObject(forEntityName: "Posts", into: context)
        newPost.setValue(nameProfil, forKey: "userName")
        newPost.setValue(description, forKey: "textPost")

       // let imgPost = UIImage(named: (postImage?.description)!)
        if let imgPost = postImage {
            let imgData = UIImageJPEGRepresentation(imgPost, 1)
            newPost.setValue(imgData, forKey: "imagePost")

        }
    
       // let imgProfil = UIImage(named: (imageProfil?.description)!)
        if let imgProfil = imageProfil{
            let imgDataProfil = UIImageJPEGRepresentation(imgProfil, 1)
            newPost.setValue(imgDataProfil, forKey: "imageProfil")
        }
    
        do {
            try context.save()
            print("saved ✅")
        } catch  {
            print("Error in putPostInData ❌")

        }
    
    }
}

