//
//  ViewController.swift
//  testForSnapkit
//
//  Created by 양유진 on 2022/04/09.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    lazy var greenBox = { () -> UIView in
        let view = UIView()
        view.backgroundColor = .green
        
        return view
    }()
    
    lazy var redBox = { () -> UIView in
        let view = UIView()
        view.backgroundColor = .red
        
        return view
    }()
    
    lazy var yellowBox = { () -> UIView in
        let view = UIView()
        view.backgroundColor = .yellow
        
        return view
    }()
    
    lazy var blueBox = { () -> UIView in
        let view = UIView()
        view.backgroundColor = .blue
        
        return view
    }()
    
    lazy var myButton = { (color: UIColor) -> UIButton in
        let btn = UIButton(type: .system)
        btn.backgroundColor = color
        btn.setTitle("My Button", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        btn.layer.cornerRadius = 16
        return btn
    }
    
    var greenBoxTopNSLayoutConstraint: NSLayoutConstraint? = nil
    var greenBoxTopConstraint: Constraint? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        
        let myDarkGrayBtn = myButton(.darkGray)
        
        self.view.addSubview(yellowBox)
        self.view.addSubview(greenBox)
        self.view.addSubview(redBox)
        self.view.addSubview(blueBox)
        self.view.addSubview(myDarkGrayBtn)
  
        
        // 기존 오토레이아웃
//        yellowBox.translatesAutoresizingMaskIntoConstraints = false
//        greenBox.translatesAutoresizingMaskIntoConstraints = false
//        redBox.translatesAutoresizingMaskIntoConstraints = false
//        blueBox.translatesAutoresizingMaskIntoConstraints = false
//
//
////        yellowBox.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
////        yellowBox.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.8).isActive = true
////        yellowBox.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
////        yellowBox.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//
//        yellowBox.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
//        yellowBox.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
//        yellowBox.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
//        yellowBox.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
        
        // SnapKit
        yellowBox.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 20, left:20, bottom: 20, right:20))
//            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 100, left: 50, bottom: 50, right: 50))
        }
        
        // 기존 오토레이아웃
//        redBox.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            redBox.widthAnchor.constraint(equalToConstant: 100),
//            redBox.heightAnchor.constraint(equalToConstant: 100)
//        ])
//
        // SnapKit
        redBox.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }
        
        // 기존 오토레이아웃
//        blueBox.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            blueBox.widthAnchor.constraint(equalTo: self.redBox.widthAnchor, multiplier: 2),
//            blueBox.heightAnchor.constraint(equalTo: self.redBox.heightAnchor),
//            blueBox.topAnchor.constraint(equalTo: self.redBox.bottomAnchor, constant: 20),
//            blueBox.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
//        ])
        
        // SnapKit
        blueBox.snp.makeConstraints{ (make) in
//            make.width.height.equalTo(redBox.snp.width).dividedBy(1.5)
            make.width.equalTo(redBox.snp.width).multipliedBy(2)
            make.height.equalTo(redBox.snp.height)
            make.top.equalTo(redBox.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        // SnapKit
        myDarkGrayBtn.snp.makeConstraints{ (make) in
            make.width.equalTo(200)
            make.height.equalTo(100)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        myDarkGrayBtn.addTarget(self, action: #selector(moveGreenBoxDown), for: .touchUpInside)
        
        // 기존 오토레이아웃
//        greenBox.translatesAutoresizingMaskIntoConstraints = false
//
//        greenBoxTopNSLayoutConstraint = greenBox.topAnchor.constraint(equalTo: self.blueBox.bottomAnchor, constant: 20)
//
//        NSLayoutConstraint.activate([
//            greenBox.widthAnchor.constraint(equalToConstant: 100),
//            greenBox.heightAnchor.constraint(equalToConstant: 100),
//            greenBox.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
//
//        ])
//
//        greenBoxTopNSLayoutConstraint?.isActive = true
        
        
        // SnapKit
        greenBox.snp.makeConstraints{ (make) in
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
//            make.top.equalTo(self.blueBox.snp.bottom).offset(20)
            self.greenBoxTopConstraint = make.top.equalTo(self.blueBox.snp.bottom).offset(20).constraint
        }
        

    }

    var offset = 0
    @objc fileprivate func moveGreenBoxDown(){
        offset += 40
        print("ViewController - moveGreenBoxDown() called / offset: \(offset)")
        self.greenBoxTopConstraint?.update(offset: offset)
//        greenBoxTopNSLayoutConstraint?.constant = CGFloat(offset)
        
        UIViewPropertyAnimator(duration: 0.2, curve: .easeOut, animations: {
            self.view.layoutIfNeeded()
        }).startAnimation()
    }
}

#if DEBUG
import SwiftUI
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    
func updateUIViewController(_ uiView: UIViewController,context: Context) {
        // leave this empty
}
@available(iOS 13.0.0, *)
func makeUIViewController(context: Context) -> UIViewController{
    ViewController()
    }
}
@available(iOS 13.0, *)
struct ViewControllerRepresentable_PreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ViewControllerRepresentable()
                .ignoresSafeArea()
                .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
.previewInterfaceOrientation(.portrait)
        }
        
    }
} #endif
