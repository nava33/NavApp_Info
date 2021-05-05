import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      initialRoute: '/',
      routes: getRoutes(),
    );
  }

  Map<String, WidgetBuilder> getRoutes() {
    return <String, WidgetBuilder>{
      '/': (BuildContext context) => HomePage(),
      'miinfo': (BuildContext context) => MyInfo(),
    };
  }
}

class HomePage extends StatelessWidget {
  final _keyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NavApp'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.pushNamed(context, 'miinfo');
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white38,
        padding: EdgeInsets.only(left: 15.0, top: 15.0, right: 15.0, bottom: 15.0),
        child: Container(
          color: Colors.blue,
          child: Card(
            elevation: 20.0,
            color: Colors.lightBlue,
            child: Container(
              padding: EdgeInsets.only(left: 12.0, top: 12.0, right: 12.0, bottom: 12.0),
              child: Form(
                key: _keyForm,
                child: Column(
                  children: <Widget>[
                    InputText(
                      label: 'Nombre',
                      icon: Icons.person_pin,
                      validator: (String valor) {
                        if (valor.trim().length > 5) {
                          return null;
                        }
                        return 'El campo es obligatorio';
                      },
                    ),
                    InputText(
                      label: 'Dirección',
                      icon: Icons.location_on,
                      validator: (String text) {
                        if (text.trim().length > 5) {
                          return null;
                        }
                        return 'Campo obligatorio';
                      },
                    ),
                    InputText(
                      label: 'Email',
                      icon: Icons.email,
                      validator: (String text) {
                        if (text.contains('@')) {
                          return null;
                        }
                        return 'Email no válido';
                      },
                    ),
                    InputText(
                      label: 'Teléfono',
                      icon: Icons.phone,
                      validator: (String text) {
                        if (text.trim().length > 5) {
                          return null;
                        }
                        return 'Número de telefono necesario';
                      },
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    MaterialButton(
                      child: Text('Guardar'),
                      color: Colors.blue,
                      onPressed: () {
                        _submit(context);
                        //myAlert(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void myAlert(BuildContext context, String titulo, String contenido) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title: Text(titulo),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(contenido),
                SizedBox(
                  height: 10.0,
                ),
                MaterialButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  void _submit(BuildContext context) {
    final ok = _keyForm.currentState.validate();
    if (ok) {
      myAlert(context, 'Succeed', 'Registros Guardados');
    } else {
      myAlert(context, 'Error', 'Validaciones pendientes');
    }
  }
}

class MyInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Info'),
      ),
      body: Center(
        child: FlutterLogo(
          size: 225.0,
          textColor: Colors.amber,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class InputText extends StatefulWidget {
  final String label;
  final IconData icon;
  final Function(String) validator;
  const InputText({Key key, @required this.label, @required this.icon, @required this.validator}) : super(key: key);

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
          suffixIcon: Icon(widget.icon),
          labelText: widget.label,
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))),
    );
  }
}
