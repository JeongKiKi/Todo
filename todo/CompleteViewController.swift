//
//  CompleteViewController.swift
//  todo
//
//  Created by 정기현 on 2023/08/10.
//

import UIKit

class CompleteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var completetableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 테이블 뷰 초기화
        completetableView = UITableView(frame: view.bounds, style: .plain)
        completetableView.delegate = self
        completetableView.dataSource = self

        // 테이블 뷰 등록
        view.addSubview(completetableView)
    }

    // 테이블 뷰 셀 개수 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodoData.shareds.count
    }

    // 테이블 뷰 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")

        let todoItem = TodoData.shareds[indexPath.row]
        if todoItem.check {
            cell.textLabel?.text = "✅ " + todoItem.willTodo // 체크된 항목은 ✅와 함께 표시
        } else {
            cell.textLabel?.text = todoItem.willTodo
        }
        return cell
    }

    // 테이블 뷰 셀 선택 처리
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택된 셀의 항목 출력
//        print("선택된 항목: \(Todo[indexPath.row])")
    }
}
