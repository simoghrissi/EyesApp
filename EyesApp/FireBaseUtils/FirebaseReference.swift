//
//FirebaseReference.swift
//  EyesApp
//
//  Created by simo on 28/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage

enum DBFireReference
{
    case root
    case users(uid: String)
    
    // MARK: - Public
    
    func reference() -> DatabaseReference
    {
        switch self {
        case .root:
            return rootRef
        default:
            return rootRef.child(path)
        }
    }
    
    private var rootRef: DatabaseReference {
        return Database.database().reference()
    }
    
    private var path: String {
        switch self {
        case .root:
            return ""
        case .users(let uid):
            return "users/\(uid)"
        }
    }
}

enum DBFireStorage
{
    case root
    case profileImages
    
    func reference() -> StorageReference {
        switch self {
        case .root:
            return rootRef
        default:
            return rootRef.child(path)
        }
    }
    
    private var rootRef: StorageReference {
        return Storage.storage().reference()
    }
    
    private var path: String {
        switch self {
        case .root:
            return ""
        case .profileImages:
            return "profileImages"
        }
    }
}

























