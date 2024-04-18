import 'package:flutter/cupertino.dart';
import 'package:petty_shop_vinit/utils/colors.dart';
import 'package:petty_shop_vinit/utils/constant.dart';

import '../model/dog_model.dart';
import '../network service/database_helper.dart';
import '../network service/dog_api_service.dart';
import '../network service/network_helper.dart';

class DogProvider extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  bool _isLoading = false;
  bool _isConnected = true; // Assuming initial connection
  Dog? _currentDog;
  List<Dog> _dogs = []; // Updated list name
  String totalAmount = "0";
  int totalCartCount = 0;


  Future<void> fetchRandomDog(BuildContext context) async {
    // _setLoading(true);
    _isLoading = true;
    final isConnected = await NetworkHelper.isConnected();
    if (!isConnected) {
      // _setConnection(false);
      _isLoading = false;
      _isConnected = false;
      notifyListeners();
      return;
    }
    try {
      final dog = await DogApiService.fetchRandomDog();

      _dbHelper.insertDog(dog.message);
      // _setConnection(true);
      _isConnected = true;
      // getDogs();
      _dogs = await _dbHelper.getDogs();
      _isLoading = false;
    } on Exception catch (e) {
      showSnackBar(context, "Failed to fetch new dog, Please try again later!", colorError);
      // _setLoading(false);
      _isLoading = false;

    }
    notifyListeners();
  }



  void checkConnection() async{
    final isConnected = await NetworkHelper.isConnected();
    if (!isConnected) {
      _setConnection(false);
      _setLoading(false);
      return;
    }
    notifyListeners();
  }



  Future<List<Dog>> getDogs() async {
    _dogs = await _dbHelper.getDogs();
    _setLoading(false);
    notifyListeners();
    return _dogs;
  }

  Dog getLatestDog() => _dogs.isNotEmpty ? _dogs.last
      : Dog(id: 0, price: '0', message: 'https://img.freepik.com/photos-premium/photos-nature-couper-souffle-qui-capturent-beaute-du-monde-naturel_853677-16343.jpg?w=996', isInCart: 0);

  void addToCart(BuildContext context,Dog dog) async {
    await _dbHelper.updateDogInCart(dog.id, true);
    final index = _dogs.indexWhere((d) => d.id == dog.id);
    if (index != -1) {
      _dogs[index].isInCart = 1;
      calculateAmount();
      showSnackBar(context, "Dog added successfully!", colorSuccess);
      notifyListeners();

    }
  }

  void removeFromCart(Dog dog) async {
    await _dbHelper.deleteDog(dog.id);
    final index = _dogs.indexWhere((d) => d.id == dog.id);
    if (index != -1) {
      // _dogs.removeAt(index);
      _dogs[index].isInCart = 0;
      calculateAmount();
      notifyListeners();
    }
  }

  void clearHistory() async {
    await _dbHelper.clearHistory();
    _dogs.clear();
    notifyListeners();
  }


  void calculateAmount(){
    totalAmount = "0";
    totalCartCount = 0;


    for(Dog dog in dogs){
      if(dog.isInCart == 1){

        totalAmount = (int.parse(totalAmount) + int.parse(dog.price)).toString();
        totalCartCount++;
      }
    }
    notifyListeners();

  }

  void _setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }



  void _setConnection(bool isConnected) {
    _isConnected = isConnected;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  bool get isConnected => _isConnected;
  List<Dog> get dogs => _dogs; // Make dogs getter public (optional)
  Dog get currentDog => _currentDog!; // Make dogs getter public (optional)
}
