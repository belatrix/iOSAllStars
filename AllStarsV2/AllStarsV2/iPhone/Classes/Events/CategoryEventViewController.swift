//
//  CategoryEventViewController.swift
//  AllStarsV2
//
//  Created by Daniel Vasquez Fernandez on 8/24/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

protocol CategoryEventViewControllerDelegate{
    func categoryEventViewController(_ viewController : CategoryEventViewController, showAllSegueWithEventArray eventArray : [EventBE])
    func categoryEventViewController(_ viewController : CategoryEventViewController, didFinishLoadData arrayEvents :[EventBE])
}

enum EventsViewControllerSegue : String {
    case userEvents
    case localEvents
    case otherEvents
}

class CategoryEventViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var clvEvents: UICollectionView!
    @IBOutlet weak var btnSeeAll: UIButton!
    @IBOutlet weak var loadingView: CDMLoadingView!
    
    var arrayEvents = [EventBE]()
    var segueIdentifierClass = EventsViewControllerSegue.localEvents
    var delegate : CategoryEventViewControllerDelegate!
   
    
    
    // MARK: - CategoryEventViewController's methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuraciones adicionales.
        self.btnSeeAll.isHidden = true /* Por defecto, el botón "Se all" está oculto. Solo se muestra en caso hayan eventos (se podría considerar que solamente se muestre en caso la cantidad de eventos sobrepase un número mínimo, pero eso depende de qué es lo exactamente retornan los servicio web.) */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Configuraciones adicionales.
        switch self.segueIdentifierClass {
            case .userEvents: self.getUserEvents() /* Obtener los eventos del usuario. */
            case .localEvents: self.getLocalEvents() /* Obtener los eventos locales. */
            case .otherEvents: self.getOtherEvents() /* Obtener otra categoría de eventos. */
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EventDetailViewController" {
            let controller = segue.destination as! EventDetailViewController
            controller.objEvent = sender as? EventBE
        }
    }
    
    
    
    
    
    // MARK: - My own methods
    
    /**
     Método para mostrar los eventos que descargaron del servicio web.
     - Parameters:
         - events: Los eventos descargados y que se van a mostrar.
         - emptyErrorMessage: Mensaje de error para mostrar si no hay eventos.
     */
    private func show(events: [EventBE], emptyErrorMessage: String) {
        self.arrayEvents = events
        self.btnSeeAll.isHidden = (events.isEmpty == true) /* Ocultar el botón "See all" si no hay eventos. */
        
        self.clvEvents.performBatchUpdates({
            self.clvEvents.reloadSections(IndexSet(integer: 0))
        }, completion: nil)
        
        (events.isEmpty == true) ? self.loadingView.mostrarError(conMensaje: emptyErrorMessage, conOpcionReintentar: false) : self.loadingView.detenerLoading()
        self.delegate.categoryEventViewController(self, didFinishLoadData: events)
    }
    
    /**
     Método para descargar los eventos locales.
     */
    func getLocalEvents() {
        self.loadingView.iniciarLoading(conMensaje: "No local events found".localized, conAnimacion: true)
        EventBC.listLocalEvents(withSuccessful: { (arrayLocalEvents, nextPage) in
            self.show(events: arrayLocalEvents, emptyErrorMessage: "No local events found".localized)
        }) { (title, message) in
            self.loadingView.mostrarError(conMensaje: message, conOpcionReintentar: false)
        }
    }
    
    /**
     Método para descargar los eventos que no son locales.
     */
    func getOtherEvents() {
        self.loadingView.iniciarLoading(conMensaje: "No other events found".localized, conAnimacion: true)
        EventBC.listOtherEvents(withSuccessful: { (arrayOtherEvents, nextPage) in
            self.show(events: arrayOtherEvents, emptyErrorMessage: "No other events found".localized)
        }) { (title, message) in
            self.loadingView.mostrarError(conMensaje: message, conOpcionReintentar: false)
        }
    }
    
    /**
     Método para descargar los eventos a los que el usuario se ha registrado.
     */
    func getUserEvents() {
        self.loadingView.iniciarLoading(conMensaje: "No events found".localized, conAnimacion: true)
        EventBC.listUserEvents(withSuccessful: { (arrayUserEvents, nextPage) in
            self.show(events: arrayUserEvents, emptyErrorMessage: "No events found".localized)
        }) { (title, message) in
            self.loadingView.mostrarError(conMensaje: message, conOpcionReintentar: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    
    // MARK: - UICollectionViewDataSource and UICollectionViewDelegateFlowLayout methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayEvents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "EventCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! EventCollectionViewCell
        cell.objEvent = self.arrayEvents[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EventDetailViewController", sender: self.arrayEvents[indexPath.row])
    }

    
    
    
    
    // MARK: - @IBAction/action methods
     
     @IBAction func clickBtnShowAll(_ sender: Any) {
        self.delegate.categoryEventViewController(self, showAllSegueWithEventArray: arrayEvents)
     }
    
}
