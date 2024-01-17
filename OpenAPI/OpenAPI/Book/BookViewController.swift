//
//  BookViewController.swift
//  OpenAPI
//
//  Created by 박희지 on 1/17/24.
//

import UIKit

class BookViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    
    lazy var documents: [Document] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavigationBar()
        configureCollectionView()
    }
}

// MARK: - Custom UI
extension BookViewController {
    func configureUI() { 
        searchBar.delegate = self
    }
    
    func configureNavigationBar() {
        navigationItem.title = "카카오 북 검색"
    }
    
    func configureCollectionView() { 
        registerXib()
        connectProtocol()
        configureCollectionViewLayout()
    }
    
    func registerXib() {
        let xib = UINib(nibName: BookCollectionViewCell.identfiler, bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: BookCollectionViewCell.identfiler)
    }
    
    func connectProtocol() { 
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configureCollectionViewLayout() {
        collectionView.setLayout(inset: 8, spacing: 8, ratio: 1, colCount: 2)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension BookViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return documents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identfiler, for: indexPath) as! BookCollectionViewCell
        
        cell.bindItem(doc: documents[indexPath.row])
        
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension BookViewController: UISearchBarDelegate {
    // 텍스트가 바뀔 때
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    // search 버튼 클릭 시
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // text empty 바인딩
        guard !searchBar.text!.isEmpty else {
            return
        }
        
        // api 요청
        BookAPI.getSearchResult(text: searchBar.text!) { documents in
            self.documents = documents
        }
        
        searchBar.resignFirstResponder()
    }
}
