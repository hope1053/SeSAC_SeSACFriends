//
//  MyPageViewModel.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/28.
//

import UIKit
import RxRelay

class MyPageViewModel {
    let titleObservable = BehaviorRelay<[String]>(value: ["공지사항", "자주 묻는 질문", "1:1 문의", "알림 설정", "이용 약관"])
    
    let imageObservable = BehaviorRelay<[UIImage]>(value: [UIImage(named: "notice")!, UIImage(named: "faq")!, UIImage(named: "qna")!, UIImage(named: "setting_alarm")!, UIImage(named: "permit")!])
}
