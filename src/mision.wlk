class Mision {
	const property habilidadesRequeridas = []
	var property peligrosidad
	
	method serCumplidaPor(responsableMision){
		self.validarCumplimiento(responsableMision)
		responsableMision.recibirDanio(peligrosidad)
		responsableMision.finalizar(self)
	}
	
	method puedeCumplir(responsableMision) = habilidadesRequeridas.all({habilidad => responsableMision.puedeUsarUna(habilidad)})
	
	method validarCumplimiento(responsableMision){
		if (not self.puedeCumplir(responsableMision)) self.error("El responsable de la mision no se encuentra en estado para cumplirla")
	}
}


class Equipo{
	const integrantes = []
	
	method puedeUsarUna(habilidad) = integrantes.any({integrante => integrante.puedeUsarUna(habilidad)})
	
	method recibirDanio(peligrosidad){
		integrantes.forEach({integrante => integrante.recibirDanio(peligrosidad / 3)})
	}
	method finalizar(mision){
		integrantes.forEach({integrante => integrante.finalizar(mision)})
	}
}