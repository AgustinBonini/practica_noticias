// parcial de 2024 noticia

class Noticia{
    const fechaDePublicacion = new Date()
    const personaPublica
    const gradoDeImportancia
    const titulo
    const desarrollo

    method noticiaDeEstaSemana() = fechaDePublicacion > new Date().minusDays(7)

    method publicadoHaceMenosDe(dias) = fechaDePublicacion > new Date().minusDays(dias)

    method importancia() = gradoDeImportancia

    method esNoticiaVaga() = desarrollo.length() < 100 

    method noticiaCopada() = self.publicadoHaceMenosDe(3) && self.importancia() >= 8

    method esSensacionalista() = titulo.contains("espectacular") || titulo.contains("increible") || titulo.contains("grandioso")

    method tituloEmpiezaConT() = titulo.take(1) == "T"

    method tieneDesarrollo() = desarrollo.length() > 0

    method tituloConMasPalabrasQue() = titulo.contains(" ") 

    method noticiaEstaBienEscrita() = self.tituloConMasPalabrasQue() && self.tieneDesarrollo()
}

class NoticiaComun inherits Noticia{
    const linksNoticias = []

    override method noticiaCopada() = super() && linksNoticias.size() > 1 
}

class NoticiaEncubierta inherits Noticia{
    const productoPublicitado
    const plataPagada

    override method esNoticiaVaga() = true

    override method noticiaCopada() = super() && plataPagada > 2000000

}

class Reportaje inherits Noticia{
    const personaReportada

    
    override method noticiaCopada() = super() && personaReportada.length().odd() 

    override method esSensacionalista() = super() && personaReportada == "Dibu Martinez"
}

class Cobertura inherits Noticia{
    const noticiasRelacionadas = []

    
    override method noticiaCopada() = super() && noticiasRelacionadas.all({noticia => noticia.noticiaCopada()}) 
}

class Periodistas{
    const fechaIngreso = new Date()
    const preferencia
    const noticias = []

    var noticiasNoCopadaPublicadasHoy = 0

    method sumarNoticiaNoCopadaHoy(){
        noticiasNoCopadaPublicadasHoy += 1
    }

    method actualizarNuevoDia(){
        noticiasNoCopadaPublicadasHoy = 0
    }

    method puedePublicarNoticia(noticia)= preferencia.quierePublicar(noticia) || noticiasNoCopadaPublicadasHoy < 2

    method publicarNoticia(noticia){
        if(self.puedePublicarNoticia(noticia)){
        noticias.add(noticia)
            if(! preferencia.quierePublicar(noticia)){ self.sumarNoticiaNoCopadaHoy() }
        }   else    {
            self.error("Ya publico 2 noticias que no prefiere")
        }
    }

    method periodistaRecienteQuePublicoEnLaSemana() = self.publicoNoticiaUltimaSemana() && self.periodistaEsReciente() 

    method publicoNoticiaUltimaSemana() = noticias.any({noticia => noticia.noticiaDeEstaSemana()})

    method periodistaEsReciente() = fechaIngreso > new Date().minusYears(1)


}

object soloNoticiasCopadas{
    method quierePublicar(noticia) = noticia.noticiaCopada()
}

object soloNoticiasSensacionalistas{
    method quierePublicar(noticia) = noticia.esSensacionalista()
}

object vago{
    method quierePublicar(noticia) = noticia.esNoticiaVaga()
}

object joseDeZer{
    method quierePublicar(noticia) = noticia.tituloEmpiezaConT()

}

object multimedio{
    const periodistas = []

    method periodistasRecientesQuePublicaronEnLaSemana() = periodistas.filter({periodista => periodista.periodistaRecienteQuePublicoEnLaSemana()})
}