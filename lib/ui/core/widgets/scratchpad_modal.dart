import 'package:flutter/material.dart';
import 'package:learnmath/ui/core/services/app_haptics.dart';

class DrawnLine {
  DrawnLine({
    required this.path,
    required this.color,
    required this.width,
    this.isEraser = false,
  });

  final List<Offset> path;
  final Color color;
  final double width;
  final bool isEraser;
}

class ScratchpadModal extends StatefulWidget {
  const ScratchpadModal({super.key});

  @override
  State<ScratchpadModal> createState() => _ScratchpadModalState();
}

class _ScratchpadModalState extends State<ScratchpadModal> {
  final List<DrawnLine> _lines = [];
  DrawnLine? _currentLine;
  Color _selectedColor = const Color(0xFF38BDF8);
  final double _strokeWidth = 3.5;
  bool _isEraser = false;

  final List<Color> _colors = const [
    Color(0xFF38BDF8),
    Color(0xFFFACC15),
    Color(0xFF4ADE80),
    Color(0xFFF472B6),
    Color(0xFFFFFFFF),
    Color(0xFFA78BFA),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0A0A0C),
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.edit_note_rounded, size: 22, color: Color(0xFF38BDF8)),
            SizedBox(width: 8),
            Text(
              'Scratchpad',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Undo',
            icon: const Icon(Icons.undo_rounded, color: Colors.white70),
            onPressed: _lines.isEmpty
                ? null
                : () {
                    AppHaptics.selection();
                    setState(() {
                      _lines.removeLast();
                    });
                  },
          ),
          IconButton(
            tooltip: 'Clear',
            icon: const Icon(Icons.delete_sweep_rounded, color: Color(0xFFEF4444)),
            onPressed: _lines.isEmpty
                ? null
                : () {
                    AppHaptics.medium();
                    setState(() {
                      _lines.clear();
                      _currentLine = null;
                    });
                  },
          ),
          IconButton(
            icon: const Icon(Icons.close_rounded, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onPanStart: (details) {
                final box = context.findRenderObject() as RenderBox?;
                if (box == null) return;
                final point = details.localPosition;
                setState(() {
                  _currentLine = DrawnLine(
                    path: [point],
                    color: _isEraser ? const Color(0xFF000000) : _selectedColor,
                    width: _isEraser ? _strokeWidth * 3.5 : _strokeWidth,
                    isEraser: _isEraser,
                  );
                });
              },
              onPanUpdate: (details) {
                if (_currentLine == null) return;
                setState(() {
                  _currentLine!.path.add(details.localPosition);
                });
              },
              onPanEnd: (details) {
                if (_currentLine != null) {
                  setState(() {
                    _lines.add(_currentLine!);
                    _currentLine = null;
                  });
                }
              },
              child: CustomPaint(
                painter: _ScratchpadPainter(
                  lines: _lines,
                  currentLine: _currentLine,
                  backgroundColor: const Color(0xFF000000),
                ),
                size: Size.infinite,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF0A0A0C),
              border: Border(
                top: BorderSide(color: Color(0xFF2E2E38), width: 1),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.brush_rounded,
                      color: !_isEraser ? _selectedColor : Colors.white54,
                    ),
                    onPressed: () {
                      AppHaptics.selection();
                      setState(() => _isEraser = false);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.auto_fix_normal_rounded,
                      color: _isEraser ? const Color(0xFF38BDF8) : Colors.white54,
                    ),
                    onPressed: () {
                      AppHaptics.selection();
                      setState(() => _isEraser = true);
                    },
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _colors.map((c) {
                          final isSelected = !_isEraser && _selectedColor == c;
                          return GestureDetector(
                            onTap: () {
                              AppHaptics.selection();
                              setState(() {
                                _selectedColor = c;
                                _isEraser = false;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: c,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? Colors.white : Colors.transparent,
                                  width: 2.5,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: c.withValues(alpha: 0.6),
                                          blurRadius: 8,
                                        )
                                      ]
                                    : null,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScratchpadPainter extends CustomPainter {
  const _ScratchpadPainter({
    required this.lines,
    required this.currentLine,
    required this.backgroundColor,
  });

  final List<DrawnLine> lines;
  final DrawnLine? currentLine;
  final Color backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = backgroundColor,
    );

    final gridPaint = Paint()
      ..color = const Color(0xFF202028).withValues(alpha: 0.6)
      ..strokeWidth = 0.8;

    const spacing = 28.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final all = [...lines, ?currentLine];

    for (final line in all) {
      if (line.path.isEmpty) continue;

      final paint = Paint()
        ..color = line.color
        ..strokeWidth = line.width
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;

      if (line.path.length == 1) {
        canvas.drawCircle(line.path.first, line.width / 2, Paint()..color = line.color);
        continue;
      }

      final path = Path();
      path.moveTo(line.path.first.dx, line.path.first.dy);
      for (int i = 1; i < line.path.length; i++) {
        final p0 = line.path[i - 1];
        final p1 = line.path[i];
        path.quadraticBezierTo(
          p0.dx,
          p0.dy,
          (p0.dx + p1.dx) / 2,
          (p0.dy + p1.dy) / 2,
        );
      }
      path.lineTo(line.path.last.dx, line.path.last.dy);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ScratchpadPainter oldDelegate) => true;
}
