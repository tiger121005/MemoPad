//
//  MemoViewController.swift
//  MemoPad
//
//  Created by TAIGA ITO on 2024/05/08.
//

import UIKit

class MemoViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextView: UITextView!
    
    //メモのタイトルデータが格納される配列
    var titles: [String] = []
    //メモの詳細データが格納される配列
    var contents: [String] = []
    
    let saveData: UserDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - UserDefaultsから古いメモを取得
        //UserDefaultsに各キーに対応する初期値を登録
        saveData.register(defaults: ["titles": [], "contents": [] ])
        //UserDefaultsからデータを取得し、各配列に代入
        titles = saveData.object(forKey: "titles") as! [String]
        contents = saveData.object(forKey: "contents") as! [String]
        
        //MARK: - UserDefaultsから取得したメモをコンソールに表示
        print(titles)
        print(contents)
        //MARK: -
        
        titleTextField.delegate = self
    }
    

    @IBAction func saveMemo(_ sender: Any) {
        //MARK: UserDefaultsにデータを保存
        //STEP1. 入力データを変数に格納します
        let title = titleTextField.text!
        let content = contentTextView.text!
        //STEP2. 古いメモに入力データを追加します
        titles.append(title)
        contents.append(content)
        //STEP3. UserDefaultsを更新します
        saveData.set(titles, forKey: "titles")
        saveData.set(contents, forKey: "contents")
        //MARK: -
        
        //alertを出す
        let alert = UIAlertController(title: "保存", message: "メモの保存が完了しました。", preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: "OK",
                          style: .default,
                          handler: { action in
                              self.navigationController?.popViewController(animated: true)            })
        )
        present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }

}
