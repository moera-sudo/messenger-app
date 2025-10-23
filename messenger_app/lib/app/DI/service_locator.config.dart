// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:messenger_app/app/navigation/app_router.dart' as _i912;
import 'package:messenger_app/features/chat_feature/data/repos/chat_repo.dart'
    as _i134;
import 'package:messenger_app/features/chat_feature/domain/repos/chat_interface.dart'
    as _i571;
import 'package:messenger_app/features/chat_feature/domain/usecases/get_messager.dart'
    as _i640;
import 'package:messenger_app/features/chat_feature/domain/usecases/send_message.dart'
    as _i424;
import 'package:messenger_app/features/chat_feature/ui/bloc/chat_bloc.dart'
    as _i350;
import 'package:messenger_app/features/home_feature/data/repos/home_repo.dart'
    as _i822;
import 'package:messenger_app/features/home_feature/domain/repos/home_interface.dart'
    as _i822;
import 'package:messenger_app/features/home_feature/domain/usecases/delete_chat.dart'
    as _i257;
import 'package:messenger_app/features/home_feature/domain/usecases/get_chats.dart'
    as _i545;
import 'package:messenger_app/features/home_feature/ui/bloc/home_bloc.dart'
    as _i409;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i912.AppRouter>(() => _i912.AppRouter());
    gh.lazySingleton<_i822.HomeInterface>(() => _i822.HomeRepositoryMock());
    gh.lazySingleton<_i571.ChatInterface>(() => _i134.ChatRepository());
    gh.lazySingleton<_i640.GetMessages>(
      () => _i640.GetMessages(gh<_i571.ChatInterface>()),
    );
    gh.lazySingleton<_i424.SendMessage>(
      () => _i424.SendMessage(gh<_i571.ChatInterface>()),
    );
    gh.factory<_i350.ChatBloc>(
      () => _i350.ChatBloc(
        gh<_i640.GetMessages>(),
        gh<_i424.SendMessage>(),
        gh<_i571.ChatInterface>(),
      ),
    );
    gh.lazySingleton<_i257.DeleteChat>(
      () => _i257.DeleteChat(gh<_i822.HomeInterface>()),
    );
    gh.lazySingleton<_i545.GetChats>(
      () => _i545.GetChats(gh<_i822.HomeInterface>()),
    );
    gh.factory<_i409.HomeBloc>(
      () => _i409.HomeBloc(
        getChats: gh<_i545.GetChats>(),
        repository: gh<_i822.HomeInterface>(),
      ),
    );
    return this;
  }
}
