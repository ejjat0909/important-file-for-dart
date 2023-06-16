import 'dart:convert';

import 'package:auf/models/default_response_model.dart';
import 'package:auf/models/forgot_password/forgot_password_request_model.dart';
import 'package:auf/models/product/product_model.dart';
import 'package:auf/models/report/sales_by_product_graph_response_model.dart';
import 'package:auf/models/report/summary_graph_model.dart';
import 'package:auf/models/report/summary_graph_response_model.dart';
import 'package:auf/models/report/monthly_model.dart';
import 'package:auf/models/report/report_header_model.dart';
import 'package:auf/models/report/report_header_response_model.dart';
import 'package:auf/models/report/yearly_model.dart';
import 'package:auf/services/resource.dart';
import 'package:get_it/get_it.dart';

class ReportResource {
  static Resource getReportHeader() {
    return Resource(
        url: 'report',
        parse: (response) {
          return ReportHeaderResponseModel(json.decode(response.body));
        });
  }

  static Resource getSummaryGraph(MonthlyModel monthlyModel, YearlyModel yearlyModel) {
    return Resource(
        url: 'report/summary',
        params: {
          'month': monthlyModel.month,
          'year': yearlyModel.year,
        },
        parse: (response) {
          return SummaryGraphResponseModel(json.decode(response.body));
        });
  }

  static Resource getSalesByProductGraph(ProductModel productModel, YearlyModel yearlyModel) {
    return Resource(
        url: 'report/sales-by-product/${productModel.id.toString()}',
         params: {
          'year': yearlyModel.year,
        },
        parse: (response) {
          return SalesByProductGraphResponseModel(json.decode(response.body));
        });
  }

  // Save report header model to GetIt to retrieve the model faster and easier when needed
  static setGetItHeaderModel(ReportHeaderModel reportHeaderModel) {
    if (!GetIt.instance.isRegistered<ReportHeaderModel>()) {
      GetIt.instance.registerSingleton<ReportHeaderModel>(reportHeaderModel);
    } else {
      GetIt.instance.unregister<ReportHeaderModel>();
      GetIt.instance.registerSingleton<ReportHeaderModel>(reportHeaderModel);
    }
  }

  // Save commission graph model to GetIt to retrieve the model faster and easier when needed
  static setGetItCommissionGraphModel(SummaryGraphModel commissionGraphModel) {
    if (!GetIt.instance.isRegistered<SummaryGraphModel>()) {
      GetIt.instance.registerSingleton<SummaryGraphModel>(commissionGraphModel);
    } else {
      GetIt.instance.unregister<SummaryGraphModel>();
      GetIt.instance.registerSingleton<SummaryGraphModel>(commissionGraphModel);
    }
  }

  // Save commission graph model to GetIt to retrieve the model faster and easier when needed
  static setGetItMonthYear(List<MonthlyModel> listMonthYear) {
    if (!GetIt.instance.isRegistered<List<MonthlyModel>>()) {
      GetIt.instance.registerSingleton<List<MonthlyModel>>(listMonthYear);
    } else {
      GetIt.instance.unregister<List<MonthlyModel>>();
      GetIt.instance.registerSingleton<List<MonthlyModel>>(listMonthYear);
    }
  }
}
