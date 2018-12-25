//
//  ViewController.swift
//  Nimbus
//
//  Created by Nutan Niraula on 12/22/18.
//  Copyright © 2018 Nutan Niraula. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var callNetworkButton: UIButton!
    @IBOutlet weak var responseTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
     private let viewModel = ViewModel(todoFetchService: NimbusSessionManager(withEndPoint: ToDoDataEndPoint()), imageFetchService: NimbusSessionManager(withEndPoint: PlaceHolderImageEndPoint()))
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        bindDataModelToResponsetextView()
        bindImageToImageView()
    }
    
    private func configureViews() {
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

