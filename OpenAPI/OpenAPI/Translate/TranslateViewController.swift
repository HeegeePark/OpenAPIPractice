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
    
    @IBOutlet var sourceTextView: UITextView!
    @IBOutlet var targetLabel: UILabel!
    
    lazy var sourceLanguage = Language.code["ko"] {
        didSet {
            sourceButton.setTitle(sourceLanguage, for: .normal)
        }
    }
    
    lazy var targetLanguage = Language.code["en"] {
        didSet {
            targetButton.setTitle(targetLanguage, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc func sourceButtonTapped(_ sender: UIButton) {
        pushLanguageViewcontroller(.source)
    }
    
    @objc func targetButtonTapped(_ sender: UIButton) {
        pushLanguageViewcontroller(.target)
    }
    
    @objc func swapLanguageButtonTapped(_ sender: UIButton) {
        let tempCode = sourceLanguage
        sourceLanguage = targetLanguage
        targetLanguage = tempCode
    }
    
    func pushLanguageViewcontroller(_ mode: Mode) {
        let vc = storyboard?.instantiateViewController(withIdentifier: LanguageViewController.identfiler) as! LanguageViewController
        
        let language = mode == .source ? sourceLanguage: targetLanguage
        vc.setMode(mode: mode, current: language!)
        
        vc.languageSelectedHandler = { [self] (key) in
            switch mode {
            case .source:
                // 선택 후 source, target이 동일 언어일 때, swap 처리
                if isSameLanguage(Language.code[key]!, targetLanguage!) {
                    swapLanguageButtonTapped(swapLanguageButton)
                    break
                }
                self.sourceLanguage = Language.code[key]
            case .target:
                // 선택 후 source, target이 동일 언어일 때, swap 처리
                if isSameLanguage(Language.code[key]!, sourceLanguage!) {
                    swapLanguageButtonTapped(swapLanguageButton)
                    break
                }
                self.targetLanguage = Language.code[key]
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
    }
}
