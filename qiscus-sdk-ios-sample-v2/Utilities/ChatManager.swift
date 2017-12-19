//
//  ChatManager.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/12/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import Qiscus

public func chatWithRoomId(_ roomId: String, isGroup: Bool = true, contact: Contact? = nil) -> Void {
    let chatView = Qiscus.chatView(withRoomId: roomId)
    
//    chatView.delegate = ChatManager
//    chatView.data = contact
//    if isGroup {
//        chatView.titleAction = {
//            let targetVC                        = DetailGroupVC() //DetailChatVC()
//            targetVC.id                         = roomId
//            targetVC.hidesBottomBarWhenPushed   = true
//            chatView.navigationController?.pushViewController(targetVC, animated: true)
//        }
//        
//    } else {
//        chatView.titleAction = {
//            guard let contact = contact else { return }
//            
//            let targetVC                        = DetailContactVC()
//            targetVC.enableChatButton           = false
//            targetVC.contact                    = contact
//            
//            targetVC.hidesBottomBarWhenPushed   = true
//            chatView.navigationController?.pushViewController(targetVC, animated: true)
//        }
//    }
//    
//    chatView.setBackButton(withAction: {
//        chatView.tabBarController?.selectedIndex = 0
//        _ = chatView.navigationController?.popToRootViewController(animated: true)
//    })
//    
    chatView.hidesBottomBarWhenPushed = true
    chatView.setBackTitle()
    openViewController(chatView)
}


/*
 * {email} can be contains of email or uniqueId
 * but in this case we always use value of email
 */
public func chatWithUser(_ contact: Contact) {
    guard let email = contact.email else { return }
    let chatView = Qiscus.chatView(withUsers: [email])
    
//    chatView.titleAction = {
//        let targetVC                        = DetailContactVC()
//        targetVC.enableChatButton           = false
//        targetVC.contact                    = contact
//        targetVC.hidesBottomBarWhenPushed   = true
//        chatView.navigationController?.pushViewController(targetVC, animated: true)
//    }
//
//    chatView.setBackButton(withAction: {
//        chatView.tabBarController?.selectedIndex = 0
//        _ = chatView.navigationController?.popToRootViewController(animated: true)
//    })
    
    chatView.hidesBottomBarWhenPushed = true
    chatView.setBackTitle()
    openViewController(chatView)
}

// {uniqueId} can be contains of: email/userId/phone
public func chatWithUniqueId(_ uniqueId: String) {
    let chatView = Qiscus.chatView(withUsers: [uniqueId])
    
//    chatView.titleAction = {}
//
//    chatView.setBackButton(withAction: {
//        chatView.tabBarController?.selectedIndex = 0
//        _ = chatView.navigationController?.popToRootViewController(animated: true)
//    })
    
    chatView.hidesBottomBarWhenPushed = true
    chatView.setBackTitle()
    openViewController(chatView)
}

public func createGroupChat(_ users: [String], title: String, avatarURL: String = "") {
    Qiscus.newRoom(withUsers: users, roomName: title, avatarURL: avatarURL, onSuccess: { (room) in
                    
        let chatView = Qiscus.chatView(withRoomId: room.id)
        
//        chatView.titleAction = {
//            let targetVC                        = DetailGroupVC()
//            targetVC.id                         = chatView.chatRoom?.id
//            targetVC.hidesBottomBarWhenPushed   = true
//            chatView.navigationController?.pushViewController(targetVC, animated: true)
//        }
//
//        chatView.setBackButton(withAction: {
//            chatView.tabBarController?.selectedIndex = 0
//            _ = chatView.navigationController?.popToRootViewController(animated: true)
//        })
        
        chatView.hidesBottomBarWhenPushed = true
        chatView.setBackTitle()
        openViewController(chatView)
        
    }, onError: { (error) in
        print("new room failed: \(error)")
    })
}

class ChatManager: QiscusChatVCDelegate {
    func chatVC(enableForwardAction viewController: QiscusChatVC) -> Bool {
        return false
    }
    
    func chatVC(enableInfoAction viewController: QiscusChatVC) -> Bool {
        return true
    }
    
    func chatVC(overrideBackAction viewController: QiscusChatVC) -> Bool {
        return true
    }
    
    func chatVC(backAction viewController:QiscusChatVC, room:QRoom?, data:Any?) {
        viewController.tabBarController?.selectedIndex = 0
        _ = viewController.navigationController?.popToRootViewController(animated: true)
    }
    
    func chatVC(titleAction viewController:QiscusChatVC, room:QRoom?, data:Any?) {
        guard let roomType = room?.type else { return }
        
        if roomType == QRoomType.group {
            let targetVC                        = DetailGroupVC()
            targetVC.id                         = room?.id
            targetVC.hidesBottomBarWhenPushed   = true
            viewController.navigationController?.pushViewController(targetVC, animated: true)
            
        } else {
            guard let contact = data as? Contact else { return }
            
            let targetVC                        = DetailContactVC()
            targetVC.enableChatButton           = false
            targetVC.contact                    = contact
            targetVC.hidesBottomBarWhenPushed   = true
            viewController.navigationController?.pushViewController(targetVC, animated: true)
        }
    }
    
    func chatVC(viewController:QiscusChatVC, infoActionComment comment:QComment,data:Any?) {
        //
    }
    
}
