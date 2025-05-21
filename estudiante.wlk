import carrera.*
import materia.*
import nota.*


class Estudiante {
    var property legajo = 0
    const property materiasAprobadas = #{}
    const property materias = #{}
    const property carreras = #{}

    method comenzarCarrera(carrera) {
        carreras.add(carrera)
    }

    method comenzarMateria(materia) {
        materia.add(materia)
    }

    method validarMateriaAprobada(materia) {
        if (materiasAprobadas.contains(materia)){
            self.error("La materia ya fue aprobada")
        }
    }

    method nuevaNota(materia, nota) {
        self.validarMateriaAprobada(materia)
        if (nota > 6) {
            materia.aprobarEstudiante(self, nota)
            materiasAprobadas.add(materia)
            materias.remove(self)
        }
        else {
            materia.nuevaNotaEstudiante(self, nota)
            materias.remove(materia)
        }
    }

    method materiasAprobadas() {
        return materiasAprobadas.asList().length()
    }

    method aproboMateria(materia) {
        return materiasAprobadas.contains(materia)
    }

    method promedio() {
        return materiasAprobadas.asList().map({nota => nota.nota()}).sum() / materiasAprobadas.asList().length()
    }
    
    method materiasDeSusCarreras() {
        return carreras.asList().forEach({carrera => carrera.materias().flatten()})
    }

    method materiasEnListaDeEspera() {
        return self.materiasDeSusCarreras().filter({materia => materia.estaEnListaDeEspera(self)})
    }

}

object roque inherits Estudiante{
    
}
