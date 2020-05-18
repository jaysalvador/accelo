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
    
    @IBOutlet
    private var mapContentView: UIView?
    
    @IBOutlet
    private var detailView: UIView?
    
    @IBOutlet
    private var detailViewHeightConstraint: NSLayoutConstraint?
    
    private var mapView: GMSMapView?
    
    @IBOutlet
    private var crimeDateLabel: UILabel?
    
    @IBOutlet
    private var crimeTitleLabel: UILabel?
    
    @IBOutlet
    private var crimeStreetLabel: UILabel?
    
    @IBOutlet
    private var crimeOutcomeLabel: UILabel?
    
    // MARK: - View Model
    
    private var viewModel: ViewModelProtocol = ViewModel()
    
    // MARK: - Callbacks
    
    private var debounceMethod: (() -> Void)?
        
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
    
    private func setupMap() {
        
        let camera = GMSCameraPosition.camera(withLatitude: self.viewModel.lat, longitude: self.viewModel.lng, zoom: 6.0)
        
        self.mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        
        self.mapView?.delegate = self
        
        if let mapView = self.mapView {

            self.mapContentView?.addSubview(mapView)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) { [unowned mapView] in
            
            let zoom = GMSCameraUpdate.zoom(to: 16)
            
            mapView?.animate(with: zoom)
        }
    }
    
    private func updateDetails(with crime: Crime?) {
        
        self.detailView?.layer.cornerRadius = 20.0
        
        self.detailView?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.crimeDateLabel?.text = crime?.month?.toString(using: .dateMonthReadable)
        
        self.crimeTitleLabel?.text = crime?.title
        
        self.crimeStreetLabel?.text = crime?.location?.name
        
        self.crimeOutcomeLabel?.text = "Outcome: \(crime?.outcomeStatus?.category ?? "N/A")"
    }
    
    private func updateAnnotations() {
        
        self.mapView?.clear()
        
        if let crimes = self.viewModel.crimes, crimes.count > 0 {

            for crime in crimes {
                
                if let coordinates = crime.location?.coordinates {

                    let marker = GMSMarker()
                    marker.position = coordinates
                    marker.title = crime.title
                    marker.snippet = crime.location?.name
                    marker.map = self.mapView
                }
            }
        }
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setupViewModel()
        
        self.setupMap()
        
        self.updateDetails(with: nil)
        
        self.showDetails(false)
    }

    // MARK: - GMSMapViewDelegate
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
                
        self.viewModel.lat = position.target.latitude
        
        self.viewModel.lng = position.target.longitude
        
        if mapView.selectedMarker == nil {
            
            self.debounceMethod?()
        }
        else {
            
            self.showDetails(true)
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {

        mapView.selectedMarker = marker
        
        mapView.animate(toLocation: marker.position)

        let crime = self.viewModel.getCrime(with: marker.position, title: marker.title)
        
        self.updateDetails(with: crime)

        return true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {

        if gesture {
            
            mapView.selectedMarker = nil
            
            self.showDetails(false)
        }
    }

    // MARK: - Actions
    
    private func showDetails(_ show: Bool, completion: ((Bool) -> Void)? = nil) {
        
        self.detailViewHeightConstraint?.constant = show ? 150 : 0
        
        UIView.animate(
            withDuration: 0.175,
            delay: 0.175,
            options: .curveLinear,
            animations: {[weak self] in
                    
                self?.view.layoutIfNeeded()
            },
            completion: completion
        )
    }
    
    @IBAction func dismissDetailView(_ sender: Any) {
        
        self.showDetails(false)
    }
}
