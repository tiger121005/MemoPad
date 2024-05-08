//
//  MemoCollectionViewController.swift
//  MemoPad
//
//  Created by TAIGA ITO on 2024/05/08.
//

import UIKit

class MemoCollectionViewController: UIViewController, UICollectionViewDataSource {
    
    // MARK: コレクションビュー
    @IBOutlet var collectionView: UICollectionView!
    
    //MARK: ユーザーデフォルト
    var saveData: UserDefaults = UserDefaults.standard
    
    //MARK: タイトルのデータを格納する配列
    var titles: [String] = []
    
    //MARK: コンテンツのデータを格納する配列
    var contents: [String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: データの取得
        saveData.register(defaults: ["titles": [], "contents": [] ])
        
        //MARK: コレクションビューの設定
        //データソースの設定
        collectionView.dataSource = self
        //レイアウトの設定
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: configuration)
    }
    
    //追加画面から戻ってきた時に反映されるようにする
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titles = saveData.object(forKey: "titles") as! [String]
        contents = saveData.object(forKey: "contents") as! [String]
        
        collectionView.reloadData()
    }
    

    //MARK: UICollectionViewDataSourceの実装
    //MARK: セルの個数を決めるメソッド
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    //MARK: セルに表示する内容を決めるメソッド
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Storyboard上で用意されたセルを読み込む
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        //セルの中身（コンテンツ）を設定できる変数を用意する
        var contentConfiguration = UIListContentConfiguration.cell()
        //タイトルを設定する
        contentConfiguration.text = titles[indexPath.item]
        //サブタイトルを設定する
        contentConfiguration.secondaryText = contents[indexPath.item]
        //セルの設定を更新する
        cell.contentConfiguration = contentConfiguration
        //セルの設定を完了する
        return cell
    }

}
