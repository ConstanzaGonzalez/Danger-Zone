class Empleado {
	var property puesto
	var salud
	const habilidades = []
	
	method incapacitado() = salud < puesto.saludCritica() 
	
	method puedeUsarUna(habilidad) = not self.incapacitado() and self.poseeHabilidad(habilidad)
	
	method poseeHabilidad(habilidad) = habilidades.contains(habilidad)
	
	method finalizar(mision){
		if (self.sobrevive()) puesto.registrarMision(self, mision)
	}
	
	method sobrevive() = salud > 0
	
	method recibirDanio(valor){
		salud -= valor
	}
	
	method conseguirHabilidadesNuevas(mision){
		const habilidadesNuevas = mision.habilidadesRequeridas().filter({habilidad => not self.poseeHabilidad(habilidad) })
		// el filter estaria bueno que lo haga del lado de la mision, y luego el aprender habilidad el empleado
		
		habilidadesNuevas.forEach({habilidadNueva => habilidades.add(habilidadNueva)})
	}
	
}

object espia{
	//puede ser una clase pero tambien un objeto,
	//no pasa nada si hay varias referencias a este por que no hace nada siempre devuelve lo mismo
	
	method saludCritica() = 15
	
	method registrarMision(empleado, mision){
		empleado.conseguirHabilidadesNuevas(mision)
		// modificar a partir de las habilidades de la mision las habilidades del empleado
	}
	
}
class Oficinista{
	var estrellas
	
	method saludCritica() = 40 - 5 * estrellas
	
	method registrarMision(empleado, mision){
		self.ganarEstrella()
		empleado.puesto(espia)
		//ojo esto solo se puede en este caso porque es parte de la logica de oficinista
	}	
	method ganarEstrella(){
		estrellas += 1
	}
	
	method tieneEstrellasSuficientes() = estrellas == 3	
}

class Jefe inherits Empleado{
	const subordinados = []
	
	override method poseeHabilidad(habilidad) = super(habilidad) or self.subordinadosPuedenUsarUna(habilidad)
	
	method subordinadosPuedenUsarUna(habilidad) = subordinados.any({subordinado => subordinado.puedeUsarUna(habilidad)})
	
}