import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';


import '../../../../entities/home/chat_view.dart';
import '../../domain/usecases/get_chats.dart';
import '../../domain/repos/home_interface.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetChats getChats;
  final HomeInterface repository;

  HomeBloc({
    required this.getChats,
    required this.repository,
  }) : super(HomeInitial()) {
    on<HomeLoadChats>(_onLoadChats);
    on<HomeRefreshChats>(_onRefreshChats);
    on<HomeDeleteChat>(_onDeleteChat);
  }

  Future<void> _onLoadChats(
      HomeLoadChats event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final chats = await getChats();
      emit(HomeLoaded(chats));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onRefreshChats(
      HomeRefreshChats event, Emitter<HomeState> emit) async {
    try {
      final chats = await getChats();
      emit(HomeLoaded(chats));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onDeleteChat(
      HomeDeleteChat event, Emitter<HomeState> emit) async {
    try {
      await repository.deleteChat(); // потом можно передать chatId
      final chats = await getChats();
      emit(HomeLoaded(chats));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
