import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _createBackground(context),
        _loginForm(context),
      ],
    ));
  }

  Widget _createBackground(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final backgroundPurple = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: <Color>[
          Color.fromRGBO(63, 63, 156, 1.0),
          Color.fromRGBO(90, 70, 178, 1.0)
        ],
      )),
    );

    final circle = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );

    final iconUser = Container(
      padding: EdgeInsets.only(top: 80.0),
      child: Column(
        children: [
          Icon(Icons.person_pin_circle, size: 100.0, color: Colors.white),
          SizedBox(
            height: 10.0,
            width: double.infinity,
          ),
          Text('Sebastian García',
              style: TextStyle(color: Colors.white, fontSize: 25.0)),
        ],
      ),
    );

    return Stack(
      children: [
        backgroundPurple,
        Positioned(child: circle, top: 90.0, left: 30.0),
        Positioned(child: circle, top: -40.0, right: -30.0),
        Positioned(child: circle, bottom: -50.0, right: -10.0),
        Positioned(child: circle, bottom: 120.0, right: 20.0),
        Positioned(child: circle, bottom: -50.0, left: -20.0),
        iconUser,
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = Provider.of(context);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
              child: Container(
            height: 180.0,
          )),
          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical: 30.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0,
                  ),
                ]),
            child: Column(
              children: <Widget>[
                Text('Login', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 60.0),
                _createEmail(bloc),
                SizedBox(height: 25.0),
                _createPassword(bloc),
                SizedBox(height: 25.0),
                _createButton(bloc, context),
              ],
            ),
          ),
          Text('Forget password'),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }

  Widget _createEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
              hintText: 'correo@correo.com',
              labelText: 'Correo electrónico',
              counterText: snapshot.data,
              errorText:
                  snapshot.error != null ? snapshot.error.toString() : null,
            ),
            onChanged: (value) => bloc.changeEmail(value),
          ),
        );
      },
    );
  }

  Widget _createPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.deepPurple),
              labelText: 'password',
              counterText: snapshot.data,
              errorText:
                  snapshot.error != null ? snapshot.error.toString() : null,
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _createButton(LoginBloc bloc, BuildContext context) {
    return StreamBuilder(
      stream: bloc.formValidateStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
              elevation: 0.0,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              )),
          onPressed: snapshot.hasData ? (){_login(bloc, context);} : null,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Login'),
          ),
        );
      },
    );
  }


  _login(LoginBloc bloc, BuildContext context){
    print('============');
    print('Email ${bloc.email}');
    print('Email ${bloc.password}');
    print('============');
    Navigator.pushReplacementNamed(context, 'home');
  }

}
