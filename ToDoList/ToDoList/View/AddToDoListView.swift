//
//  AddToDoListView.swift
//  ToDoList
//
//  Created by 노주영 on 2023/11/19.
//

import UIKit
import SnapKit

class AddToDoListView: UIViewController {
    
    weak var delegate: UpdateTableViewDelegate?
    
    var viewModel: ToDoListViewModel?
    
    var keyboardHeightConstTop: Constraint?
    var keyboardHeightConstBottom: Constraint?
    
    lazy var alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 20)
        label.textAlignment = .left
        return label
    }()
    
    lazy var titleTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 1
        return textView
    }()
    
    lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.text = "Blank found"
        label.textColor = .red
        label.font = UIFont(name: "NotoSansKR-Bold", size: 20)
        label.textAlignment = .right
        label.isHidden = true
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 20)
        label.textAlignment = .left
        return label
    }()
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 1
        return textView
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Bold", size: 20)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Bold", size: 20)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10
        return button
    }()

    //MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setView()
    }
}

//MARK: 탭 제스처
extension AddToDoListView {
    @objc func backView(_ sender: Any){
        self.dismiss(animated: true)
    }
    
    @objc func touchView(_ sender: Any){
        self.alertView.endEditing(true)
    }
    
    func uiTapCreate() {
        //탭 제스처
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backView(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        let alertTapGesture = UITapGestureRecognizer(target: self, action: #selector(touchView(_:)))
        self.alertView.addGestureRecognizer(alertTapGesture)
    }
}

//MARK: 버튼 메소드
extension AddToDoListView {
    @objc func addToDoData(_ sender: UIButton) {
        if titleTextView.text != "" && descriptionTextView.text != "" {
            self.viewModel?.addListItem(title: self.titleTextView.text, description: self.descriptionTextView.text)
            self.delegate?.reloadData()
            self.dismiss(animated: true)
        } else {
            self.warningLabel.isHidden = false
        }
    }
}

//MARK: textView 클릭 시 뷰가 올라가도록
extension AddToDoListView {
    func setKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object:nil)
            
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            self.keyboardHeightConstTop?.update(offset: (50-keyboardFrame.cgRectValue.height))
            self.keyboardHeightConstBottom?.update(offset: -(keyboardFrame.cgRectValue.height+10))
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.keyboardHeightConstTop?.update(offset: 50)
        self.keyboardHeightConstBottom?.update(offset: 0)
    }
}

//MARK: 화면 구현 부분
extension AddToDoListView {
    func setView() {
        self.setKeyboardNotification()
        self.uiTapCreate()
        
        //메인 뷰
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        //타이틀 부분
        self.alertView.addSubview(self.titleLabel)
        self.alertView.addSubview(self.titleTextView)
        self.alertView.addSubview(self.warningLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(self.alertView.snp.centerX).offset(-30)
            make.height.equalTo(30)
        }
        
        warningLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.titleLabel)
            make.leading.equalTo(self.titleLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        titleTextView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.titleLabel)
            make.trailing.equalTo(self.warningLabel)
            make.height.equalTo(30)
        }
        
        //취소, 추가 버튼
        self.cancelButton.addTarget(self, action: #selector(backView(_:)), for: .touchUpInside)
        self.addButton.addTarget(self, action: #selector(addToDoData(_:)), for: .touchUpInside)
        
        self.alertView.addSubview(self.cancelButton)
        self.alertView.addSubview(self.addButton)
        
        cancelButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(self.alertView.snp.centerX).offset(-20)
            make.height.equalTo(50)
        }
        
        addButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.leading.equalTo(self.alertView.snp.centerX).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        //설명 부분
        self.alertView.addSubview(self.descriptionLabel)
        self.alertView.addSubview(self.descriptionTextView)
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleTextView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(self.alertView.snp.centerX)
            make.height.equalTo(30)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(10)
            make.bottom.equalTo(self.cancelButton.snp.top).offset(-30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        //얼럿 뷰
        self.view.addSubview(self.alertView)
        alertView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            self.keyboardHeightConstTop = make.top.equalTo(self.view.snp.centerY).offset(50).constraint
            self.keyboardHeightConstBottom = make.bottom.equalToSuperview().constraint
        }
    }
}
