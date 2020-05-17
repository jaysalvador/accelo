//
//  ViewController.swift
//  Accelo
//
//  Created by Jay Salvador on 17/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit
import AcceloCrimeAPI
import GoogleMaps

class ViewController: UIViewController, GMSMapViewDelegate {
    
    // MARK: - View Model
    
    private var viewModel: ViewModelProtocol = ViewModel()
    
    // MARK: - Callbacks
    
    private var debounceMethod: (() -> Void)?
    
    private var mapView: GMSMapView?
        
    // MARK: - Setup
    
    private func setupViewModel() {
        
        self.viewModel.onUpdated = { [weak self] in
            
            self?.updateAnnotations()
        }
        
        self.viewModel.onError = { [weak self] in
            
            DispatchQueue.main.async {
                
                let error = self?.viewModel.error
                
                let alert = UIAlertController(title: error?.title, message: error?.errorDescription, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self?.present(alert, animated: true, completion: nil)
            }
        }
        
        self.debounceMethod = DispatchQueue.background.debounce(delay: .seconds(1)) { [weak self] in
            
            self?.viewModel.getCrimes()
        }
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setupViewModel()
        
        let camera = GMSCameraPosition.camera(withLatitude: self.viewModel.lat, longitude: self.viewModel.lng, zoom: 6.0)
        
        self.mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        
        self.mapView?.delegate = self
        
        if let mapView = self.mapView {

            self.view.addSubview(mapView)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) { [unowned mapView] in
            
            let zoom = GMSCameraUpdate.zoom(to: 16)
            
            mapView?.animate(with: zoom)
        }
    }
    
    private func updateAnnotations() {
        
        self.mapView?.clear()
        
        if let crimes = self.viewModel.crimes, crimes.count > 0 {

            for crime in crimes {
                
                if let coordinates = crime.location?.coordinates {

                    let marker = GMSMarker()
                    marker.position = coordinates
                    marker.title = crime.category
                    marker.snippet = crime.location?.name
                    marker.map = self.mapView
                }
            }
        }
    }

    // MARK: - GMSMapViewDelegate
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        
        print(position.target)
        
        self.viewModel.lat = position.target.latitude
        
        self.viewModel.lng = position.target.longitude
        
        self.debounceMethod?()
    }
    
}
