import estudiante.*
import nota.*

class Materia {
    const estudiantes = #{}
    const notasEstudiantes = #{}
    const correlativas = #{}
    const property listaDeEspera = []
    var property cupo = 0
    var property cupoMax = 30 
    var property carrera = null

    method estudiantesInscriptos(){
        return estudiantes.asList()
    }

    method anotarEstudiante(estudiante) {
        self.validarInscripcion(estudiante)
        if (cupo == 30){
            listaDeEspera.add(estudiante)
        }
        else {
            estudiantes.add(estudiante)
            cupo += cupo
            }
    }

    method validarInscripcion(estudiante) {
        self.validarEstudianteEnCarrera(estudiante)
        self.validarEstudianteCorrelativas(estudiante)
        self.validarEstudianteAprobadas(estudiante)
        self.validarEstudianteNoInscripto(estudiante)
    }

    method validarEstudianteEnCarrera(estudiante) {
        if (not estudiante.carreras().contains(carrera)){
            self.error("El estudiante no esta anotado en la carrera.")
        }
    }

    method validarEstudianteCorrelativas(estudiante) {
        if (not estudiante.materiasAprobadas().contains(correlativas)){
            self.error("El estudiante no aprobo las materias correlativas.")
        }
    }

    method validarEstudianteAprobadas(estudiante) {
        if (estudiante.aproboMateria(self)){
            self.error("El estudiante ya aprobo la materia.")
        }
    }

    method validarEstudianteNoInscripto(estudiante) {
        if (estudiantes.contains(estudiante)){
            self.error("El estudiante ya esta anotado en la materia.")
        }
    }

    method agregarSiHayListaDeEspera() {
        if (not listaDeEspera.isEmpty()){
            self.anotarEstudiante(listaDeEspera.head())
        }
    }

    method darDeBaja(estudiante) {
        if (estudiantes.contains(estudiante)){
            estudiantes.remove(estudiante)
            self.agregarSiHayListaDeEspera()
        }
        else {self.error("El estudiante no esta anotado en la materia.")}
    }


    method nuevaNota(estudianteN, notaN) {
        return new Nota(estudiante = estudianteN, nota = notaN)
    }

    method validarEstudiante(estudiante) {
        estudiantes.find({estudianteExistente => estudianteExistente.legajo() == estudiante.legajo()})
    }

    method agregarNotaEstudiante(estudiante, nota) {
        self.validarEstudiante(estudiante)          
        notasEstudiantes.add(self.nuevaNota(estudiante, nota))
    }
   
    method estaEnListaDeEspera(estudiante) {
        return listaDeEspera.contains(estudiante)
    }

}
