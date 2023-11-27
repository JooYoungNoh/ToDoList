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

    lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(ToDoListCell.self, forCellReuseIdentifier: ToDoListCell.identifier)
        
        self.setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vm.fetchList()
    }
    
    func setView() {
        //메인 뷰
        self.view.backgroundColor = .systemBackground
        
        //네비게이션 뷰
        self.navigationItem.title = "ToDoList"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: #selector(addButtonClick(_:)))
        
        //테이블 뷰
        self.tableView.separatorStyle = .none
        self.view.addSubview(self.tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

//MARK: 액션 메소드
extension ToDoListView {
    @objc func addButtonClick(_ sender: UIBarButtonItem) {
        let addViewController = AddToDoListView()
        
        addViewController.modalPresentationStyle = .overFullScreen
        addViewController.modalTransitionStyle = .crossDissolve
        
        addViewController.delegate = self
        addViewController.vm = self.vm
        
        self.present(addViewController, animated: true)
    }
}

//MARK: 테이블 뷰 메소드
extension ToDoListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoListCell.identifier, for: indexPath) as? ToDoListCell else { return UITableViewCell() }
        
        cell.title.text = self.vm.toDoList[indexPath.row].title
        cell.descriptionData.text = self.vm.toDoList[indexPath.row].descriptionToDo
        cell.completedImage.image = UIImage(systemName: "checkmark.circle.fill")
        
        if self.vm.toDoList[indexPath.row].completed {
            cell.completedImage.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.toDoList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ToDoListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailToDoListView()
        
        detailViewController.listItem = self.vm.toDoList[indexPath.row]
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.vm.deleteListItem(indexRow: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

//MARK: tableView reloadData Delegate
extension ToDoListView: UpdateTableViewDelegate {
    func reloadData() {
        self.tableView.reloadData()
    }
}
