import 'package:auf/constant.dart';
import 'package:auf/models/default_response_model.dart';
import 'package:auf/models/downline/downline_filter_model.dart';
import 'package:auf/models/downline/list_downline_response_model.dart';
import 'package:auf/models/forgot_password/forgot_password_request_model.dart';
import 'package:auf/models/product/product_model.dart';
import 'package:auf/models/report/sales_by_product_graph_model.dart';
import 'package:auf/models/report/sales_by_product_graph_response_model.dart';
import 'package:auf/models/report/summary_graph_response_model.dart';
import 'package:auf/models/report/monthly_model.dart';
import 'package:auf/models/report/report_header_response_model.dart';
import 'package:auf/models/report/yearly_model.dart';
import 'package:auf/resource/forgot_password_resource.dart';
import 'package:auf/resource/hero_resource.dart';
import 'package:auf/resource/report_resource.dart';
import 'package:auf/services/web_services.dart';

class ReportBloc {
  Future<ReportHeaderResponseModel> getReportHeader(
      ) async {
    return await Webservice.get(ReportResource.getReportHeader());
  }

  Future<SummaryGraphResponseModel> getSummaryGraph(
      {MonthlyModel? monthlyModel, YearlyModel? yearlyModel}) async {
    return await Webservice.get(
      ReportResource.getSummaryGraph(
        monthlyModel ?? MonthlyModel(),
        yearlyModel ?? YearlyModel(),
      ),
    );
  }

  Future<SalesByProductGraphResponseModel> getSalesByProductGraph(
      {required ProductModel productModel, required YearlyModel yearlyModel}) async {
    return await Webservice.get(
        ReportResource.getSalesByProductGraph(productModel, yearlyModel));
  }
}
