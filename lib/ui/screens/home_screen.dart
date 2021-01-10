import 'package:flutter/material.dart';
import 'package:zakaz/ui/screens/second_screen.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();
  final _numberController = TextEditingController();

  String _imageUrl;
  String _number;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: [
          Form(
            key: _formStateKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 30, right: 30),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Ссылку на картинку',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    keyboardType: TextInputType.url,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Вставте ссылку';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _imageUrl = value;
                    },
                    controller: _urlController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 30, right: 30),
                  child: TextFormField(
                    maxLength: 1,
                    decoration: InputDecoration(
                      labelText: 'число',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if(value.isEmpty|| int.tryParse(value) == null) {
                        return 'Выводите число';
                      }
                      if(int.parse(value) < 3 || int.parse(value) > 5) {
                        return 'Выводите число в деапазоне 3 до 5';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _number = value;
                    },
                    controller: _numberController,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              if(_formStateKey.currentState.validate()) {
                _formStateKey.currentState.save();
                print(_imageUrl);
                print(_number);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondScreen(imageUrl: _imageUrl, number: _number),
                  ),
                );
              }
            },
            child: Text(
                'Далее',
                style: TextStyle(fontSize: 20)
            ),
          ),
        ],
      ),
    );
  }
}
