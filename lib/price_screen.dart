import 'package:bitconticl/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'dart:convert';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurr = 'USD';
  double value1 = 0.0;
  double value2 = 0.0;
  double value3 = 0.0;

  bool isloading = true;

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurr,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurr = value!;
          getBTCData();
          getETHData();
          getLTCData();
        });
      },
    );
  }
  //{currenciesList.indexOf(selectedCurr)}

  Future getBTCData() async {
    var url =
        "https://rest.coinapi.io/v1/exchangerate/BTC/$selectedCurr?apikey=C2AFD9D6-6742-4D82-82A2-699D08115930";

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;
      value1 = jsonDecode(data)['rate'];
      print(response.body);

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future getETHData() async {
    var url =
        "https://rest.coinapi.io/v1/exchangerate/ETH/$selectedCurr?apikey=C2AFD9D6-6742-4D82-82A2-699D08115930";

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;
      value2 = jsonDecode(data)['rate'];
      print(response.body);

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future getLTCData() async {
    var url =
        "https://rest.coinapi.io/v1/exchangerate/LTC/$selectedCurr?apikey=C2AFD9D6-6742-4D82-82A2-699D08115930";

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;
      value3 = jsonDecode(data)['rate'];
      print(response.body);

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future getcoinData() async {
    setState(() {
      isloading = true;
    });
    getBTCData();
    getETHData();
    getLTCData();

    setState(() {
      isloading = false;
    });
  }

  CupertinoPicker iospicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      Text(currency);
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          print(selectedIndex);
        },
        children: pickerItems);
  }

  @override
  void initState() {
    super.initState();
    getcoinData();
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Center(
            child: CircularProgressIndicator(
            color: Colors.blue,
          ))
        : Scaffold(
            appBar: AppBar(
              title: Text('🤑 Coin Ticker'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 BTC = $value1 $selectedCurr',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 ETH = $value2 $selectedCurr',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 LTC = $value3 $selectedCurr',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 150.0,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 30.0),
                  color: Colors.lightBlue,
                  child: Platform.isIOS ? iospicker() : androidDropdown(),
                ),
              ],
            ),
          );
  }
}
