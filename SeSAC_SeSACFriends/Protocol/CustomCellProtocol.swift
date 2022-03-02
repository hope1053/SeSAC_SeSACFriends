//
//  CustomCellProtocol.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/03/02.
//

import Foundation

protocol BaseCell {
    static var identifier: String { get }
    func configureCell()
    func setupCellConstraint()
}
