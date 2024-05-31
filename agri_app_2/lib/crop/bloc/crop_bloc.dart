import 'package:agri_app_2/crop/bloc/crop_event.dart';
import 'package:agri_app_2/crop/bloc/crop_state.dart';
import 'package:agri_app_2/crop/model/crop_model.dart';
import 'package:agri_app_2/crop/model/update_crop_model.dart';
import 'package:agri_app_2/crop/repository/crop_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CropBloc extends Bloc<CropEvent, CropState> {
  final CropRepository
      cropRepository;

  CropBloc(this.cropRepository) : super(CropInitialState()) {
    on<CreateCropEvent>((event, emit) => _createCrop(event.crop, emit));
    on<DeleteCropEvent>((event, emit) => _deleteCrop(event.cropId, emit));
    on<UpdateCropEvent>(
        (event, emit) => _updateCrop(event.cropId, event.crop, emit));
    on<GetCropsByIdEvent>(
        (event, emit) => _getCropById(event.cropId, emit));
    on<GetCropsEvent>((event, emit) => _getCrops(emit));
    on<GetOrderCropsEvent>((event, emit) => _getOrderCrops(emit));
  }

  Future<void> _createCrop(Crop crop, Emitter<CropState> emit) async {
    try {
      emit(CropLoadingState());
      await cropRepository
          .createCrop(crop);
      emit(const CropSuccessState("Crop created successfully!"));
    } catch (error) {
      emit(CropErrorState(error.toString()));
    }
  }

  Future<void> _deleteCrop(String? cropId, Emitter<CropState> emit) async {
    try {
      emit(CropLoadingState());
      await cropRepository
          .deleteCrop(cropId); // Use CropRepository instead of CropDataProvider
      emit(const CropSuccessState("Crop deleted successfully!"));
    } catch (error) {
      emit(CropErrorState(error.toString()));
    }
  }

  Future<void> _updateCrop(
      String cropId, UpdateCropDto crop, Emitter<CropState> emit) async {
    try {
      emit(CropLoadingState());
      await cropRepository.updateCrop(
          cropId, crop);
      emit(const CropSuccessState("Crop updated successfully!"));
      // emit(CropLoadedState(crops));

    } catch (error) {
      emit(CropErrorState(error.toString()));
    }
  }

  Future<void> _getCropById(int cropId, Emitter<CropState> emit) async {
    try {
      emit(CropLoadingState());
      final crops = await cropRepository.getCropById(
          cropId); // Use CropRepository instead of CropDataProvider
      emit(CropLoadedState(crops));
    } catch (error) {
      emit(CropErrorState(error.toString()));
    }
  }

  Future<void> _getCrops(Emitter<CropState> emit) async {
    try {
      emit(const CropsLoadingState());
      final crops = await cropRepository.getCrops(); // Use CropRepository instead of CropDataProvider
      emit(CropLoadedState(crops));
    } catch (error) {
      emit(CropErrorState(error.toString()));
      // emit(
      //     CropInitialState()); // Revert back to initial state if an error occurs
    }
  }

  Future<void> _getOrderCrops(Emitter<CropState> emit) async {
    try {
      emit(const CropsLoadingState());
      final crops = await cropRepository.getOrderCrops(); // Use CropRepository instead of CropDataProvider
      emit(CropLoadedState(crops));
    } catch (error) {
      emit(CropErrorState(error.toString()));
      // emit(
      //     CropInitialState()); // Revert back to initial state if an error occurs
    }
  }
}
