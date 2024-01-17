//
//  TranslateViewController.swift
//  OpenAPI
//
//  Created by 박희지 on 1/17/24.
//

import UIKit

class TranslateViewController: UIViewController {

    @IBOutlet var sourceButton: UIButton!
    @IBOutlet var targetButton: UIButton!
    @IBOutlet var swapLanguageButton: UIButton!
    @IBOutlet var translateButton: UIButton!
    
    @IBOutlet var sourceTextView: UITextView!
    @IBOutlet var targetLabel: UILabel!
    
    lazy var sourceKey = Language.orderedKey[0] {
        didSet {
            sourceButton.setTitle(sourceLanguage, for: .normal)
        }
    }
    
    var sourceLanguage: String {
        return Language.code[sourceKey!]!
    }
    
    lazy var targetKey = Language.orderedKey[1] {
        didSet {
            targetButton.setTitle(targetLanguage, for: .normal)
        }
    }
    
    var targetLanguage: String {
        return Language.code[targetKey!]!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavigationBar()
    }
    
    @objc func sourceButtonTapped(_ sender: UIButton) {
        pushLanguageViewcontroller(.source)
    }
    
    @objc func targetButtonTapped(_ sender: UIButton) {
        pushLanguageViewcontroller(.target)
    }
    
    @objc func swapLanguageButtonTapped(_ sender: UIButton) {
        swap(&sourceKey!, &targetKey!)
        swap(&sourceTextView.text, &targetLabel.text)
    }
    
    @objc func translateButtonTapped(_ sender: UIButton) {
        guard let text = sourceTextView.text, !text.isEmpty else { return }
        
        TranslateAPI.translate(source: sourceKey!, target: targetKey!, text: text) { translated in
            self.targetLabel.text = translated
        }
    }
    
    func pushLanguageViewcontroller(_ mode: Mode) {
        let vc = storyboard?.instantiateViewController(withIdentifier: LanguageViewController.identfiler) as! LanguageViewController
        
        let language = mode == .source ? sourceLanguage: targetLanguage
        vc.setMode(mode: mode, current: language)
        
        vc.languageSelectedHandler = { [self] (key) in
            switch mode {
            case .source:
                // 선택 후 source, target이 동일 언어일 때, swap 처리
                if isSameLanguage(key, targetKey!) {
                    swapLanguageButtonTapped(swapLanguageButton)
                    break
                }
                sourceKey = key
            case .target:
                // 선택 후 source, target이 동일 언어일 때, swap 처리
                if isSameLanguage(key, sourceKey!) {
                    swapLanguageButtonTapped(swapLanguageButton)
                    break
                }
                targetKey = key
            }
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func isSameLanguage(_ a: String, _ b: String) -> Bool {
        return a == b
    }
}

// MARK: - Custom UI
extension TranslateViewController {
    func configureUI() {
        sourceButton.setTitle(sourceLanguage, for: .normal)
        sourceButton.addTarget(self, action: #selector(sourceButtonTapped), for: .touchUpInside)
        
        targetButton.setTitle(targetLanguage, for: .normal)
        targetButton.addTarget(self, action: #selector(targetButtonTapped), for: .touchUpInside)
        
        swapLanguageButton.addTarget(self, action: #selector(swapLanguageButtonTapped), for: .touchUpInside)
        
        translateButton.addTarget(self, action: #selector(translateButtonTapped), for: .touchUpInside)
        
        targetLabel.numberOfLines = 0
    }
    
    func configureNavigationBar() {
        navigationItem.title = "파파고 번역"
    }
}
