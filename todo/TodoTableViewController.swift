

import UIKit

class todoTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    var data = TodoData.shared

    // 테이블 뷰
    var tableView: UITableView!
    var addTodoBtn: UIBarButtonItem!

    @objc func buttonPressed() {
        // 버튼이 눌렸을 때 실행할 코드 작성
        let alert = UIAlertController(title: "Todo", message: "오늘할일", preferredStyle: .alert)
        let ok = UIAlertAction(title: "저장", style: .destructive) {
            _ in
            if alert.textFields?.first?.text != "" {
                if let inputText = alert.textFields?.first?.text {
                    let newTodo = TodoData(willTodo: inputText, check: false)
                    TodoData.shareds.append(newTodo)
                    self.tableView.reloadData()
                }
            } else { return }
        }
        let cancle = UIAlertAction(title: "취소", style: .cancel) {
            _ in
        }
        alert.addAction(ok)
        alert.addAction(cancle)
        alert.addTextField()
        present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addTodoBtn = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(buttonPressed))
        navigationItem.rightBarButtonItem = addTodoBtn
        // 테이블 뷰 초기화
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self

        // 테이블 뷰 등록
        view.addSubview(tableView)
    }

    // 테이블 뷰 셀 개수 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodoData.shareds.count
    }

    // 테이블 뷰 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")

        let todoItem = TodoData.shareds[indexPath.row]
        cell.textLabel?.text = todoItem.willTodo

        let switchView = UISwitch()
        switchView.isEnabled = true
        switchView.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)

        cell.accessoryView = switchView
        switchView.isOn = todoItem.check

        if todoItem.check {
            let attributedText = NSAttributedString(string: todoItem.willTodo, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            cell.textLabel?.attributedText = attributedText
            cell.textLabel?.textColor = .red
        } else {
            cell.textLabel?.textColor = .black
        }

        return cell
    }

    // 테이블 뷰 셀 선택 처리
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택된 셀의 항목 출력
    }

    @objc func switchChanged(_ sender: UISwitch) {
        if let cell = sender.superview as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            let todoItem = TodoData.shareds[indexPath.row]

            if sender.isOn {
                todoItem.check = true

            } else {
                todoItem.check = false
            }
            todoItem.check = sender.isOn
//            tableView.reloadRows(at: [indexPath], with: .none)
            tableView.reloadData()
        }
    }
}
