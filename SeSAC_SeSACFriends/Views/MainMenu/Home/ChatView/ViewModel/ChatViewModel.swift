//
//  ChatViewModel.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/22.
//

import Foundation

import RxSwift
import RxRelay

class ChatViewModel {
    
    let inputChatText = BehaviorRelay<String>(value: "")
    var currentTextColorIsBlack: Bool = false
}
