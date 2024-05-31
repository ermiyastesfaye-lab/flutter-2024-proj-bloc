
import 'package:agri_app_2/crop/data_provider/crop_data_provider.dart';
import 'package:agri_app_2/crop/model/crop_model.dart';
import 'package:agri_app_2/crop/model/update_crop_model.dart';

abstract class CropRepository {
  Future<Crop> createCrop(Crop crop);
  Future<void> deleteCrop(String? cropId);
  Future<UpdateCropDto> updateCrop(String cropId, UpdateCropDto crop);
  Future<List<Crop>> getCropById(int cropId);
  Future<List<Crop>> getCrops();
  Future<List<Crop>> getOrderCrops();
}

class ConcreteCropRepository implements CropRepository {
  final CropDataProvider cropDataProvider;

  ConcreteCropRepository(this.cropDataProvider);

  @override
  Future<Crop> createCrop(Crop crop) async {
    return await cropDataProvider.createCrop(crop);
  }

  @override
  Future<void> deleteCrop(String? cropId) async {
    return await cropDataProvider.deleteCrop(cropId);
  }

  @override
  Future<UpdateCropDto> updateCrop(String cropId, UpdateCropDto crop) async {
    return await cropDataProvider.updateCrop(cropId, crop);
  }

  @override
  Future<List<Crop>> getCropById(int cropId) async {
    return await cropDataProvider.getCropById(cropId);
  }

  @override
  Future<List<Crop>> getCrops() async {
    return await cropDataProvider.getCrops();
  }

  @override
  Future<List<Crop>> getOrderCrops() async {
    return await cropDataProvider.getOrderCrops();
  }
}
