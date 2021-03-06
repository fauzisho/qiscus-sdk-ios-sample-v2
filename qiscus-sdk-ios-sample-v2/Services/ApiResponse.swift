//
//  ApiResponse.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/25/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import SwiftyJSON

public enum ApiResponse {
    case succeed(value: Any?)
    case failed(value: String)
    case onProgress(progress: Double)
}

public enum RequestResult<T>{
    case done(T)
    case failed(message: String)
}

class ImageFile {
    var name: String = ""
    var url: String = ""
    
    typealias BuilderClosure = (ImageFile) -> ()
    
    init(buildImageFile: BuilderClosure) {
        buildImageFile(self)
    }
}

class Response {
    class func getImageFile(data: Any) -> ImageFile {
        let dataJSON = JSON(data)
        let name = dataJSON["results"]["file"]["name"].stringValue
        let url = dataJSON["results"]["file"]["url"].stringValue
        
        let imageFile = ImageFile { img in
            img.name = name
            img.url = url
        }
        
        return imageFile
    }
    
    class func getContacts(data: Any) -> [Contact] {
        let dataJSON = JSON(data)
        let dataUsers = dataJSON["results"]["users"].arrayValue
        
        let users = dataUsers.map { Contact(withJSON: $0) }
        
        // append data except his own data
        let email = Preference.instance.getEmail()
        let usersData = users.filter({ $0.email != email })
        ContactLocal.instance.setData(usersData)
        
        return usersData
    }
}
