//
//  ViewController.swift
//  Nimbus
//
//  Created by Nutan Niraula on 12/22/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ViewControllerIdentifiable {
    
    //MARK:- variables
    @IBOutlet private var idTextField: UITextField!
    @IBOutlet private var callNetworkButton: UIButton!
    @IBOutlet private var responseTextView: UITextView!
    @IBOutlet private var imageView: UIImageView!
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //code should read like algorithm steps in viewDidLoad, you can fold rest of the functions
        styleSubViews()
        bindDataModelToResponsetextView()
        bindImageToImageView()
    }
    
    //MARK:- Foldable functions
    private func styleSubViews() {
        idTextField.keyboardType = UIKeyboardType.numberPad
        callNetworkButton.layer.cornerRadius = 10
        callNetworkButton.clipsToBounds = true
    }
    
    private func bindDataModelToResponsetextView() {
        viewModel.dataModel = { [weak self] data in
            DispatchQueue.main.async {
                self?.responseTextView.text = data.description
            }
        }
    }
    
    private func bindImageToImageView() {
        viewModel.image = { [weak self] img in
            DispatchQueue.main.async {
                self?.imageView.image = img
            }
        }
    }
    
}

//MARK:- IBActions
extension ViewController {
    
    @IBAction func onGetImageTapped(_ sender: Any) {
        viewModel.getImage()
    }
    
    @IBAction func onCallNetworkButtonTapped(_ sender: Any) {
        guard let id = Int(idTextField.text ?? "0") else {
            responseTextView.text = "Id needs to be Integer"
            return
        }
        viewModel.getData(forId: id)
    }
    
}
