//1. import the required packages here
import 'dart:convert';
import 'package:http/http.dart' as http;
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
  'KES'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
//2. Add your API URL &API Key Here
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = ' FFD13653-1FA9-4B47-BF08-9A1B9D337789';
class CoinData {
  // 3. Create the Asynchronous method getCoinData() that returns a Future (the price data).
  Future getCoinData()  async {
//4.Create a url combining the coinAPIURL with the currencies we're interested, BTC to USD.
  String  requestURL  = '$coinAPIURL/BTC/USD?apikey=$apiKey';
  //5. Making a GET  request to nthe url and wait for the response
    http.Response response  = await http.get(Uri.parse(requestURL));

    //6. check the request was successful
    if(response.statusCode==200){
      //7. Use the 'dart:convert' package to decode the JSON data that comes back from coinapi.io.
      var decodedData =jsonDecode(response.body);
      //8. Get the last price of bitcoin with the key 'last'.
      var lastPrice = decodedData['rate'];
      //9. now output the lastPrice from the method
      return  lastPrice;
    } else  {
      //10. Handle any errors that occur during the request.
      print(response.statusCode);
      //Optional: throw an error if our request fails.
      throw 'Problem with the get request';
    }
    }


  }


