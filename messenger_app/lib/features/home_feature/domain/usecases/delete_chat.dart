import '../repos/home_interface.dart';
import '../../../../entities/home/chat_view.dart';
import 'package:injectable/injectable.dart';


@lazySingleton
class DeleteChat {
  final HomeInterface inter;

  DeleteChat(this.inter);

  Future<void> call() => inter.deleteChat(); 
}