//
//  ToDoListView.swift
//  ToDoList
//
//  Created by 노주영 on 2023/11/09.
//

import UIKit
import SnapKit

class ToDoListView: UIViewController {
    
    var vm: ToDoListVM = ToDoListVM()

    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(ToDoListCell.self, forCellReuseIdentifier: ToDoListCell.identifier)
        
        self.setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vm.toDoList = vm.dataPasing("sample.json")
    }
    
    func setView() {
        //메인 뷰
        self.view.backgroundColor = .systemBackground
        
        //네비게이션 뷰
        self.navigationItem.title = "ToDoList"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        //테이블 뷰
        self.view.addSubview(self.tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
}

extension ToDoListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoListCell.identifier, for: indexPath) as? ToDoListCell else { return UITableViewCell() }
        
        cell.title.text = self.vm.toDoList[indexPath.row].title
        cell.descriptionData.text = self.vm.toDoList[indexPath.row].description
        if self.vm.toDoList[indexPath.row].completed {
            cell.completedImage.isHidden = false
        }
        cell.completedImage.image = UIImage(systemName: "checkmark.circle.fill")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.toDoList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ToDoListCell
        if cell.completedImage.isHidden {
            cell.completedImage.isHidden = false
            self.vm.toDoList[indexPath.row].completed = true
        } else {
            cell.completedImage.isHidden = true
            self.vm.toDoList[indexPath.row].completed = false
        }
        print(self.vm.toDoList[indexPath.row])
    }
}
