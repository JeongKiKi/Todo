
import UIKit

class AddTodoViewController: UIViewController {
    @IBOutlet var addTodo: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func actionBtn(_ sender: Any) {
        if addTodo.text != "" {
            if let inputText = addTodo.text {
                let newTodo = TodoData(willTodo: inputText, check: false)
                TodoData.shareds.append(newTodo)
                addTodo.text = nil
            }
        }
        else { return }
    }
}

class TodoData: DataTodo {
    var willTodo: String
    var check: Bool = false
    init(willTodo: String, check: Bool) {
        self.willTodo = willTodo
        self.check = check
    }

    static var shareds: [TodoData] = []
}

protocol DataTodo {
    var willTodo: String { get set }
    var check: Bool { get set }
}
