import 'package:flutter/material.dart';
import 'package:mercos_challenge/models/auth_data.dart';
import 'package:mercos_challenge/utils/input_validator.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthData authData) onSubmit;

  AuthForm(this.onSubmit);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final AuthData _authData = AuthData();

  //Global key para manipular o formulário
  final GlobalKey<FormState> _formKey = GlobalKey();

  /*
   * Submete o formulário utilizando um validator
   */
  _submit() async {
    FocusScope.of(context).unfocus();
    bool isValid = _formKey.currentState.validate();

    if (isValid) {
      widget.onSubmit(_authData);
    }
  }

  void _switchView() {
    _authData.toggleMode();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Color mainColor = Theme.of(context).primaryColor;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
          child: Hero(
            tag: 'createUserContainer',
            child: Container(
              width: 400,
              height: _authData.isLogin ? 400 : 420,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Text(
                        _authData.isLogin
                            ? "Olá, \nbem-vindo devolta!"
                            : "Cadastre-se agora!",
                        style: TextStyle(
                          fontSize: 30,
                          color: mainColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      cursorColor: mainColor,
                      decoration: InputDecoration(
                        labelText: "E-mail",
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: (value) => _authData.email = value.trim(),
                      validator: (value) =>
                          InputValidator.validateEmail(value.trim()),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      cursorColor: mainColor,
                      decoration: InputDecoration(
                        labelText: "Senha",
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: (value) => _authData.password = value,
                      validator: (value) => _authData.isSignUp
                          ? InputValidator.validatePassword(value)
                          : null,
                    ),
                    SizedBox(height: 10),
                    if (_authData.isSignUp)
                      TextFormField(
                        obscureText: true,
                        cursorColor: mainColor,
                        decoration: InputDecoration(
                          labelText: "Confirme a senha",
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value != _authData.password) {
                            return "As senhas não correspondem";
                          }
                          return null;
                        },
                      ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      child: Text(
                        _authData.isLogin ? "Entrar" : "Registrar",
                        style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline1
                              .color,
                          fontSize: 20,
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColor),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          )),
                      onPressed: () => _submit(),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      child: Text(
                        _authData.isLogin
                            ? "Ainda não possui uma conta?"
                            : "Já tem uma conta?",
                        style: TextStyle(
                          fontSize: 15,
                          color: mainColor,
                        ),
                      ),
                      onPressed: () => _switchView(),
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
}
