import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/chat_screen.dart';

void main() => runApp(const OfflineAiChatApp());

class OfflineAiChatApp extends StatefulWidget {
  const OfflineAiChatApp({super.key});
    @override
      State<OfflineAiChatApp> createState() => _OfflineAiChatAppState();
      }

      class _OfflineAiChatAppState extends State<OfflineAiChatApp> {
        ThemeMode _themeMode = ThemeMode.system;

          void _toggleTheme() {
              setState(() {
                    _themeMode =
                              _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
                                  });
                                    }

                                      @override
                                        Widget build(BuildContext context) {
                                            return MaterialApp(
                                                  title: 'Nusa AI',
                                                        debugShowCheckedModeBanner: false,
                                                              themeMode: _themeMode,
                                                                    theme: AppTheme.light(),
                                                                          darkTheme: AppTheme.dark(),
                                                                                home: ChatScreen(onToggleTheme: _toggleTheme),
                                                                                    );
                                                                                      }
                                                                                      }