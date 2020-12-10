import 'package:flutter/material.dart';
import 'package:strength_together/services/auth.dart';
import 'package:strength_together/shared/constants.dart';
import 'package:strength_together/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;


  //text field state
  String email = '';
  String password = '';
  String name = '';
  String counselorEmail = '';
  String error = '';

  bool counselor = true;
  bool student = false;

  bool _signPhase1 = true;
  bool _signPhase2 = false;
  bool _student = false;

  @override
  Widget build(BuildContext context) {

    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Text(
          'Sign up',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.yellow,
          ),
        ),
        actions: <Widget>[
          Visibility(
              child: FlatButton.icon(
                onPressed: () async{
                  setState(() {
                    _signPhase1 = !_signPhase1;
                    _signPhase2 = !_signPhase2;
                    _student = false;
                  });
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.yellow,
                ),
                label: Text(
                  'Back',
                  style: TextStyle(
                    color: Colors.yellow,
                  ),
                ),
              ),
            visible: _signPhase2,
          ),
          FlatButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.yellow,
              ),
              label: Text(
                'Sign in',
                style: TextStyle(
                  color: Colors.yellow,
                ),
              ),
              onPressed: () {
                widget.toggleView();
              }
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              Visibility(
                visible: _signPhase1,
                  child: Center(
                      child: RaisedButton(
                        color: Colors.black,
                        child: Text(
                          'Are you a Student?',
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () async{
                          setState(() {
                            _signPhase1 = !_signPhase1;
                            _signPhase2 = !_signPhase2;
                            _student = !_student;
                          });
                          _auth.setCounselor(student);
                        },
                      )
                  ),
              ),
              SizedBox(height: 20.0),
              Visibility(
                visible: _signPhase1,
                  child: Center(
                      child: RaisedButton(
                        color: Colors.black,
                        child: Text(
                          'Are you a Counselor?',
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () async{
                          setState(() {
                            _signPhase1 = !_signPhase1;
                            _signPhase2 = !_signPhase2;
                          });
                          _auth.setCounselor(counselor);
                        },
                      )
                  ),
              ),
              SizedBox(height: 20.0),
              Visibility(
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val.isEmpty ? 'Enter an email': null,
                    onChanged: (val){
                      setState(() => email = val);
                    },
                  ),
                ),
                visible: _signPhase2,
              ),
              SizedBox(height: 20.0),
              Visibility(
                visible: _signPhase2,
                child: TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long': null,
                  obscureText: true,
                  onChanged: (val){
                    setState(() => password = val);
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Visibility(
                visible: _signPhase2,
                  child: TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Full Name'),
                    validator: (val) => val.isEmpty ? 'Enter your name': null,
                    onChanged: (val){
                      setState(() => name = val);
                    },
                  )
              ),
              SizedBox(height: 20.0),
              Visibility(
                visible: _student,
                  child: TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Counselors Email'),
                    validator: (val) => val.isEmpty ? 'Enter your counselor email': null,
                    onChanged: (val){
                      setState(() => counselorEmail = val);
                    },
                  )
              ),
              SizedBox(height: 20.0),
              Visibility(
                visible: _signPhase2,
                child: RaisedButton(
                    color: Colors.black,
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.yellow),
                    ),
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        setState(() => loading = true);
                        dynamic result = await _auth.registerWithEmailAndPassword(email, password, name, counselorEmail);
                        if(result == null){
                          setState(() {
                            error = 'Please supply a valid email';
                            loading = false;
                          });
                        }
                      }
                    }
                ),
              ),
              SizedBox(height:12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
