import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controladores/controlador_autenticacion.dart';

class FormRegistro extends ConsumerStatefulWidget {
  final String? errorText;
  const FormRegistro({
    super.key,
    this.errorText
  });
  @override
  ConsumerState<FormRegistro> createState() => _FromRegistroState();
}

class _FromRegistroState extends ConsumerState<FormRegistro> {
  final nombreCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return 
    Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/imagenes/valentina-remenar-make-a-wish-by-valentina-remenar.jpg'),
              fit: BoxFit.cover,
              alignment: Alignment(0.3, 0),
            ),
          ),
        ),

        Center(
          child: SingleChildScrollView(
            child: Padding(
            padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min, 
                mainAxisAlignment: MainAxisAlignment.center, 
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                if (widget.errorText != null)
                  Text(widget.errorText!, style: const TextStyle(color: Colors.red)),
                Padding(padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: TextField(
                    controller: nombreCtrl, 
                    style: const TextStyle(
                      fontSize: 25,
                      fontFamily: 'Roboto', // Fuente monoespaciada para mejor apariencia
                      fontWeight: FontWeight.bold                
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                      labelStyle: TextStyle(
                        fontFamily: 'Roboto',
                        letterSpacing: 0, // Restablecer el espaciado para la etiqueta
                        fontWeight: FontWeight.normal,
                        color: Colors.black54,
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 182, 220, 225),
                    ),
                  ),
                ),

                Padding(padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: TextField(
                    controller: passCtrl, 
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(12)
                    ],
                    style: const TextStyle(
                      fontSize: 25,
                      letterSpacing: 8, // Espaciado entre caracteres para simular un PIN
                      fontFamily: 'Roboto', // Fuente monoespaciada para mejor apariencia
                      fontWeight: FontWeight.bold
                    ),
                    decoration: const InputDecoration(
                      labelText: 'PIN (de 6 digitos o más)',
                      labelStyle: TextStyle(
                        fontFamily: 'Roboto',
                        letterSpacing: 0, // Restablecer el espaciado para la etiqueta
                        fontWeight: FontWeight.normal,
                        color: Colors.black54,
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 182, 220, 225),
                    ), 
                    obscureText: true,
                  ),
                ),

                const SizedBox(height: 12),

                FilledButton(
                  child: const Text('Registrar'),
                  onPressed: () {
                    final pin = passCtrl.text;
                    final nombre = nombreCtrl.text;
                    //Agregar verificación de campos
                    if(nombre.isEmpty || pin.isEmpty) {
                      final snackBar = SnackBar(content: Text('Por favor, complete todos los campos.'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    if(pin.length < 6) {
                      final snackBar = SnackBar(content: Text('El PIN debe tener al menos 6 dígitos.'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    ref.read(authControllerProvider.notifier).crearTutor(
                      nombre: nombre,
                      secret: pin, 
                    );
                  },
                ),
              ]),
            ),
          )
        ),
      ],
    );
  }
}