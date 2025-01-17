import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:intl/intl.dart';

///[CometChatFileBubble] creates a widget that gives file bubble
///
///used by default  when the category and type of [MediaMessage] is message and [MessageTypeConstants.file] respectively
/// ```dart
///       CometChatFileBubble(
///              theme: cometChatTheme,
///              fileUrl:
///                  'file url',
///              title: 'File bubble',
///              style: const FileBubbleStyle(borderRadius: 6),
///            );
/// ```
class CometChatFileBubble extends StatefulWidget {
  const CometChatFileBubble(
      {super.key,
      this.style,
      this.title,
      this.subtitle,
      this.fileUrl,
      this.fileMimeType,
      this.id,
      this.downloadIcon,
      this.width,
      this.height,
      this.padding,
      this.margin,
      this.alignment,
      this.fileExtension,
      this.fileSize,
      this.dateTime,
      this.metadata
      });

  ///[title] if title passed then that title is displayed instead of file name from [MediaMessage]
  final String? title;

  ///[subtitle] subtitle to displayed below title
  final String? subtitle;

  ///[fileUrl] if message message object is not passed then file url should be passed to download the file
  final String? fileUrl;

  ///[fileMimeType] file mime type to open the file if message object is not passed
  final String? fileMimeType;

  ///[style] file bubble style
  final CometChatFileBubbleStyle? style;

  ///[id] message object id to make file name unique
  final int? id;

  ///[downloadIcon] icon to press for downloading the file
  final Icon? downloadIcon;

  ///[width] width of the image bubble
  final double? width;

  ///[height] height of the image bubble
  final double? height;

  ///[padding] padding for the image bubble
  final EdgeInsetsGeometry? padding;

  ///[margin] margin for the image bubble
  final EdgeInsetsGeometry? margin;

  ///[alignment] alignment for the file bubble
  final BubbleAlignment? alignment;

  /// The extension of the file.
  final String? fileExtension;

  /// The size of the file in bytes.
  final int? fileSize;

  /// The date and time the file was sent.
  final DateTime? dateTime;

  ///[metadata] metadata of the message object
  final Map<String, dynamic>? metadata;

  @override
  State<CometChatFileBubble> createState() => _CometChatFileBubbleState();
}

class _CometChatFileBubbleState extends State<CometChatFileBubble> with TickerProviderStateMixin {
  bool isFileDownloading = false;
  bool isFileExists = false;

  String fileName = '';
  String? subtitle;
  String? fileUrl;
  String? fileMimeType;

  List<String> documentExtensions = ["doc", "docx", "md", "odt", "abw", "dot", "dotx"];
  List<String> spreadsheetExtensions = ["csv", "xls", "xlsx", "ods", "tsv", "xlt", "xltx", "numbers"];
  List<String> imageExtensions = [
    "jpg",
    "jpeg",
    "png",
    "gif",
    "bmp",
    "svg",
    "webp",
    "tiff",
    "psd",
    "heif",
    "heic",
    "icns",
    "eps"
  ];
  List<String> audioExtensions = [
    "mp3",
    "wav",
    "ogg",
    "flac",
    "aac",
    "wma",
    "aiff",
    "m4a",
    "mid",
    "midi",
    "opus",
    "amr"
  ];
  List<String> videoExtensions = [
    "mp4",
    "avi",
    "mov",
    "mkv",
    "flv",
    "wmv",
    "webm",
    "mpg",
    "mpeg",
    "3gp",
    "mts",
    "m2ts",
    "vob",
    "mxf",
    "f4v"
  ];
  List<String> pdfExtensions = ["pdf", "ps", "eps", "ai"];
  List<String> zipExtensions = ["zip", "rar", "7z", "tar", "gz", "bz2", "xz"];
  List<String> presentationExtensions = ["ppt", "pptx", "odp", "key", "pps", "ppsx", "pot", "potx", "sxi"];
  List<String> textExtensions = ["txt", "wps", "rtf", "tex", "log", "csv", "tsv", "json", "xml", "yaml", "yml"];

  final double _millisecondsInHrs = 3600000;
  int delayer = 1;


  double progress = 0.0;

  Ticker? _ticker;

  String? localPath;

  @override
  void initState() {
    super.initState();
    setParameters();

  }

  @override
  void dispose() {
    if(_ticker!=null && _ticker?.isActive==true){
      _ticker?.stop(canceled: true);
      _ticker?.dispose();
    }

    super.dispose();
  }

  late CometChatFileBubbleStyle fileBubbleStyle;
  late CometChatColorPalette colorPalette;
  late CometChatSpacing spacing;
  late CometChatTypography typography;

