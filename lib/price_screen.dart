

import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);
  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  // Update the default currency to AUD, the first item in the currencyList.
  String  selectedCurrency = 'AUD';



  DropdownButton<String> androidDropdown(){
    List<DropdownMenuItem<String>> DropdownItems = [];
    for (String currency in currenciesList){
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      DropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: DropdownItems ,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;

          //2: Call getData() when the picker/dropdown changes.
          getData();

      });
  },
    );
  }

  CupertinoPicker iOSPicker (){
    List<Text> pickerItems =[];
    for (String currency in currenciesList){
      pickerItems.add(Text(currency));
      Text(currency);
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex){
        print(selectedIndex);
        setState(() {
          // Save the selected currency to the property selectedCurrency
          selectedCurrency  = currenciesList[selectedIndex];
          // Call getData() when the picker/dropdown changes.
          getData();
        });
      },
      children:pickerItems,

    );
  }
  Map<String?, String> coinValues = {};
  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    try {
      var data = await CoinData().getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    //14. Call getData() when the screen loads up. We can't call CoinData().getCoinData() directly here because we can't make initState() async.
    super.initState();

    getData();

  }
  Column makeCards() {
    List<CryptoCard> cryptoCards = [];
    for (String crypto in cryptoList) {
      cryptoCards.add(
        CryptoCard(
          cryptoCurrency: 'BTC',
          selectedCurrency: selectedCurrency,
          value:  isWaiting ? '?' : coinValues['BTC']!,
        ),
      );

    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }





  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body:  Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        makeCards(),
        Container(
          height: 150.0,
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 30.0),
          color: Colors.lightBlue,
          child: Platform.isIOS ? iOSPicker() : androidDropdown(),
        ),
      ],
    ),
    );
  }
}
class CryptoCard extends StatelessWidget {
  const CryptoCard({
    required this.value,
    required this.selectedCurrency,
    required this.cryptoCurrency,
  });

  final String value;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
