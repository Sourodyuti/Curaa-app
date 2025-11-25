import '../services/api_service.dart';
import '../models/pet_model.dart';
import '../../config/api_config.dart';

class PetRepository {
  final ApiService _apiService;

  PetRepository(this._apiService);

  Future<PetModel> createPet(PetModel pet) async {
    try {
      final response = await _apiService.post(
        ApiConfig.pets,
        data: pet.toJson(),
      );
      return PetModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create pet profile: $e');
    }
  }

  Future<PetModel?> getUserPet() async {
    try {
      final response = await _apiService.get(ApiConfig.pets);
      if (response.data != null && response.data.isNotEmpty) {
        return PetModel.fromJson(response.data[0]);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch pet profile: $e');
    }
  }

  Future<PetModel> updatePet(String petId, PetModel pet) async {
    try {
      final response = await _apiService.put(
        '${ApiConfig.pets}/$petId',
        data: pet.toJson(),
      );
      return PetModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update pet profile: $e');
    }
  }
}