  @override
  void didChangeDependencies() {
    fileBubbleStyle =
        CometChatThemeHelper.getTheme<CometChatFileBubbleStyle>(
            context: context, defaultTheme: CometChatFileBubbleStyle.of)
            .merge(widget.style);
    colorPalette = CometChatThemeHelper.getColorPalette(context);
    spacing = CometChatThemeHelper.getSpacing(context);
    typography = CometChatThemeHelper.getTypography(context);
    super.didChangeDependencies();
  }


  String? getFileExtension(String? fileUrl) {
    // Decode file URL to handle encoded paths
    String decodedFileUrl = Uri.decodeFull(fileUrl ?? '');
    String fileName = decodedFileUrl.split('/').last;

    String extension = fileName.split('.').last.toLowerCase();
    return extension;
  }

  String getFileIcon(String? fileExtension) {
    String fileIcon = AssetConstants.fileUnknown;

    if (fileExtension != null) {
      if (documentExtensions.contains(fileExtension)) {
        fileIcon = AssetConstants.fileDoc;
      } else if (spreadsheetExtensions.contains(fileExtension)) {
        fileIcon = AssetConstants.fileSpreadsheet;
      } else if (imageExtensions.contains(fileExtension)) {
        fileIcon = AssetConstants.fileImage;
      } else if (audioExtensions.contains(fileExtension)) {
        fileIcon = AssetConstants.fileAudio;
      } else if (videoExtensions.contains(fileExtension)) {
        fileIcon = AssetConstants.fileVideo;
      } else if (pdfExtensions.contains(fileExtension)) {
        fileIcon = AssetConstants.filePdf;
      } else if (zipExtensions.contains(fileExtension)) {
        fileIcon = AssetConstants.fileZip;
      } else if (presentationExtensions.contains(fileExtension)) {
        fileIcon = AssetConstants.filePresentation;
      } else if (textExtensions.contains(fileExtension)) {
        fileIcon = AssetConstants.fileText;
      }
    }
    return fileIcon;
  }


  setParameters() {
    if (widget.id != null) {
      fileName += '${widget.id}';
    }
    if (widget.title != null) {
      if (fileName.isNotEmpty) {
        fileName += '_';
      }
      fileName += widget.title!;
    }
    if (widget.subtitle != null) {
      subtitle = widget.subtitle;
    }
    if (widget.fileUrl != null) {
      fileUrl = widget.fileUrl;
    }
    if (widget.fileMimeType != null) {
      fileMimeType = widget.fileMimeType;
    }

    fileExists();
  }

  fileExists() async {
    final localPath = FileUtils.getLocalFilePath(widget.metadata) ?? '';
    // Decode URL-encoded file path
    final decodedPath = Uri.decodeFull(localPath);

    if (FileUtils.isLocalFileAvailable(decodedPath)) {
      this.localPath = decodedPath;
      isFileExists = true;
    } else {
      String? path = await BubbleUtils.isFileDownloaded(fileName);

      if (path == null) {
        isFileExists = false;
      } else {
        isFileExists = true;
      }
    }
    debugPrint("File Exist $isFileExists");
    if (mounted) {
      setState(() {});
    }
  }


  openFile() async {
    if (isFileExists) {
      String filePath = localPath ?? '${BubbleUtils.fileDownloadPath}/$fileName';
      MethodChannel channel = const MethodChannel('cometchat_uikit_shared');

      try {
        final result = await channel.invokeMethod(
            'open_file', {'file_path': filePath, 'file_type': fileMimeType});
      } catch (e) {
        debugPrint('$e');
        debugPrint("Could not open file");
      }
    }
  }

  String _getFileSize(int size, {String unit = 'B'}) {
    if (size > 1024) {
      size = size ~/ 1024;
      if (unit == 'B') {
        unit = 'KB';
      } else if (unit == 'KB') {
        unit = 'MB';
      } else if (unit == 'MB') {
        unit = 'GB';
      } else if (unit == 'GB') {
        unit = 'TB';
      } else {
        return "$size $unit";
      }
      return _getFileSize(size, unit: unit);
    }
    return "$size $unit";
  }

  String _getDate(DateTime? date) {
    DateTime dateTime =
        date ?? DateTime.now(); // Replace with your DateTime object

    String formattedDate = DateFormat('d MMM, yyyy').format(dateTime);

    return formattedDate;
  }

  String _getDefaultSubtitle() {
    return "${_getDate(widget.dateTime)} • ${_getFileSize(widget.fileSize ?? 0)} • ${(widget.fileExtension ?? getFileExtension(fileUrl) ?? "").toUpperCase()}";
  }

