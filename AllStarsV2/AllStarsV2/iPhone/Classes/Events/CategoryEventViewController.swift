//
//  CategoryEventViewController.swift
//  AllStarsV2
//
//  Created by Daniel Vasquez Fernandez on 8/24/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

protocol CategoryEventViewControllerDelegate {
    
    func categoryEventViewController(_ viewController: CategoryEventViewController, showAllSegueWithEventArray eventArray: [EventBE])
    func categoryEventViewController(_ viewController: CategoryEventViewController, didFinishLoadData arrayEvents: [EventBE])
    func categoryEventViewController(_ viewController: CategoryEventViewController, didEventSelected event: EventBE, forCategory category: EventsViewControllerSegue, inCell cell: EventCollectionViewCell)
    
}

enum EventsViewControllerSegue : String {
    
    case userEvents
    case localEvents
    case otherEvents
    
}

class CategoryEventViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    @IBOutlet weak var clvEvents: UICollectionView!
    @IBOutlet weak var btnSeeAll: UIButton!
    @IBOutlet weak var loadingView: CDMLoadingView!
    
    var arrayEvents = [EventBE]()
    var segueIdentifierClass = EventsViewControllerSegue.localEvents
    var delegate : CategoryEventViewControllerDelegate?
   
    
    
    
    
    // MARK: - CategoryEventViewController's methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuraciones adicionales.
        self.btnSeeAll.isHidden = true /* Por defecto, el botón "Se all" está oculto. Solo se muestra en caso hayan eventos (se podría considerar que solamente se muestre en caso la cantidad de eventos sobrepase un número mínimo, pero eso depende de qué es lo exactamente retornan los servicio web.) */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Configuraciones adicionales.
        let dispatchTime: DispatchTime = (.now() + self.revealViewController().toggleAnimationDuration)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) { [weak self] in
            guard let viewController = self else { return }
            
            UIView.animate(withDuration: 0.2,
                           animations: {
                viewController.clvEvents.alpha = 0.0
            })
            
            switch viewController.segueIdentifierClass {
                case .userEvents:   viewController.getUserEvents() /* Obtener los eventos del usuario. */
                case .localEvents:  viewController.getLocalEvents() /* Obtener los eventos locales. */
                case .otherEvents:  viewController.getOtherEvents() /* Obtener otra categoría de eventos. */
            }
        }
    }
    
    
    
    
    
    // MARK: - My own methods
    
    /**
     Método para mostrar los eventos que descargaron del servicio web.
     - Parameters:
         - events: Los eventos descargados y que se van a mostrar.
         - emptyErrorMessage: Mensaje de error para mostrar si no hay eventos.
     */
    private func show(events: [EventBE],
                      emptyErrorMessage: String) {
        
        self.btnSeeAll.isHidden = (events.isEmpty == true) /* Ocultar el botón "See all" si no hay eventos. */
        
        self.arrayEvents = events
        self.clvEvents.contentOffset = CGPoint.zero
        self.clvEvents.reloadData()
        
        (events.isEmpty == true) ? self.loadingView.mostrarError(conMensaje: emptyErrorMessage, conOpcionReintentar: false) : self.loadingView.detenerLoading()
        self.delegate?.categoryEventViewController(self,
                                                   didFinishLoadData: events)
    }
    
    /**
     Método para descargar los eventos locales.
     */
    func getLocalEvents() {
        self.loadingView.iniciarLoading(conMensaje: nil, conAnimacion: true)
        
        EventBC.listLocalEvents(withSuccessful: { [weak self] (arrayLocalEvents, nextPage) in
            guard let viewController = self else { return }
            
            viewController.show(events: arrayLocalEvents,
                                emptyErrorMessage: "No_local_events_found".localized)
            viewController.clvEvents.alpha = 1.0
            
        }) { [weak self] (title, message) in
            guard let viewController = self else { return }
            viewController.loadingView.mostrarError(conMensaje: message,
                                                    conOpcionReintentar: false)
        }
    }
    
    /**
     Método para descargar los eventos que no son locales.
     */
    func getOtherEvents() {
        self.loadingView.iniciarLoading(conMensaje: nil,
                                        conAnimacion: true)
        
        EventBC.listOtherEvents(withSuccessful: { [weak self] (arrayOtherEvents, nextPage) in
            guard let viewController = self else { return }
            
            viewController.show(events: arrayOtherEvents,
                                emptyErrorMessage: "No_other_events_found".localized)
            viewController.clvEvents.alpha = 1.0
            
        }) { [weak self] (title, message) in
            guard let viewController = self else { return }
            viewController.loadingView.mostrarError(conMensaje: message,
                                                    conOpcionReintentar: false)
        }
    }
    
    /**
     Método para descargar los eventos a los que el usuario se ha registrado.
     */
    func getUserEvents() {
        self.loadingView.iniciarLoading(conMensaje: nil, conAnimacion: true)
        
        EventBC.listUserEvents(withSuccessful: { [weak self] (arrayUserEvents, nextPage) in
            guard let viewController = self else { return }
            
            viewController.show(events: arrayUserEvents,
                                emptyErrorMessage: "No_events_found".localized)
            viewController.clvEvents.alpha = 1.0
            
        }) { [weak self] (title, message) in
            guard let viewController = self else { return }
            viewController.loadingView.mostrarError(conMensaje: message,
                                                    conOpcionReintentar: false)
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
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = "EventCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                      for: indexPath) as! EventCollectionViewCell
        cell.objEvent = self.arrayEvents[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        let event = self.arrayEvents[indexPath.row]
        
        if collectionView.bounds.contains(cell.bounds.origin) == true && event.event_didAppear == false { /* La animación se va a aplicar solamente para las celdas que se encuentras visibles dentro del marco del UICollectionView y solamente si no ha aparecido anteriormente. */
            cell.alpha = 0.0
            cell.transform = CGAffineTransform.init(translationX: 25, y: 0.0)
            
            let duration: Double = Double(indexPath.row + 1) / 2.5
            UIView.animate(withDuration: duration,
                           delay: 0.0,
                           usingSpringWithDamping: 1.0,
                           initialSpringVelocity: 0.5,
                           options: UIViewAnimationOptions.curveEaseInOut,
                           animations: { [weak cell] in
                            
                guard let _ = cell else { return }
                cell?.alpha = 1.0
                cell?.transform = CGAffineTransform.identity
                
            }, completion: { [unowned event] (finished: Bool) in
                event.event_didAppear = true
            })
        }
    }
		
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let eventSelected = self.arrayEvents[indexPath.row]
        let cellSelected = collectionView.cellForItem(at: indexPath) as! EventCollectionViewCell
        self.delegate?.categoryEventViewController(self, didEventSelected: eventSelected,
                                                   forCategory: self.segueIdentifierClass,
                                                   inCell: cellSelected)
    }

    
    
    
    
    // MARK: - @IBAction/action methods
     
     @IBAction func clickBtnShowAll(_ sender: Any) {
        self.delegate?.categoryEventViewController(self, showAllSegueWithEventArray: arrayEvents)
     }
    
}
