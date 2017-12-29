//
//  UserNetwork.swift
//  EyesApp
//
//  Created by simo on 23/12/2017.
//  Copyright © 2017 simo. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire


public protocol UserNetworkProtocol {
    func getUser(post: RestBaseParams) -> Observable<RestUser>
}
public final class UserNetwork: UserNetworkProtocol {

    init() {
    }

    public func getUser(post: RestBaseParams) -> Observable<RestUser> {
        let network: Network<RestUser> = Network()
        let user: Observable<(HTTPURLResponse, RestUser)> = network.postItem("UserInfos", parameters: post.dictionary)
        return user.map({ _, restUser in return restUser})
    }
    
}

