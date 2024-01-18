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
    
    var languageSelectedHandler: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavigationBar()
        configureTableView()
    }
    
    func setMode(mode: Mode, current: String) {
        self.mode = mode
        currnetLanguage = current
    }
    
    func popViewController(key: String) {
        languageSelectedHandler?(key)
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Custom UI
extension LanguageViewController {
    func configureUI() { }
    
    func configureNavigationBar() { 
        navigationItem.title = mode == .source ? "원본 언어 선택": "번역 언어 선택"
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
        
        popViewController(key: key)
    }
}