  void _startTicker(){
    _ticker = createTicker((elapsed) {
      setState(() {
        if(elapsed.inHours==delayer){
          delayer++;
        }
        progress=elapsed.inMilliseconds/(_millisecondsInHrs*delayer);
      });
    });
    _ticker?.start();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: openFile,
      child: Container(
        height: widget.height,

        width: widget.width ?? 265,
        margin: widget.margin,
        padding: widget.padding ?? EdgeInsets.fromLTRB(spacing.padding1 ?? 0, spacing.padding2 ?? 0,0,spacing.padding1 ?? 0),
        decoration: BoxDecoration(
            color: fileBubbleStyle.backgroundColor ?? colorPalette.transparent,
            border: fileBubbleStyle.border,
            borderRadius: fileBubbleStyle.borderRadius ?? BorderRadius.circular(
                spacing.radius3 ?? 0)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              height: 32,
              getFileIcon(getFileExtension(fileUrl)),
              package: UIConstants.packageName,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: spacing.margin2 ?? 0),
              width:isFileExists? 156+18:156,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title ?? Translations.of(context).file,
                      overflow: TextOverflow.ellipsis,
                      style:  TextStyle(
                              fontSize: typography.body?.medium?.fontSize,
                              fontWeight:
                                  typography.body?.medium?.fontWeight,
                              color: getTitleColor(
                                  context, fileBubbleStyle, colorPalette)).merge(fileBubbleStyle.titleTextStyle)
                  .copyWith(color: getTitleColor(context, fileBubbleStyle, colorPalette))
                  ),
                  Text(
                    subtitle ?? _getDefaultSubtitle(),
                    style:  TextStyle(
                            fontSize:
                                typography.caption2?.regular?.fontSize,
                            fontWeight:
                                typography.caption2?.regular?.fontWeight,
                            color: getSubtitleColor(
                                context, fileBubbleStyle, colorPalette)).merge(fileBubbleStyle.subtitleTextStyle)
                    .copyWith(color: getSubtitleColor(context, fileBubbleStyle, colorPalette))
                  )
                ],
              ),
            ),
              const Spacer(),

              if(!isFileExists)SizedBox(
              child: Stack(
                alignment: Alignment.center,
                children: [

                  if(isFileDownloading) SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      value: progress,
                      backgroundColor: colorPalette.extendedPrimary200,
                      color: colorPalette.primary,
                      strokeWidth: 2.5,
                    ),
                  ),
                  IconButton(
                    onPressed: () async{
                      if (fileUrl != null) {
                        isFileDownloading = true;
                        setState(() {});
                        _startTicker();
                        String? path = await BubbleUtils.downloadFile(
                            fileUrl!, fileName);
                        if (path == null) {
                          isFileExists = false;
                        } else {
                          isFileExists = true;
                        }
                        _ticker?.stop();
                        _ticker?.dispose();

                        Timer.periodic(const Duration(milliseconds: 100), (timer) {
                          if(progress>=1.0) {
                            timer.cancel();
                          }
                          setState(() {
                            progress += 0.1;
                          });
                        },);

                        isFileDownloading = false;
                        setState(() {});
                      }
                    },
                    icon: Image.asset(
                      isFileDownloading ? AssetConstants.close : AssetConstants.download,
                      height: isFileDownloading ? 15 : 24,
                      width: isFileDownloading ? 15 : 24,
                      package: UIConstants.packageName,
                      color: getDownloadButtonColor(context, fileBubbleStyle, colorPalette),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Color? getDownloadButtonColor(
      BuildContext context,
      CometChatFileBubbleStyle fileBubbleStyle,
      CometChatColorPalette colorPalette) {
    return fileBubbleStyle.downloadIconTint ??
        (widget.alignment == BubbleAlignment.right
            ? colorPalette.white
            : colorPalette.primary);
  }

  Color? getSubtitleColor(
      BuildContext context,
      CometChatFileBubbleStyle fileBubbleStyle,
      CometChatColorPalette colorPalette) {
    return (fileBubbleStyle.subtitleColor ??
            fileBubbleStyle.subtitleTextStyle?.color) ??
        (widget.alignment == BubbleAlignment.right
            ? colorPalette.white
            : colorPalette.neutral600);
  }

  Color? getTitleColor(
      BuildContext context,
      CometChatFileBubbleStyle fileBubbleStyle,
      CometChatColorPalette colorPalette) {
    return (fileBubbleStyle.titleColor ??
            fileBubbleStyle.titleTextStyle?.color) ??
        (widget.alignment == BubbleAlignment.right
            ? colorPalette.white
            : colorPalette.neutral900);
  }
}
