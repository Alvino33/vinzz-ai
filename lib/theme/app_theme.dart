import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF4F46E5);
    static const Color secondary = Color(0xFF8B5CF6);
      static const Color bgLight = Color(0xFFF8FAFC);
        static const Color bgDark = Color(0xFF0F172A);
          static const Color surfaceLight = Color(0xFFFFFFFF);
            static const Color surfaceDark = Color(0xFF1E293B);
              static const Color textLight = Color(0xFF0F172A);
                static const Color textDark = Color(0xFFF1F5F9);
                  static const Color mutedLight = Color(0xFF64748B);
                    static const Color mutedDark = Color(0xFF94A3B8);

                      static ThemeData light() => _base(Brightness.light);
                        static ThemeData dark() => _base(Brightness.dark);

                          static ThemeData _base(Brightness brightness) {
                              final isDark = brightness == Brightness.dark;
                                  final colorScheme = ColorScheme.fromSeed(
                                        seedColor: primary,
                                              brightness: brightness,
                                                    primary: primary,
                                                          secondary: secondary,
                                                                surface: isDark ? surfaceDark : surfaceLight,
                                                                    );

                                                                        final textTheme = GoogleFonts.plusJakartaSansTextTheme(
                                                                              ThemeData(brightness: brightness).textTheme,
                                                                                  ).apply(
                                                                                        bodyColor: isDark ? textDark : textLight,
                                                                                              displayColor: isDark ? textDark : textLight,
                                                                                                  );

                                                                                                      return ThemeData(
                                                                                                            useMaterial3: true,
                                                                                                                  brightness: brightness,
                                                                                                                        colorScheme: colorScheme,
                                                                                                                              scaffoldBackgroundColor: isDark ? bgDark : bgLight,
                                                                                                                                    textTheme: textTheme,
                                                                                                                                          splashFactory: InkSparkle.splashFactory,
                                                                                                                                                appBarTheme: AppBarTheme(
                                                                                                                                                        backgroundColor: Colors.transparent,
                                                                                                                                                                elevation: 0,
                                                                                                                                                                        surfaceTintColor: Colors.transparent,
                                                                                                                                                                                iconTheme: IconThemeData(color: isDark ? textDark : textLight),
                                                                                                                                                                                      ),
                                                                                                                                                                                          );
                                                                                                                                                                                            }
                                                                                                                                                                                            }