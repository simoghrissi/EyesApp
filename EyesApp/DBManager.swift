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
    // MARKS POST
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
                        postEyes.nameProfil = name as? String
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
                        postEyes.description = textPost as? String
                    }
                    posts.append(postEyes)
                }
                print("returned Post ✅")
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

        if let imgPost = postImage {
            let imgData = UIImageJPEGRepresentation(imgPost, 1)
            newPost.setValue(imgData, forKey: "imagePost")

        }
    
        if let imgProfil = imageProfil{
            let imgDataProfil = UIImageJPEGRepresentation(imgProfil, 1)
            newPost.setValue(imgDataProfil, forKey: "imageProfil")
        }
    
        do {
            try context.save()
            print("saved Post✅")
        } catch  {
            print("Error in putPostInData ❌")

        }
    
    }
    
    // MARKS POI
    static func  putPoiInData(name: String?, type: String, otherInf: String?){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newPost = NSEntityDescription.insertNewObject(forEntityName: "Poi", into: context)
       // let id = getAutoIncremenetFor(table: "Poi", context: context)
        
        //newPost.setValue(id, forKey: "id")
        newPost.setValue(name, forKey: "name")
        newPost.setValue(type, forKey: "type")
        newPost.setValue(otherInf, forKey: "otherInf")
        do {
            try context.save()
            print("saved Poi✅")
        } catch  {
            print("Error in putPoiInData ❌")
            
        }

    }
//    static func getAutoIncremenetFor(table :String,context:NSManagedObjectContext) -> Int64 {
//        
//        // Initialize Fetch Request
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Demandes")
//        
//        // Sort Descriptor
//        var idDescriptor: NSSortDescriptor = NSSortDescriptor(key: "id", ascending: false)
//        fetchRequest.sortDescriptors = [idDescriptor] // Note this is a array, you can put multiple sort conditions if you want
//        
//        // Set limit
//        fetchRequest.fetchLimit = 1
//        
//        var newId = 0; // Default to 0, so that you can check if do catch block went wrong later
//        
//        do {
//            let results = try context.fetch(fetchRequest)
//            
//            //Compute the id
//            if results.count == 1{
//                // result.value(forKey: "id")
//                let result = results as! NSManagedObject
//                newId =  result.value(forKey: "")//results[0].id + 1 // slightly odd notation here, .id can be used if you use custom model. or you can use .valueForKey("id")
//            }else{
//               newId = 1
//            }
//            
//        } catch {
//            let fetchError = error as NSError
//            print(fetchError)
//        }
//    }
    
    static func  getPoiFromDatas()->[PoiEyes]{
        var pois = [PoiEyes]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Poi")
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request)
            if results.count > 0{
                for result in results as! [NSManagedObject]{
                    let poi = PoiEyes()
                    if let name = result.value(forKey: "name"){
                        poi.name = name as? String
                    }
                   
                    if let type = result.value(forKey: "type"){
                        poi.type = type as? String
                    }
                    if let otherInf = result.value(forKey: "otherInf"){
                        poi.otherInf = otherInf as? String
                    }
                    pois.append(poi)
                }
                print("returned Poi✅")
            }
            
        } catch  {
            print("Error in getPostdata ❌")
        }
        return pois
    }

}

