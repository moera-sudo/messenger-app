import 'package:flutter/material.dart';
import '../../theme_view.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onSearchPressed;
  final VoidCallback? onSettingsPressed;
  final bool showSearch;
  final bool showSettings;

  const AppBarWidget({
    super.key,
    this.onSearchPressed,
    this.onSettingsPressed,
    this.showSearch = true,
    this.showSettings = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MessengerColors>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor: colors.chatBackground,
      elevation: 0,
      centerTitle: true,
      actions: [
        if (showSearch)
          IconButton(
            icon: Icon(
              Icons.search_rounded,
              color: isDark ? colors.userBubble : colors.friendBubble,
            ),
            onPressed: onSearchPressed,
            tooltip: 'Поиск',
          ),
        if (showSettings)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Icon(
                Icons.settings_outlined,
                color: isDark ? colors.userBubble : colors.friendBubble,
              ),
              onPressed: onSettingsPressed,
              tooltip: 'Настройки',
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
