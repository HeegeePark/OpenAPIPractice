//
//  LanguageViewController.swift
//  OpenAPI
//
//  Created by 박희지 on 1/18/24.
//

import UIKit

enum Mode {
    case source
    case target
}

class LanguageViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var mode: Mode?
    var currnetLanguage: String?
    
    var languageSelectedHandler: ((String?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavigationBar()
        configureTableView()
    }
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        dismissViewController(key: nil)
    }
    
    func setMode(mode: Mode, current: String) {
        self.mode = mode
        currnetLanguage = current
    }
    
    func popViewController(key: String) {
        languageSelectedHandler?(key)
        navigationController?.popViewController(animated: true)
    }
    
    func dismissViewController(key: String?) {
        languageSelectedHandler?(key)
        dismiss(animated: true)
    }
}

// MARK: - Custom UI
extension LanguageViewController {
    func configureUI() { }
    
    func configureNavigationBar() { 
        navigationItem.title = mode == .source ? "원본 언어 선택": "번역 언어 선택"
        
        if mode == .target {
            // 저장 버튼
            let item = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
            navigationItem.rightBarButtonItem = item
        }
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension LanguageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Language.code.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath)
        
//        let language = Language[indexPath.row]
        let language = Language.orderedCode[indexPath.row].value
        cell.textLabel?.text = language
        cell.textLabel?.textColor = language == currnetLanguage ? .orange: .black
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let key = Language.orderedKey[indexPath.row]!
        let key = Language.orderedCode[indexPath.row].key
        
        switch mode! {
        case .source:
            popViewController(key: key)
        case .target:
            dismissViewController(key: key)
        }
    }
}
