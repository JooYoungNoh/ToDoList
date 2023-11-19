//
//  AddToDoListView.swift
//  ToDoList
//
//  Created by 노주영 on 2023/11/19.
//

import UIKit

class AddToDoListView: UIViewController {
    
    var vm: ToDoListVM?
    var tableView: UITableView?
    
    let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 20)
        label.textAlignment = .left
        return label
    }()
    
    let titleTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 1
        return textView
    }()
    
    let warningLabel: UILabel = {
        let label = UILabel()
        label.text = "Blank found"
        label.textColor = .red
        label.font = UIFont(name: "NotoSansKR-Bold", size: 20)
        label.textAlignment = .right
        label.isHidden = true
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont(name: "NotoSansKR-Bold", size: 20)
        label.textAlignment = .left
        return label
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 1
        return textView
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Bold", size: 20)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10
        return button
    }()
    
    let addButton: UIButton = {
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
            vm?.addToDo(title: titleTextView.text, description: descriptionTextView.text)
            
            self.tableView?.reloadData()
            self.dismiss(animated: true)
        } else {
            self.warningLabel.isHidden = false
        }
    }
}

//MARK: 화면 구현 부분
extension AddToDoListView {
    func setView() {
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
            make.trailing.equalToSuperview().offset(-20)
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
            make.top.equalTo(self.view.snp.centerY).offset(50)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
