//
//  CDMDateManager.swift
//  Pods
//
//  Created by Kenyi Rodriguez on 2/03/17.
//
//

import UIKit


public class CDMDateManager: NSObject {

    public typealias CDMDiferenciaFechas = (anios : Int, meses: Int, dias: Int, horas: Int, minutos: Int, segundos: Int)
    
    public class func convertirTimestampEnDate(_ aTimestamp :  String) -> Date {
        
        if let intervalo = TimeInterval(aTimestamp) {
            return Date(timeIntervalSince1970: intervalo)
        }
        
        return Date()
    }
    
    
    
    public class func convertirTexto(_ fechaTexto : String, enDateConFormato formato : String) -> Date? {
        
        let formatoFecha = DateFormatter()
        
        formatoFecha.locale = Locale.current
        formatoFecha.dateFormat = formato
    
        return formatoFecha.date(from: fechaTexto)
    }
    
    
    
    public class func convertirFecha(_ fecha : Date, enTextoConFormato formato : String) -> String {
        
        let formatoFecha = DateFormatter()
        
        formatoFecha.locale = Locale.current
        formatoFecha.dateFormat = formato
        
        return formatoFecha.string(from: fecha)
    }
    

    
    public class func convertirFecha(_ fecha : Date, enTextoConFormato formato : String, conLocale locale : Locale) -> String {
        
        let formatoFecha = DateFormatter()
        
        formatoFecha.locale = locale
        formatoFecha.dateFormat = formato
        
        return formatoFecha.string(from: fecha)
    }
    

    
    public class func calcularDiferenciaDeAniosEntre(_ fechaInicial : Date, conFechaFinal fechaFinal : Date) -> TimeInterval{
        
        let formDate = fechaInicial.compare(fechaFinal) == .orderedAscending ? fechaInicial : fechaFinal
        let toDate = fechaInicial.compare(fechaFinal) == .orderedAscending ? fechaFinal : fechaInicial
        
        let componentes = Calendar.current.dateComponents([.year], from: formDate, to: toDate)
        
        if let diferencia = componentes.year{
            
            let factor = fechaInicial.compare(fechaFinal) == .orderedAscending ? 1 : -1
            return TimeInterval(diferencia * factor)
        }
        
        return 0
    }
    
    
    public class func calcularDiferenciaDeMesesEntre(_ fechaInicial : Date, conFechaFinal fechaFinal : Date) -> TimeInterval{
        
        let formDate = fechaInicial.compare(fechaFinal) == .orderedAscending ? fechaInicial : fechaFinal
        let toDate = fechaInicial.compare(fechaFinal) == .orderedAscending ? fechaFinal : fechaInicial
        
        let componentes = Calendar.current.dateComponents([.month], from: formDate, to: toDate)
        
        if let diferencia = componentes.month{
            
            let factor = fechaInicial.compare(fechaFinal) == .orderedAscending ? 1 : -1
            return TimeInterval(diferencia * factor)
        }
        
        return 0
    }
    
    
    
    public class func calcularDiferenciaDeDiasEntre(_ fechaInicial : Date, conFechaFinal fechaFinal : Date) -> TimeInterval{
        
        let formDate = fechaInicial.compare(fechaFinal) == .orderedAscending ? fechaInicial : fechaFinal
        let toDate = fechaInicial.compare(fechaFinal) == .orderedAscending ? fechaFinal : fechaInicial
        
        let componentes = Calendar.current.dateComponents([.day], from: formDate, to: toDate)
    
        if let diferencia = componentes.day{
            
            let factor = fechaInicial.compare(fechaFinal) == .orderedAscending ? 1 : -1
            return TimeInterval(diferencia * factor)
        }
        
        return 0
    }
    
    
    public class func calcularDiferenciaDeHorasEntre(_ fechaInicial : Date, conFechaFinal fechaFinal : Date) -> TimeInterval{
        
        let formDate = fechaInicial.compare(fechaFinal) == .orderedAscending ? fechaInicial : fechaFinal
        let toDate = fechaInicial.compare(fechaFinal) == .orderedAscending ? fechaFinal : fechaInicial
        
        let componentes = Calendar.current.dateComponents([.hour], from: formDate, to: toDate)
        
        if let diferencia = componentes.hour{
            
            let factor = fechaInicial.compare(fechaFinal) == .orderedAscending ? 1 : -1
            return TimeInterval(diferencia * factor)
        }
        
        return 0
    }
    
    
    public class func calcularDiferenciaDeMinutosEntre(_ fechaInicial : Date, conFechaFinal fechaFinal : Date) -> TimeInterval{
        
        let formDate = fechaInicial.compare(fechaFinal) == .orderedAscending ? fechaInicial : fechaFinal
        let toDate = fechaInicial.compare(fechaFinal) == .orderedAscending ? fechaFinal : fechaInicial
        
        let componentes = Calendar.current.dateComponents([.minute], from: formDate, to: toDate)
        
        if let diferencia = componentes.minute{
            
            let factor = fechaInicial.compare(fechaFinal) == .orderedAscending ? 1 : -1
            return TimeInterval(diferencia * factor)
        }
        
        return 0
    }
    
    
    public class func calcularDiferenciaDeSegundosEntre(_ fechaInicial : Date, conFechaFinal fechaFinal : Date) -> TimeInterval{
        
        let formDate = fechaInicial.compare(fechaFinal) == .orderedAscending ? fechaInicial : fechaFinal
        let toDate = fechaInicial.compare(fechaFinal) == .orderedAscending ? fechaFinal : fechaInicial
        
        let componentes = Calendar.current.dateComponents([.second], from: formDate, to: toDate)
        
        if let diferencia = componentes.second{
            
            let factor = fechaInicial.compare(fechaFinal) == .orderedAscending ? 1 : -1
            return TimeInterval(diferencia * factor)
        }
        
        return 0
    }

    
    public class func calcularDiferenciaDeFechasEntre(_ fechaInicial : Date, conFechaFinal fechaFinal : Date) -> CDMDiferenciaFechas{
        
        let formDate = fechaInicial.compare(fechaFinal) == .orderedAscending ? fechaInicial : fechaFinal
        let toDate = fechaInicial.compare(fechaFinal) == .orderedAscending ? fechaFinal : fechaInicial
        
        let componentesDiferencia = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: formDate, to: toDate)
        let factor = fechaInicial.compare(fechaFinal) == .orderedAscending ? 1 : -1
        
        let diferenciaEntreFechas : CDMDiferenciaFechas
        
        diferenciaEntreFechas.anios      = componentesDiferencia.year!   * factor
        diferenciaEntreFechas.meses      = componentesDiferencia.month!  * factor
        diferenciaEntreFechas.dias       = componentesDiferencia.day!    * factor
        diferenciaEntreFechas.horas      = componentesDiferencia.hour!   * factor
        diferenciaEntreFechas.minutos    = componentesDiferencia.minute! * factor
        diferenciaEntreFechas.segundos   = componentesDiferencia.second! * factor
        
        return diferenciaEntreFechas
    }
}
