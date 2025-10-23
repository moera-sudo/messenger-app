import '../repos/home_interface.dart';
import '../../../../entities/home/chat_view.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetChats {
  final HomeInterface inter;

  GetChats(this.inter);

  Future<List<ChatView>> call() => inter.getChats();


}
