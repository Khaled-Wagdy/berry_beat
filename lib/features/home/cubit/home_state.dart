import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:bery_beat/features/home/data/model/disease_prediction_model.dart';
import 'package:bery_beat/features/home/data/model/treatment_model.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeImagePicked extends HomeState {
  final File image;
  HomeImagePicked(this.image);

  @override
  List<Object?> get props => [image];
}

class HomePredictionSuccess extends HomeState {
  final File image;
  final DiseasePredictionModel prediction;

  HomePredictionSuccess(this.image, this.prediction);

  @override
  List<Object?> get props => [image, prediction];
}

class HomeTreatmentLoading extends HomeState {
  final File image;
  final DiseasePredictionModel prediction;

  HomeTreatmentLoading(this.image, this.prediction);

  @override
  List<Object?> get props => [image, prediction];
}

class HomeTreatmentSuccess extends HomeState {
  final File image;
  final DiseasePredictionModel prediction;
  final TreatmentModel treatment;

  HomeTreatmentSuccess(this.image, this.prediction, this.treatment);

  @override
  List<Object?> get props => [image, prediction, treatment];
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
