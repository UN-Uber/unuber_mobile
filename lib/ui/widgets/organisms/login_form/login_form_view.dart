// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:stacked/stacked.dart';

// Project imports:
import 'package:unuber_mobile/ui/widgets/atoms/custom_divider.dart';
import 'package:unuber_mobile/ui/widgets/atoms/entry_field.dart';
import 'package:unuber_mobile/ui/widgets/atoms/google_button.dart';
import 'package:unuber_mobile/ui/widgets/atoms/main_title.dart';
import 'package:unuber_mobile/ui/widgets/atoms/submit_button.dart';
import 'package:unuber_mobile/ui/widgets/organisms/login_form/login_form_viewmodel.dart';
import 'package:unuber_mobile/utils/colors.dart' as appColors;

/// The class LoginForm is a [StatelessWidget] used to generate a form where the user can place an email or password
class LoginForm extends StatelessWidget {
  /// Function to execute when the submit button is pressed
  final Function onSubmit;

  const LoginForm({ Key? key, required this.onSubmit }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize= MediaQuery.of(context).size;
    return ViewModelBuilder.reactive(
      builder: (BuildContext context, LoginFormViewModel model, child) => WillPopScope(
        onWillPop: null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            MainTitle(
              text: model.title,
              color: appColors.primaryVariant,
              fontSize: 30
            ),
            SizedBox(height: _screenSize.height * .025),
            Column(
              children: <Widget>[
                EntryField(
                  title: 'Correo Electrónico',
                  textType: TextInputType.emailAddress,
                  onChange: model.changeEmail,
                  errorMessage: model.error(model.emailKey)
                ),
                EntryField(
                  title: 'Contraseña',
                  textType: TextInputType.visiblePassword,
                  isPassword: true,
                  onChange: model.changePassword,
                  errorMessage: model.error(model.passwordKey)
                ),
                GestureDetector(
                  onTap: model.navigateToForgotPassword,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Olvidaste la contraseña?',
                      style: TextStyle(fontSize: 14, color: appColors.primary)
                    )
                  )
                )
              ]
            ),
            SizedBox(height: _screenSize.height * .05),
            Column(
              children: <Widget>[
                StreamBuilder(
                  stream: model.isValidForm,
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    return SubmitButton(
                      text: model.loginButtonText,
                      onPressed: () {
                        if(snapshot.hasData){
                          onSubmit();
                        }
                        else{
                          final snackBar= SnackBar(
                            backgroundColor: Colors.redAccent,
                            content: Text(model.snackBarError),
                            action: SnackBarAction(
                              label: 'Cerrar',
                              onPressed: () {}
                            )
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                    );
                  }
                ),
                CustomDivider(
                  text: 'o ingrese usando'
                ),
                GoogleButton(
                  onPressed: () => print(model.googleButtonText)
                )
              ]
            )
          ]
        )
      ),
      viewModelBuilder: () => LoginFormViewModel()
    );
  }
}