//
//  FriendAgeView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/04.
//

import UIKit
import MultiSlider

class FriendAgeView: UIView, BaseView {
    
    let friendAgeLabel: UILabel = {
        let label = UILabel()
        label.text = "상대방 연령대"
        label.font = .Title4_R14
        label.textColor = .customBlack
        return label
    }()
    
    let AgeLabel: UILabel = {
        let label = UILabel()
        label.text = "18 - 35"
        label.font = .Title3_M14
        label.textColor = .brandGreen
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    let ageSlider: MultiSlider = {
        let slider = MultiSlider()
        slider.orientation = .horizontal
        slider.outerTrackColor = .gray2
        // min, max 값 설정
        slider.minimumValue = ManageInfoViewModel.shared.minAge
        slider.maximumValue = ManageInfoViewModel.shared.maxAge
        slider.value = [20, 55]
        // thumb 이미지 설정 filter_control
        slider.thumbImage = UIImage(named: "filter_control")
        // bar 색깔 설정
        slider.tintColor = .brandGreen // color of track
        slider.trackWidth = 4
        slider.hasRoundTrackEnds = true
        slider.showsThumbImageShadow = false // wide tracks look better without thumb shadow
        // Thumb끼리 겹칠 수 있도록 설정 (allow thumbs to overlap)
        slider.keepsDistanceBetweenThumbs = true
        return slider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        [friendAgeLabel, AgeLabel].forEach { subView in
            stackView.addArrangedSubview(subView)
        }
        
        [stackView, ageSlider].forEach { subView in
            self.addSubview(subView)
        }
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.trailing.leading.top.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.7)
        }
        
        ageSlider.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
}
