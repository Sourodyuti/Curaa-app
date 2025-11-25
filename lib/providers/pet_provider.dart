import 'package:flutter/material.dart';
import '../data/models/pet_model.dart';
import '../data/repositories/pet_repository.dart';
import '../core/utils/storage_helper.dart';

class PetProvider extends ChangeNotifier {
  final PetRepository _petRepository;

  PetModel? _pet;
  bool _isLoading = false;
  String? _error;
  bool _hasCompletedOnboarding = false;

  PetModel? get pet => _pet;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasCompletedOnboarding => _hasCompletedOnboarding;

  PetProvider(this._petRepository);

  Future<void> checkOnboardingStatus() async {
    _hasCompletedOnboarding = StorageHelper.getBool(StorageKeys.petOnboarded) ?? false;
    if (_hasCompletedOnboarding) {
      await fetchPet();
    }
    notifyListeners();
  }

  Future<void> fetchPet() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _pet = await _petRepository.getUserPet();
      _hasCompletedOnboarding = _pet?.profileCompleted ?? false;
      await StorageHelper.saveBool(StorageKeys.petOnboarded, _hasCompletedOnboarding);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createPet(PetModel pet) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _pet = await _petRepository.createPet(pet);
      _hasCompletedOnboarding = true;
      await StorageHelper.saveBool(StorageKeys.petOnboarded, true);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updatePet(PetModel pet) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _pet = await _petRepository.updatePet(pet.id!, pet);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
