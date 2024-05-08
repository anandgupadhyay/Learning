//
//  DatePicket.swift
//  eBoard
//
//  Created by Anand Upadhyay on 06/05/24.
//

import Foundation
import UIKit

class MyDatePicker: UIView {
    
    @objc var changeClosure: ((Date)->())?
    @objc var dismissClosure: (()->())?

    let dPicker: UIDatePicker = {
        let v = UIDatePicker()
        return v
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    func commonInit() -> Void {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurredEffectView =  UIView()//UIVisualEffectView(effect: blurEffect)
        blurredEffectView.backgroundColor = .black.withAlphaComponent(0.2)
        let pickerHolderView: UIView = {
            let v = UIView()
            v.backgroundColor = .white
            v.layer.cornerRadius = 8
            return v
        }()
        
        dPicker.datePickerMode = .date
        [blurredEffectView, pickerHolderView, dPicker].forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
        }

        addSubview(blurredEffectView)
        pickerHolderView.addSubview(dPicker)
        addSubview(pickerHolderView)
        
        NSLayoutConstraint.activate([
            
            blurredEffectView.topAnchor.constraint(equalTo: topAnchor),
            blurredEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurredEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurredEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),

            pickerHolderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 350),
            pickerHolderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -350.0),
            pickerHolderView.centerYAnchor.constraint(equalTo: centerYAnchor),//,constant:-100
            
            dPicker.topAnchor.constraint(equalTo: pickerHolderView.topAnchor, constant: 0),
            dPicker.leadingAnchor.constraint(equalTo: pickerHolderView.leadingAnchor, constant: 0),
            dPicker.trailingAnchor.constraint(equalTo: pickerHolderView.trailingAnchor, constant: 0.0),
            dPicker.bottomAnchor.constraint(equalTo: pickerHolderView.bottomAnchor, constant: 0),
        ])
            
        if #available(iOS 14.0, *) {
            dPicker.preferredDatePickerStyle = .inline
        } else {
            // use default
        }
        
        dPicker.addTarget(self, action: #selector(didChangeDate(_:)), for: .valueChanged)
        
        let t = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
        blurredEffectView.addGestureRecognizer(t)
    }
    
    @objc func tapHandler(_ g: UITapGestureRecognizer) -> Void {
        dismissClosure?()
    }
    
    @objc func didChangeDate(_ sender: UIDatePicker) -> Void {
        changeClosure?(sender.date)
    }
}
