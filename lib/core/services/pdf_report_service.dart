import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as p_widget;
import 'package:permission_handler/permission_handler.dart';
import 'package:safe_access/core/values_holder/items_data.dart';
import 'package:safe_access/features/data/entities/responses/events_search_response_model.dart';
import 'package:safe_access/features/presentation/resources/dimensions.dart';
import 'package:safe_access/features/presentation/resources/icons_res.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';
import 'package:safe_access/features/presentation/resources/text_sizes.dart';
import 'package:safe_access/features/presentation/utils/extension.dart';

class PDFReportService {
  Future<Uint8List> createPDFReport(
      List<EventsSearchResponseModel> list) async {
    final p_widget.Document pdf = p_widget.Document();
    final Uint8List image =
        (await rootBundle.load(IconsRes.resultItemCirclePng))
            .buffer
            .asUint8List();
    pdf.addPage(
      p_widget.MultiPage(
        pageFormat: PdfPageFormat(Dimensions.eventSearchItemMinWidth.w + 30,
            (10 * Dimensions.eventSearchItemMinHeight.h) + 30,
            marginAll: 15.0),
        build: (p_widget.Context context) => <p_widget.Widget>[
          ...List<p_widget.Widget>.generate(
            list.length,
            (int index) =>
                //<editor-fold desc="Body">
                p_widget.SizedBox(
              height: Dimensions.eventSearchItemMinHeight.h,
              width: Dimensions.eventSearchItemMinWidth.w,
              child: p_widget.Column(
                crossAxisAlignment: p_widget.CrossAxisAlignment.start,
                children: <p_widget.Widget>[
                  p_widget.Row(
                    children: <p_widget.Widget>[
                      p_widget.Image(
                        p_widget.MemoryImage(image),
                        width: Dimensions.resultIconIcon.w,
                        height: Dimensions.resultIconIcon.w,
                        fit: p_widget.BoxFit.fill,
                      ),
                      p_widget.SizedBox(
                        width: Dimensions.margin8.w,
                      ),
                      p_widget.Text(
                        list[index].alertDetails?.project?.name ?? ''.tr(),
                        textAlign: p_widget.TextAlign.left,
                        style: p_widget.TextStyle(
                          color: const PdfColor(0, 0, 0),
                          fontSize: TextSizes.sp15.sp,
                          fontWeight: p_widget.FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  p_widget.SizedBox(
                    height: Dimensions.margin5.h,
                  ),
                  p_widget.Text(
                    list[index].createDate != null
                        ? list[index].createDate!.formattedDate.tr()
                        : 'N/A',
                    textAlign: p_widget.TextAlign.left,
                    style: p_widget.TextStyle(
                      color: const PdfColor(0, 0, 0),
                      fontSize: TextSizes.sp13.sp,
                      fontWeight: p_widget.FontWeight.bold,
                    ),
                  ),
                  p_widget.SizedBox(
                    height: Dimensions.margin12.h,
                  ),
                  p_widget.Text(
                    '${ItemsData.classifications.nameClassification(list[index].classifications?.id).tr()}, ${list[index].personsProjects?.employer?.name ?? ''} ',
                    textAlign: p_widget.TextAlign.left,
                    style: p_widget.TextStyle(
                      color: const PdfColor(0.69, 0.69, 0.69),
                      fontSize: TextSizes.sp13.sp,
                      fontWeight: p_widget.FontWeight.normal,
                    ),
                  ),
                  p_widget.SizedBox(
                    height: Dimensions.margin5.h,
                  ),
                  p_widget.Row(
                    children: <p_widget.Widget>[
                      p_widget.Text(
                        StringsRes.camera.tr(),
                        textAlign: p_widget.TextAlign.left,
                        style: p_widget.TextStyle(
                          color: const PdfColor(0, 0, 0),
                          fontSize: TextSizes.sp13.sp,
                          fontWeight: p_widget.FontWeight.normal,
                        ),
                      ),
                      p_widget.Text(
                        '${list[index].alertDetails?.hardware?.identifier} ${list[index].alertDetails?.hardware?.serialNumber}'
                            .tr(),
                        textAlign: p_widget.TextAlign.left,
                        style: p_widget.TextStyle(
                          color: const PdfColor(0, 0, 0),
                          fontSize: TextSizes.sp13.sp,
                          fontWeight: p_widget.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  p_widget.SizedBox(
                    height: Dimensions.margin5.h,
                  ),
                  p_widget.Text(
                    list[index].alertDetails.address.tr(),
                    textAlign: p_widget.TextAlign.left,
                    style: p_widget.TextStyle(
                      color: const PdfColor(0.69, 0.69, 0.69),
                      fontSize: TextSizes.sp13.sp,
                      fontWeight: p_widget.FontWeight.normal,
                    ),
                  ),
                  p_widget.SizedBox(
                    height: Dimensions.margin8.h,
                  ),
                  p_widget.Text(
                    '${list[index].person?.firstName ?? ''} ${list[index].person?.surname ?? ''}',
                    textAlign: p_widget.TextAlign.left,
                    style: p_widget.TextStyle(
                      color: const PdfColor(0, 0, 0),
                      fontSize: TextSizes.sp13.sp,
                      fontWeight: p_widget.FontWeight.bold,
                    ),
                  ),
                  p_widget.SizedBox(
                    height: Dimensions.margin5.h,
                  ),
                  p_widget.Text(
                    list[index].person?.firstName != null
                        ? '${list[index].person?.identificationNumber ?? ''}, ${list[index].personsProjects?.position?.name ?? ''}, ${list[index].personsProjects?.employer?.name ?? ''}'
                        : '',
                    textAlign: p_widget.TextAlign.left,
                    style: p_widget.TextStyle(
                      color: const PdfColor(0.69, 0.69, 0.69),
                      fontSize: TextSizes.sp13.sp,
                      fontWeight: p_widget.FontWeight.normal,
                    ),
                  ),
                  p_widget.Container(
                    width: Dimensions.dividerWidth.w,
                    margin: p_widget.EdgeInsets.only(
                      top: Dimensions.margin8.h,
                      bottom: Dimensions.margin13.h,
                    ),
                    decoration: const p_widget.BoxDecoration(
                      border: p_widget.Border(
                        bottom: p_widget.BorderSide(
                            color: PdfColor(0.72, 0.72, 0.72), width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //</editor-fold>
          ),
        ],
      ),
    );
    return pdf.save();
  }

  Future<void> savePdfFile(
      {required Uint8List byteList, required int count}) async {
    await _getStoragePermission().then((bool isGranted) async {
      if (isGranted) {
        await FileSaver.instance.saveAs(
            'Events(count: $count): ${DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now().toLocal())}',
            byteList,
            '.pdf',
            MimeType.PDF);
      }
    });
  }

  Future<bool> _getStoragePermission() =>
      Permission.storage.request().isGranted;
}
