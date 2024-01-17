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
    
    @IBAction func sourceButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func targetButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func swapLanguageButtonTapped(_ sender: UIButton) {
        let tempCode = sourceLanguage
        sourceLanguage = targetLanguage
        targetLanguage = tempCode
    }
}

extension TranslateViewController {
    func configureUI() {
        sourceButton.setTitle(sourceLanguage, for: .normal)
        targetButton.setTitle(targetLanguage, for: .normal)
    }
}
